\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis-tobias}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[10pt,oneside]{book}

\RequirePackage{mathtools}  % Mathematical tools to use with amsmath
\RequirePackage{amssymb}    % Extended symbol collection
\RequirePackage{siunitx}    % Comprehensive (SI) units package

\RequirePackage{tabularx}   % Tabulars with adjustable-width columns
\RequirePackage{booktabs}   % Publication quality tables
\RequirePackage{longtable}  % Allow tables to flow over page boundaries
\RequirePackage{multirow}   % Create tabular cells spanning multiple rows

\RequirePackage{graphicx}   % Enhanced support for images
\RequirePackage{float}      % Improved interface for floating objects
\RequirePackage[labelfont=bf,justification=centering,footnotesize]{caption} % Captions
\RequirePackage{subcaption} % Support for sub-captions
\RequirePackage{pdfpages}   % Include PDF documents

\RequirePackage[pdfusetitle,hidelinks]{hyperref} % Extensive support for hypertext
\RequirePackage[noabbrev]{cleveref} % Intelligent cross-referencing
\RequirePackage{xcolor}     % Driver-independent color extensions
\RequirePackage{tikz}       % Create PostScript and PDF graphics
\RequirePackage{xspace}     % Define commands that appear not to eat spaces
\RequirePackage{microtype}  % Refinements towards typographical perfection

\RequirePackage{geometry}   % Customize document dimensions
\RequirePackage{titlesec}   % Select alternative section titles
\RequirePackage{titletoc}   % Alternative headings for toc
\RequirePackage{fancyhdr}   % Control of page headers and footers
\RequirePackage{enumitem}   % Control layout of itemize, enumerate, description
\RequirePackage{etoolbox}   % Toolbox of programming facilities
\RequirePackage{iftex}      % Adds if-else statements to support multiple compilers
\RequirePackage{datetime}   % Change format of \today

%% Establish commands for the subtitle, subject, affiliation, cover image and table of authors
\newcommand*{\subtitle}[1]{\def\@subtitle{#1}}
\newcommand*{\subject}[1]{\def\@subject{#1}}
\newcommand*{\affiliation}[1]{\def\@affiliation{#1}}
\newcommand*{\coverimage}[1]{\def\@coverimage{#1}}
\newcommand*{\covertable}[1]{\def\@covertable{#1}}

\newcommand*{\LatestVersion}[1]{\def\@LatestVersion{#1}}

%\newcommand\frontmatter{%
%	\cleardoublepage
%	\@mainmatterfalse}
%	%	\pagenumbering{roman}}
%
%\newcommand\mainmatter{%
%	\cleardoublepage
%	\@mainmattertrue
%	%	\pagenumbering{arabic}}
%
%\newcommand\backmatter{%
%	\if@openright
%	\cleardoublepage
%	\else
%	\clearpage
%	\fi
%	\@mainmatterfalse}

%% Scale the margins to be slightly smaller than default (.7)
\geometry{a4paper,hscale=0.75,vscale=0.8}

\RequirePackage[T1]{fontenc}  % Select T1 font encoding
%\RequirePackage{newpxtext}    % Palatino-like font...
%\RequirePackage{newpxmath}    % ...with support for mathematics

\usepackage{times} 
\usepackage{mathptmx}

\ifPDFTeX
%% With pdfLaTeX, use Paletino as the main font and Roboto Slab as title fonts
\RequirePackage[T1]{fontenc}  % Select T1 font encoding
\RequirePackage{newpxtext}    % Palatino-like font...
\RequirePackage{newpxmath}    % ...with support for mathematics

\newcommand{\titlestyle}{\fontfamily{RobotoSlab-TLF}\fontseries{light}\selectfont}
\newcommand{\largetitlestyle}{\fontfamily{RobotoSlab-TLF}\fontseries{thin}\selectfont}
\else
%% If XeLaTeX or LuaLaTeX is set as the compiler, the TU Delft house style fonts are used (see https://www.tudelft.nl/huisstijl/bouwstenen/typografie).
\RequirePackage[no-math]{fontspec} % Advanced font selection

%% Use Arial as the main font and Roboto Slab as title fonts
\setmainfont{Arial}
\setmathsf{Arial}
\setmathtt{Arial}

\newfontfamily\titlestyle{Roboto Slab Light}
\newfontfamily\largetitlestyle{Roboto Slab Thin}
\fi


%% ----------------------------------------------------------------------
%%    Formatting the titles and table of contents
%% ----------------------------------------------------------------------

%% Format the chapter titles and spacing
\titleformat{\chapter}[display]
{\flushright}
{\fontsize{96}{96}\selectfont\largetitlestyle\thechapter}
{0pt}
{\Huge\titlestyle}
\titlespacing*{\chapter}{0pt}{0pt}{2\baselineskip}

%% Format the section titles and spacing
\titleformat{\section}
{\Large\titlestyle\bfseries}
{\thesection.}
{5pt}
{}
\titlespacing*{\section}{0pt}{\baselineskip}{0pt}

%% Format the subsections titles and spacing
\titleformat{\subsection}
{\large\titlestyle\bfseries}
{\thesubsection.}
{5pt}
{}
\titlespacing*{\subsection}{0pt}{\baselineskip}{0pt}

%% Format the subsubsections titles and spacing
\titleformat{\subsubsection}
{\titlestyle\bfseries}
{}
{0pt}
{}
\titlespacing*{\subsubsection}{0pt}{\bigskipamount}{0pt}

%% Reduce the vertical white space between chapters in the table of contents
\dottedcontents{chapter}[1.5em]{\vspace{0.5\baselineskip}\bfseries}{1.5em}{0pt}

%% ----------------------------------------------------------------------
%%    Formatting the header and footer
%% ----------------------------------------------------------------------

%% Format the header and footer of 'plain' pages
\fancypagestyle{plain}{%
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\fancyfoot[C]{\titlestyle\thepage}}

%% Format the header and footer of 'fancy' pages (based on twoside option)
\if@twoside
\fancyhf{}
\fancyhead[LE,RO]{\titlestyle\thepage}
\fancyhead[RE]{\titlestyle\nouppercase{\leftmark}}
\fancyhead[LO]{\titlestyle\nouppercase{\rightmark}}
\RequirePackage{emptypage} % Remove header and footer on empty pages
\else
\fancyhf{}
\fancyhead[R]{\titlestyle\thepage}
\fancyhead[L]{\titlestyle\nouppercase{\rightmark}}
\fi

\pagestyle{fancy} % Set the package defaults and the additional changes as the style

%% ----------------------------------------------------------------------
%%    Setting up the \makecover command for the cover page
%% ----------------------------------------------------------------------

\newcommand*{\makecover}{
	%% Use the Tikz library positioning and clear the page header and footer
	\usetikzlibrary{positioning}
	\thispagestyle{empty}
	
	%% Construct the cover page with Tikz
	\begin{tikzpicture}[overlay,remember picture]
		
		%% Add the cover image
		\node[above=0,inner sep=0] at (current page.south) {%
			\includegraphics[width=\paperwidth]{\@coverimage}};
		
		%% Add the affiliation on the left
		\node[rotate=90,below left=10mm and 10mm] at (current page.east) {%
			\ifdefvoid{\@affiliation}{}{\color{white}\titlestyle\@affiliation}};
		
		%% Add the logo in the bottom left
		\node[above right=10mm] at (current page.south west) {%
			\includegraphics[width=0.35\linewidth]{figures/Inholland_University_white.png}};
		
		%% Add the banner with the title, subtitle, subject and author(s)
		\node[below=2cm,fill=black!85,minimum width={\paperwidth},inner ysep=25pt,opacity=0.6,text opacity=1] at (current page.north) {%
			\begin{minipage}{0.9\paperwidth}
				%% Format and add the title
				\color{title}\raggedright\largetitlestyle\fontsize{50}{50}\selectfont%
				\@title \\[0.5ex]
				%% Format and add (optional) subtitle and subject
				\color{white}\titlestyle\fontsize{22}{22}\selectfont%
				\ifdefvoid{\@subtitle}{}{\@subtitle \\[2.5ex]}%
				\ifdefvoid{\@subject}{}{\@subject \\[0.5ex]}
				%% Format and add author or table of authors
				\largetitlestyle\fontsize{24}{24}\selectfont%
				\ifdefvoid{\@covertable}{\@author}{\@covertable}
		\end{minipage}};
		
	\end{tikzpicture}
	\newpage
}

%% ----------------------------------------------------------------------
%%    Setting up listings
%% ----------------------------------------------------------------------

\RequirePackage{listings} % Typeset source code listings

\lstset{
	basicstyle=\ttfamily\footnotesize,  % Style of the font that is used for the code
	backgroundcolor=\color{gray!10},    % Background color
	keywordstyle=\color{red!75!black},  % Keyword style
	stringstyle=\color{green!40!black}, % String style
	commentstyle=\color{blue!30!black}, % Comment style
	numbers=left,                       % Add line numbers on the left side
	numbersep=5pt,                      % Decrease distance between line numbers and code
	numberstyle=\tiny,                  % Line number style
	breaklines=true,                    % Line break automatically
}

%% formal box enviroment

\RequirePackage{framed}
\RequirePackage{xcolor}

\definecolor{formalshade}{rgb}{0.95,0.95,0.95}
\definecolor{docgrey}{RGB/cmyk}{200,200,200/0,0,0,.1}
\definecolor{doccolor}{RGB/cmyk}{0,102,179/1,.57,0,.4}
\colorlet{docgray}{docgrey}

\newcommand{\smallcaptext}[1]{\MakeUppercase{\smalltext{#1}}}

\newenvironment{formal}[1][]{%
	\def\FrameCommand{%
		\hspace{1pt}%
		{\color{doccolor}\vrule width 2pt}%
		{\color{formalshade}\vrule width 4pt}%
		\colorbox{formalshade}%
	}%
	\MakeFramed{\advance\hsize-\width\FrameRestore}%
	\noindent\hspace{-4.55pt}% disable indenting first paragraph
	\smallcaptext{\textbf{#1\\\\}}
	\noindent\hspace{-4.55pt}% disable indenting first paragraph
	\leavevmode \begin{adjustwidth}%
		\vspace{10pt}% Adjust this value as needed
	}
	{%
		\vspace{10pt}\end{adjustwidth}\endMakeFramed%
}

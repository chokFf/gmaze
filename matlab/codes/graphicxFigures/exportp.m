% exportp Export a figure to A4 color PDF format
%
% exportp(GCF,[ORIENTATION,FILE,KEEPFOOTNOTE])
%
%   Export a figure GCF to A4 color pdf format
%   Default output file is: 'fig.pdf' in current directory.
%
%   ORIENTATION: Set the orientation of the figure.
%       ORIENTATION=0  : A4 Portrait (default)
%       ORIENTATION=1  : A4 Landscape
%       ORIENTATION=2  : Crop PDF to plot (like eps print)
%       ORIENTATION=40 : A4 Portrait (same as ORIENTATION=0)
%       ORIENTATION=41 : A4 Landscape  (same as ORIENTATION=1)
%       ORIENTATION=30 : A3 Portrait
%       ORIENTATION=31 : A3 Landscape
%       ORIENTATION=20 : A2 Portrait
%       ORIENTATION=21 : A2 Landscape
%
%	FILE: File name as a string. Default is 'fig'. Do not need to
%		specify the .pdf extension.
%
%	KEEPFOOTNOTE is an optionnal parameter:
%		KEEPFOOTNOTE=0 : Print pdf without the footnote.
%		KEEPFOOTNOTE=1 : Keep it (default)
%
% Note:
%	- you don't need to use figure's footnotes for this
%		function to work. To learn more see function 'footnote'.
%	- Informations about the file's name and orientation are stored
%		in the figure datas, so that you can use function 'reexportp'.
%	
% See also:
%	figure_land, figure_tall, footnote, fnote, reexportp, expt
%
% Created: 2009-04-22.
% Rev. by Guillaume Maze on 2011-03-04: Made it stand alone function
% Rev. by Guillaume Maze on 2010-10-21: Add cropped pdf option
% Copyright (c) 2009 Guillaume Maze. 
% http://codes.guillaumemaze.org

%
% This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or any later version.
% This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
% You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
%

function [] = exportp(f,varargin)

if (nargin<1)|(nargin>4)
     help exportp.m
     error('exportp.m : Wrong number or bad parameter(s)')
end %if

%- Default options:

% File name without extension:
fich   = 'fig'; % to produce: 'fig.pdf'

% Figure orientation:
orient = 0; % Portrait
orient_list = [0 1 2 20 21 30 31 40 41];

% Arguments to print command:
pcom = '-dpdf';

% File extension:
ext = 'pdf'; 


% --------------------------------------------
%- 1 optionnal input:
% --------------------------------------------
if (nargin>=2)
	arg = varargin{:};
	% ----------------------
	if ischar(arg)
		fich   = arg;
		orient = 0;
	else
		fich = 'fig';
		if isempty(isin(arg(1),orient_list))
			help exportp.m
			error('exportp.m : Wrong number or bad parameter(s)')
		end %if
		switch arg(1)
			case {0,1}			
				orient = arg(1);
				PaperType = 'A4';
			case 2
				orient = arg(1);
				PaperType = 'A4';
			case {40,41}
				orient = arg(1)-40;
				PaperType = 'A4';
			case {30,31}
				orient = arg(1)-30;
				PaperType = 'A3';
			case {20,21}
				orient = arg(1)-20;
				PaperType = 'A2';
		end %switch
	end %if
	% ----------------------
end %if

% --------------------------------------------
%- 2 optionnal inputs:
% --------------------------------------------
if (nargin>=3)

	arg  = varargin(1); arg=arg{:};
	fich = varargin(2); fich=fich{:};
	if ischar(arg)
		help exportp.m
		error('exportp.m : ORIENTATION must be a numeric value')
	elseif isnumeric(fich)
		help exportp.m
		error('exportp.m : FILE must be a char value')   
	end %if

	% ----------------------
	if isempty(isin(arg(1),orient_list))
		help exportp.m
		error('exportp.m : Wrong number or bad parameter(s)')
	end %if
	switch arg(1)
		case {0,1}
			orient = arg(1);
			PaperType = 'A4';
		case 2
			orient = arg(1);
			PaperType = 'A4';
		case {30,31}
			orient = arg(1)-30;
			PaperType = 'A3';
	end %switch
	% ----------------------

end %if

% --------------------------------------------
%- 3 optionnal inputs:
% --------------------------------------------
if nargin >= 4
	keepfootnote = varargin{3};
else
	keepfootnote = 1;
end


% --------------------------------------------
%- Define Output pdf file name:
outfile = strcat(fich,'.',ext);
outfilenopath = fich(max([1 max(strfind(fich,filesep))+1]):end);

% --------------------------------------------
%- Manage figure size and orientation:
posi = get(f,'Position');

switch PaperType
	case 'A4'
		switch orient
		 case 0 % PORTRAIT
			set(f,'PaperUnits','centimeters','PaperType',PaperType);
			set(f,'PaperPositionMode','manual');
			set(f,'PaperPosition',[1 1 205 290]/10);
			set(f,'PaperOrientation','portrait');
		 case 1 % LANDSCAPE
			set(f,'PaperUnits','centimeters','PaperType',PaperType);
			set(f,'PaperPositionMode','manual');
			set(f,'PaperPosition',[1 1 290 205]/10);
			set(f,'PaperOrientation','landscape');
		 case 2
			set(f,'PaperOrientation','portrait');
		end %case
	case 'A3'
		switch orient
		 case 0 % PORTRAIT
			set(f,'PaperUnits','centimeters','PaperType',PaperType);
			set(f,'PaperPositionMode','manual');
			set(f,'PaperPosition',[1 1 287 410]/10);
			set(f,'PaperOrientation','portrait');
		 case 1 % LANDSCAPE
			set(f,'PaperUnits','centimeters','PaperType',PaperType);
			set(f,'PaperPositionMode','manual');
			set(f,'PaperPosition',[1 1 410 287]/10);
			set(f,'PaperOrientation','landscape');
		 case 2
			set(f,'PaperOrientation','portrait');
		end %case
	case 'A2'
		switch orient
		 case 0 % PORTRAIT
			set(f,'PaperUnits','centimeters','PaperType',PaperType);
			set(f,'PaperPositionMode','manual');
			set(f,'PaperPosition',[10 10 420-10 594-10]/10);
			set(f,'PaperOrientation','portrait');
		 case 1 % LANDSCAPE
			set(f,'PaperUnits','centimeters','PaperType',PaperType);
			set(f,'PaperPositionMode','manual');
			set(f,'PaperPosition',[10 10 594-10 420-10]/10);
			set(f,'PaperOrientation','landscape');
		 case 2
			set(f,'PaperOrientation','portrait');
		end %case
end% switch 


% --------------------------------------------
%- Read the footnote:
% For those who are not using the footnote function
% don't worry, exportp still works without it.
ft = findobj(f,'tag','footnotetext');
if isempty(ft)
	try
		% Create a simple footnote with the time
		footnote(sprintf('Printed: %s',datestr(now)));
		ft = findobj(f,'tag','footnotetext');	
		rmft = true; % Do we remove the footnote afterward ?
	catch	
		rmft = false;
	end
else
	rmft = false;
end

footnoteTXT = get(ft,'string');
if ischar(footnoteTXT)
	for il = 1 : size(footnoteTXT,1) 
		c(il) = {footnoteTXT(il,:)};
	end
	footnoteTXT = c;
end

% --------------------------------------------
%- Eventually add the pdf file name to the footnote:
if  length(footnoteTXT) > 1
	txt = sprintf(' %s',outfile);
	for il = 1 : length(footnoteTXT)
		txt = sprintf('%s\n%s',txt,footnoteTXT{il});
	end
else
	try,txt = sprintf(' %s\n%s',outfile,footnoteTXT{1});end
end

% Update footnote text:
if keepfootnote 
	try,set(findobj(f,'tag','footnotetext'),'string',txt),end
else
	try,delete(findobj(f,'tag','footnotetext')),end
end
try,
	algnfootnote;
end

% --------------------------------------------
%- Manage Note box	
% For those who are not using the fnote function
% don't worry, exportp still works without it.
if ~isempty(findall(f,'tag','notetext'))
%	set(findall(f,'tag','notetext'),'fontsize',10)
	set(findall(f,'tag','note'),'color',[1 1 .7],'box','on','xcolor','k','ycolor','k');	
end% if 

% --------------------------------------------
%- Print out file:
% disp(PaperType)
% disp(pcom) 
% disp(orient) 

switch orient
	case {0,1}
		print(f,pcom,outfile);
	case 2
		% Crop properly the pdf by first printing into eps:
		print(gcf,'-depsc2',sprintf('.%s.eps',outfilenopath));
		try,psfixdashlines(sprintf('.%s.eps',outfilenopath));end	
		command = sprintf('ps2pdf -dEPSCrop .%s.eps %s.pdf',outfilenopath,fich);
		%disp(command);
		[a b]=system(command);
		if ~exist(sprintf('%s.pdf',fich),'file')
			%stophere
			error('An error occurred during the ps2pdf conversion');
		else
			delete(sprintf('.%s.eps',outfilenopath));		
		end% if 
end% switch

try
	disp(sprintf('Figure %i saved in %s',f,outfile));
catch
	disp(sprintf('Figure %i saved in %s',f.Number,outfile));	
end %try
disp(sprintf('!open %s',outfile));

% --------------------------------------------
%- We store in the figure datas informations about the export for later reuse by reexport
exportdatas.file = strcat(fich,'.',ext);
exportdatas.orient = orient;
exportdatas.keepfootnote = keepfootnote;
setappdata(f,'exportdatas',exportdatas);
%setappdata(f,'pdf_file',strcat(fich,'.',ext))
%setappdata(f,'pdf_file_orientation',orient);

% --------------------------------------------
%- Restore figure position and footnote text:
set(f,'Position',posi);
if ~isempty(footnoteTXT)
	footnote('')
	set(findobj(f,'tag','footnotetext'),'string',footnoteTXT)
end

if rmft
	delete(ft)
end

% --------------------------------------------
%- Restore Note box	
if ~isempty(findall(f,'tag','notetext'))
%	set(findall(f,'tag','notetext'),'fontsize',10)
	set(findall(f,'tag','note'),'color',[1 1 .7],'box','off','xcolor','w','ycolor','w');	
end% if

end%function
% --------------------------------------------



% --------------------------------------------
function [] = psfixdashlines(psfile)

	% line types: solid, dotted, dashed, dotdash
%	/SO { [] 0 setdash } bdef
%	/DO { [.5 dpi2point mul 4 dpi2point mul] 0 setdash } bdef
%	/DA { [6 dpi2point mul] 0 setdash } bdef
%	/DD { [.5 dpi2point mul 4 dpi2point mul 6 dpi2point mul 4 dpi2point mul] 0 setdash } bdef
%	For nicer dashed lines, change the '6' in the '/DA' line to 2. You
%	can make nicer dotted lines by changing the '4' in the '/DO' line to 2,
%	and I'll let you experiment with DD lines...
		
	% Read the file until we find the right line:
	fstrrep(psfile, '/DA { [6 dpi2point mul] 0 setdash } bdef',...
					'/DA { [2 dpi2point mul] 0 setdash } bdef');
	
end%function
















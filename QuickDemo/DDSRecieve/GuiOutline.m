function GuiOutline
global S
S.fh = figure('units','pixels',...
    'position',[100 200 1050 500],...
    'menubar','none',...
    'name','SensorDemo',...
    'numbertitle','off',...
    'resize','off');

S.Data1 = uicontrol('style','text',...                                          %Creating Pulse Ox Title
    'unit','pix',...
    'position',[350 100 170 55],...
    'ForegroundColor','blue',...
    'fontsize',40,'HorizontalAlignment','center',...
    'string','HR=00');
S.Data2 = uicontrol('style','text',...                                          %Creating Pulse Ox Title
    'unit','pix',...
    'position',[389 430 130 55],...
    'ForegroundColor','green',...
    'fontsize',40,'HorizontalAlignment','center',...
    'string','X=00');
S.Data3 = uicontrol('style','text',...                                          %Creating Pulse Ox Title
    'unit','pix',...
    'position',[389 350 130 55],...
    'ForegroundColor','blue',...
    'fontsize',40,'HorizontalAlignment','center',...
    'string','Y=00');
S.Data4 = uicontrol('style','text',...                                          %Creating Pulse Ox Title
    'unit','pix',...
    'position',[389 270 130 55],...
    'ForegroundColor','red',...
    'fontsize',40,'HorizontalAlignment','center',...
    'string','Z=00');

S.Stop = uicontrol('style','push',...
    'units','pix',...
    'position',[750, 10 180 40],...
    'HorizontalAlign','left',...
    'string','Stop and Close',...
    'fontsize',10,'fontweight','bold',...
    'callback',{@stopandclose,S});

figure(S.fh);
temp = VideoMat();
axes('position',[0 .485 .350 .500]);
S.video = imagesc(temp.Vidhandle);
axis image;
colormap(gray);
set(gca,'xtick',[],'ytick',[]);


axes('position',[.01 .01 .300 .450]);
S.hist = image(abs(fft(temp.Vidhandle)));

plotx = ones(1,500);
axes('position',[.52 .53 .47 .450]);
S.X = plot(plotx,'g');
set(gca,'xtick',[]);

axes('position',[.52 .03 .47 .450]);
pulse = ones(1,500);
S.HR = plot(pulse,'black');
set(gca,'xtick',[]);

assignin('base','plotx',plotx);;
assignin('base','pulse',pulse);

function stopandclose(varargin)   
global S %#ok<NUSED>
close('SensorDemo')%close the MainDisp Gui
evalin('base','stop(AnalogValRead)');
evalin('base','delete(AnalogValRead)');
evalin('base','clear AnalogValRead');

evalin('base','stop(RXRead)');
evalin('base','delete(RXRead)');
evalin('base','clear RXRead');
evalin('base','clear dp');
clear S
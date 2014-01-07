function GuiOutline
global S
S.fh = figure('units','pixels',...
    'position',[100 200 1050 500],...
    'menubar','none',...
    'name','Supervisor',...
    'numbertitle','off',...
    'resize','off');

S.Data1 = uicontrol('style','text',...                                          %Creating Pulse Ox Title
    'unit','pix',...
    'position',[350 100 170 55],...
    'ForegroundColor','blue',...
    'fontsize',20,'HorizontalAlignment','center',...
    'string','HR=000');
S.Data2 = uicontrol('style','text',...                                          %Creating Pulse Ox Title
    'unit','pix',...
    'position',[389 430 140 55],...
    'ForegroundColor','green',...
    'fontsize',20,'HorizontalAlignment','center',...
    'string','X=0.00000');
S.Data3 = uicontrol('style','text',...                                          %Creating Pulse Ox Title
    'unit','pix',...
    'position',[389 350 140 55],...
    'ForegroundColor','blue',...
    'fontsize',20,'HorizontalAlignment','center',...
    'string','Y=0.00000');
S.Data4 = uicontrol('style','text',...                                          %Creating Pulse Ox Title
    'unit','pix',...
    'position',[389 270 140 55],...
    'ForegroundColor','red',...
    'fontsize',20,'HorizontalAlignment','center',...
    'string','Z=0.00000');

S.Stop = uicontrol('style','push',...
    'units','pix',...
    'position',[750, 10 180 40],...
    'HorizontalAlign','left',...
    'string','Stop and Close',...
    'fontsize',10,'fontweight','bold',...
    'callback',{@stopandclose,S});

figure(S.fh);
temp = DIMT_NumericObsVal();
axes('position',[0 .485 .350 .500]);
S.video = imagesc(temp.value.video);
axis image;
colormap(gray);
set(gca,'xtick',[],'ytick',[]);


axes('position',[.01 .01 .300 .450]);
S.hist = image(abs(fft(temp.value.video)));

plotx = ones(1,500)*.5;
axes('position',[.52 .53 .47 .450]);
S.X = plot(plotx,'g');
set(gca,'xtick',[]);

axes('position',[.52 .03 .47 .450]);
pulse = ones(1,500);
S.HR = plot(pulse,'black');
set(gca,'xtick',[]);

assignin('base','plotx',plotx);
assignin('base','pulse',pulse);

function stopandclose(varargin)   
global S %#ok<NUSED>
close('Supervisor')
evalin('base','stop(RXRead1)');
evalin('base','delete(RXRead1)');
evalin('base','clear RXRead1');
evalin('base','stop(RXRead2)');
evalin('base','delete(RXRead2)');
evalin('base','clear RXRead2');
evalin('base','clear dp');

clear S
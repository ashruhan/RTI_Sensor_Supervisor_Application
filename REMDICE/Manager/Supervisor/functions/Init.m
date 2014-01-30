function Init

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
    'string','HR=00');
S.Data2 = uicontrol('style','text',...                                          %Creating Pulse Ox Title
    'unit','pix',...
    'position',[389 430 130 55],...
    'ForegroundColor','green',...
    'fontsize',20,'HorizontalAlignment','center',...
    'string','X:00');
S.Data3 = uicontrol('style','text',...                                          %Creating Pulse Ox Title
    'unit','pix',...
    'position',[389 350 130 55],...
    'ForegroundColor','blue',...
    'fontsize',20,'HorizontalAlignment','center',...
    'string','Y:00');
S.Data4 = uicontrol('style','text',...                                          %Creating Pulse Ox Title
    'unit','pix',...
    'position',[389 270 130 55],...
    'ForegroundColor','red',...
    'fontsize',20,'HorizontalAlignment','center',...
    'string','Z:00');

S.Stop = uicontrol('style','push',...
    'units','pix',...
    'position',[750, 10 180 40],...
    'HorizontalAlign','left',...
    'string','Stop and Close',...
    'fontsize',10,'fontweight','bold',...
    'callback',{@stopandclose,S});

% figure(S.fh);
temp = DIMT_NumericObsVal();
axes('position',[0 .485 .350 .500]);
S.video = imagesc(temp.value.video);
axis image;
colormap(gray);
set(gca,'xtick',[],'ytick',[]);


axes('position',[.01 .01 .300 .450]);
S.hist = image(abs(fft(temp.value.video)));

plotx = ones(1,500)./2;
axes('position',[.52 .53 .47 .450]);
S.X = plot(plotx,'g');
set(gca,'xtick',[]);

axes('position',[.52 .03 .47 .450]);
pulse = ones(1,70);
S.HR = plot(pulse,'blue');
set(gca,'xtick',[]);


assignin('base','VideoMat',VideoMat);
assignin('base','dev_Video_Frame',DIMT_NumericObsVal);
assignin('base','Pulse',DIMT_NumericObsVal());
assignin('base','aX',DIMT_NumericObsVal());
assignin('base','aY',DIMT_NumericObsVal());
assignin('base','aZ',DIMT_NumericObsVal());
vid_handle = imaq.VideoDevice('winvideo', 1);
set(vid_handle, 'ReturnedDataType','uint8')
assignin('base','vid_handle',vid_handle);
assignin('base','S',S);
assignin('base','plotx',plotx);
assignin('base','pulse',pulse);

function stopandclose(varargin)   
close('Supervisor')%close the MainDisp Gui
% evalin('base','release(vid_handle)');
% evalin('base','stop(Sensors)');
% evalin('base','delete(Sensors)');
% evalin('base','stop(Devices)');
% evalin('base','delete(Devices)');
evalin('base','stop(Supervisor)');
evalin('base','delete(Supervisor)');
evalin('base','clear dp');



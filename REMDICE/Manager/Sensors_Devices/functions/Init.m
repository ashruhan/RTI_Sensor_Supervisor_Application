%% Init 
% This function contains a GUI that represent data on the topic and type
% that the supervisor is subscribed to as well as initializing data
% structures that will save data for a set time. 
function Init
S.fh = figure('units','pixels',...
    'position',[500 500 400 100],...
    'menubar','none',...
    'name','Supervisor',...
    'numbertitle','off',...
    'resize','off');

S.Stop = uicontrol('style','push',...
    'units','pix',...
    'position',[110, 35 180 40],...
    'HorizontalAlign','left',...
    'string','Stop and Close',...
    'fontsize',10,'fontweight','bold',...
    'callback',{@stopandclose,S});

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

% (sense t1 and IBI) Values are used in the pulse calculation
sense = false;
t1 = 0;
IBI = zeros(1,70);

assignin('base','IBI',IBI);
assignin('base','t1',t1);
assignin('base','sense',sense);


function stopandclose(varargin)   
close('Supervisor')
evalin('base','release(vid_handle)');
evalin('base','stop(Sensors)');
evalin('base','delete(Sensors)');
evalin('base','stop(Devices)');
evalin('base','delete(Devices)');
evalin('base','clear dp');



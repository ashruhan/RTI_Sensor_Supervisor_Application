%% Setting up DDS requirments to publish frames;

dp = DDS.DomainParticipant(...
    'DocBox_Library::dim15_MDPnP_Profile', 0);
dp.addWriter('VideoMat', 'VideoMat_TOPIC');

VideoMat = VideoMat();
assignin('base','VideoMat',VideoMat);
%% Setting up the video Stream
vid = imaq.VideoDevice('winvideo', 1);
set(vid, 'ReturnedDataType','uint8')

%% Setting up timer 

ValRead=timer('Period',.1, 'ExecutionMode', 'fixedSpacing', 'BusyMode', 'drop');
ValRead.TimerFcn = {@VideoDDS_TX,vid,dp};
start(ValRead);
releaseCam
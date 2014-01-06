%% Get it
%% Setting up Readers 
dp = DDS.DomainParticipant(...
    'DocBox_Library::dim15_MDPnP_Profile', 0);

%Digital Voltage stream
dp.addReader('VideoMat', 'VideoMat_TOPIC');
dp.Subscribers(1).Readers(1).ReadTake = ReadMethodType.TAKE;

dp.addWriter('DIMT_NumericObsVal', 'DIMT_NumericObsValTopic'); 

assignin('base','VideoFrame',DIMT_NumericObsVal());

%% Setting up timer 

%Digital Voltage stream sampling @ 2KHz
VideoRead=timer('Period',.1, 'ExecutionMode', 'fixedSpacing', 'BusyMode', 'queue');
VideoRead.TimerFcn = {@Video, dp};

% Start Timers
start(VideoRead)

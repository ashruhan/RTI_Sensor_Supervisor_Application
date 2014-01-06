%% Get it
GuiOutline
%% Setting up Readers 
dp = DDS.DomainParticipant(...
    'DocBox_Library::dim15_MDPnP_Profile', 0);

%Digital Voltage stream
dp.addReader('SensorADCVoltage','SensorADCVoltage');
dp.Subscribers(1).Readers(1).ReadTake = ReadMethodType.TAKE;


dp.addReader('VideoMat', 'VideoMat_TOPIC'); 
dp.Subscribers(1).Readers(2).ReadTake = ReadMethodType.TAKE;
%% Setting up timer 

RXRead=timer('Period',.1, 'ExecutionMode', 'fixedDelay', 'BusyMode', 'queue');
RXRead.TimerFcn = {@VideoDDS_RX,dp};
start(RXRead)

%Digital Voltage stream sampling @ 2KHz
AnalogValRead=timer('Period',.002, 'ExecutionMode', 'fixedSpacing', 'BusyMode', 'queue');
AnalogValRead.TimerFcn = {@SensorADC, dp};

% Start Timers
start(AnalogValRead)

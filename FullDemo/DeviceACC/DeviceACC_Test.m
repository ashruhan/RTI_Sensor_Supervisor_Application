 %% Get it
%% Setting up Readers 
dp = DDS.DomainParticipant(...
    'DocBox_Library::dim15_MDPnP_Profile', 0);

%Digital Voltage stream
dp.addReader('SensorADCVoltage','Example SensorADCVoltage');
dp.Subscribers(1).Readers(1).ReadTake = ReadMethodType.TAKE;

dp.addWriter('DIMT_NumericObsVal', 'DIMT_NumericObsValTopic');

%% Setting up timer 

%Digital Voltage stream sampling @ 2KHz
AnalogValRead=timer('Period',.002, 'ExecutionMode', 'fixedSpacing', 'BusyMode', 'queue');
AnalogValRead.TimerFcn = {@SensorADC, dp};

% Start Timers
start(AnalogValRead)

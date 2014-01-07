%% Get it
%% Setting up Readers 
dp = DDS.DomainParticipant(...
    'DocBox_Library::dim15_MDPnP_Profile', 0);

%Digital Voltage stream
dp.addReader('SensorADCVoltage','HeartRate');
dp.Subscribers(1).Readers(1).ReadTake = ReadMethodType.TAKE;

dp.addWriter('DIMT_NumericObsVal', 'DIMT_NumericObsValTopic'); 

assignin('base','Pulse',DIMT_NumericObsVal());


%% Setting up Values
sense = false;
t1 = 0;
IBI = zeros(1,70);

assignin('base','IBI',IBI);
assignin('base','t1',t1);
assignin('base','sense',sense);

%% Setting up timer 

%Digital Voltage stream sampling @ 2KHz
AnalogValRead=timer('Period',.002, 'ExecutionMode', 'fixedSpacing', 'BusyMode', 'queue');
AnalogValRead.TimerFcn = {@SensorADC, dp};

% Start Timers
start(AnalogValRead)

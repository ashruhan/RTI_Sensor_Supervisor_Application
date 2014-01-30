%% s
Init;
%%
dp_profile = 'DocBox_Library::dim15_MDPnP_Profile';
domain_number = 0;
Supervisor_topic = 'DIMT_NumericObsVal';
Video_topic = 'VideoMat';
Sensor_topic = 'SensorADCVoltage';

dp = DDS.DomainParticipant(dp_profile , domain_number);


dp.addWriter(Video_topic, Video_topic);
dp.addWriter(Supervisor_topic, Supervisor_topic); 

dp.addReader(Supervisor_topic,Supervisor_topic);
dp.Subscribers(1).Readers(1).ReadTake = ReadMethodType.TAKE; 

dp.addReader(Video_topic, Video_topic);
dp.Subscribers(1).Readers(2).ReadTake = ReadMethodType.TAKE;

dp.addReader(Sensor_topic,Sensor_topic);
dp.Subscribers(1).Readers(3).ReadTake = ReadMethodType.TAKE;
assignin('base','dp',dp);
pause(1);
%% % Start Timers
% 
Sensors=timer('Period',.1, 'ExecutionMode', 'fixedSpacing', 'BusyMode', 'queue');
Sensors.TimerFcn = {@Sensor_ex,dp};
start(Sensors);

Devices=timer('Period',.1, 'ExecutionMode', 'fixedSpacing', 'BusyMode', 'queue');
Devices.TimerFcn = {@Devices_ex, dp};
start(Devices)
%  
% Supervisor = timer('Period',.1, 'ExecutionMode', 'fixedSpacing', 'BusyMode', 'queue');
% Supervisor.TimerFcn = {@Supervisor_ex, dp};
% start(Supervisor)
%% Matlab Initial Values
% Refer to Init.m for futher explanation
Init;
%% DDS Initial values
% Newer ML versions have Identifiers for the dp library and profile.
% The Supervisor acts only as a source in this version. Anything that is
% being published under the supervisor topic will be avalable to read.
dp_profile = 'DocBox_Library::REMDICE_Supervisor_Profile';
domain_number = 0;
Supervisor_topic = 'DIMT_NumericObsVal';
Video_topic = 'VideoMat';
Sensor_topic = 'SensorADCVoltage';

dp = DDS.DomainParticipant(dp_profile , domain_number);
% domain partitipant Writters
dp.addWriter(Video_topic, Video_topic);
dp.addWriter(Supervisor_topic, Supervisor_topic); 
% domain partitipant end Writters

% domain partitipant Readers
dp.addReader(Supervisor_topic,Supervisor_topic);
dp.Subscribers(1).Readers(1).ReadTake = ReadMethodType.TAKE; 

dp.addReader(Video_topic, Video_topic);
dp.Subscribers(1).Readers(2).ReadTake = ReadMethodType.TAKE;

dp.addReader(Sensor_topic,Sensor_topic);
dp.Subscribers(1).Readers(3).ReadTake = ReadMethodType.TAKE;
% domain partitipant end Readers

assignin('base','dp',dp);

% using the pause function so the timers do not execute a reader and or
% writter before they are fully setup.
pause(1);
%% Timer Initialization
% ML currently does not support listeners, in its place we create timers
% that poll the DDS domain and search for data.
 
Sensors=timer('Period',.1, 'ExecutionMode', 'fixedSpacing', 'BusyMode', 'queue');
Sensors.TimerFcn = {@Sensor_ex,dp};
start(Sensors);

Devices=timer('Period',.1, 'ExecutionMode', 'fixedSpacing', 'BusyMode', 'queue');
Devices.TimerFcn = {@Devices_ex, dp};
start(Devices)

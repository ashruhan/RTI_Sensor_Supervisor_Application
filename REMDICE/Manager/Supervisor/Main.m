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

dp = DDS.DomainParticipant(dp_profile , domain_number);
% domain partitipant Readers
dp.addReader(Supervisor_topic,Supervisor_topic);
dp.Subscribers(1).Readers(1).ReadTake = ReadMethodType.TAKE; 
% domain partitipant end Readers
assignin('base','dp',dp);

%% Timer Initialization
% ML currently does not support listeners, in its place we create timers
% that poll the DDS domain and search for data.

Supervisor = timer('Period',.1, 'ExecutionMode', 'fixedSpacing', 'BusyMode', 'queue');
Supervisor.TimerFcn = {@Supervisor_ex, dp};
start(Supervisor)
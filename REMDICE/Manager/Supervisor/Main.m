%% s
Init;
%%
dp_profile = 'DocBox_Library::dim15_MDPnP_Profile';
domain_number = 0;
Supervisor_topic = 'DIMT_NumericObsVal';
dp = DDS.DomainParticipant(dp_profile , domain_number);
dp.addReader(Supervisor_topic,Supervisor_topic);
dp.Subscribers(1).Readers(1).ReadTake = ReadMethodType.TAKE; 
assignin('base','dp',dp);
Supervisor = timer('Period',.1, 'ExecutionMode', 'fixedSpacing', 'BusyMode', 'queue');
Supervisor.TimerFcn = {@Supervisor_ex, dp};
start(Supervisor)
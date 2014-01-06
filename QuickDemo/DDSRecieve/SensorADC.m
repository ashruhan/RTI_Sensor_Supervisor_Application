function SensorADC(~,~,dp)

global S
[DigVoltage, ~]=dp.Subscribers(1).Readers(1).read();
% ACCxyz = evalin('base', 'ACCxyz');
if (~isempty(DigVoltage))
    
    dVolt = DigVoltage;
    
HR = dVolt(1).value(1,1);
aX = dVolt(1).value(1,2)/4096;
aY = dVolt(1).value(1,3)/4096;
aZ = dVolt(1).value(1,4)/4096;

HRString = strcat('X=',num2str(HR));
set(S.Data1,'str',{HRString});
%refreshdata(S.Data1,'caller')

aXString = strcat('X=',num2str(aX));
set(S.Data2,'str',{aXString});
%refreshdata(S.Data2,'caller')

aYString = strcat('X=',num2str(aY));
set(S.Data3,'str',{aYString});
%refreshdata(S.Data3,'caller')

aZString = strcat('X=',num2str(aZ));
set(S.Data4,'str',{aZString});
%refreshdata(S.Data4,'caller')


plotx = evalin('base','plotx');
pulse = evalin('base','pulse');

for m = 1:(length(plotx)-1);
    plotx(1,m) = plotx(1,m+1);
    pulse(1,m) = pulse(1,m+1);
end

plotx(1,length(plotx)) = dVolt(1).value(1,2)/4096;
pulse(1,length(pulse)) = dVolt(1).value(1,1);

set(S.X,'YData',plotx);
refreshdata(S.X,'caller')

set(S.HR,'YData',pulse);
refreshdata(S.HR,'caller')

assignin('base','plotx',plotx);
assignin('base','pulse',pulse);
end
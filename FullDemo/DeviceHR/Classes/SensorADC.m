function SensorADC(~,~,dp)

[DigVoltage, ~]=dp.Subscribers(1).Readers(1).read();
% ACCxyz = evalin('base', 'ACCxyz');
if (~isempty(DigVoltage))
    dVolt = DigVoltage;
    
if strcmp('Pulse',dVolt(1).usi)
Pulse = evalin('base','Pulse');
Pulse.value.metric_id = 243;
Pulse.value.value = dVolt(1).value;
dp.write(Pulse);
end

end

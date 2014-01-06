function SensorADC(~,~,dp)

[DigVoltage, ~]=dp.Subscribers(1).Readers(1).read();
% ACCxyz = evalin('base', 'ACCxyz');
if (~isempty(DigVoltage))
    
    dVolt = DigVoltage;
 if strcmp('Accxyz',dVolt(1).usi)   
aX = evalin('base','aX');
aX.value.metric_id = 253;
aX.value.value = dVolt(1).value(1,1)/4096;
aY = evalin('base','aY');    
aY.value.metric_id = 254;
aY.value.value = dVolt(1).value(1,2)/4096;
aZ = evalin('base','aZ');
aZ.value.metric_id = 255;
aZ.value.value = dVolt(1).value(1,3)/4096;

dp.write(aX);
dp.write(aY);
dp.write(aZ);
 end
end

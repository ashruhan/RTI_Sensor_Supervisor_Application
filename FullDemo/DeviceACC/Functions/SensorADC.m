function SensorADC(~,~,dp)

[DigVoltage, ~]=dp.Subscribers(1).Readers(1).read();

if (~isempty(DigVoltage))
    
    dVolt = DigVoltage;
    for sen = 1:length(dVolt)
        if strcmp('Accxyz',dVolt(sen).usi)
            
            aX = DIMT_NumericObsVal();
            aY = DIMT_NumericObsVal();
            aZ = DIMT_NumericObsVal();
            
            aX.usi = 'Accel X';    
            aX.value.metric_id = 253;
            aX.value.value = dVolt(sen).value(1,1)/4096
            dp.write(aX);
            
            aY.usi = 'Accel Y';
            aY.value.metric_id = 254;
            aY.value.value = dVolt(sen).value(1,2)/4096
            dp.write(aY);
  
            aZ.usi = 'Accel Z';
            aZ.value.metric_id = 255;
            aZ.value.value = dVolt(sen).value(1,3)/4096
            dp.write(aZ);
        end
    end
end

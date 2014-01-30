function Devices_ex(~,~,dp)
[dev_cam_Frame, ~]=dp.Subscribers(1).Readers(2).read();

if (~isempty(dev_cam_Frame))
    
    dev_cam_temp_Frame = dev_cam_Frame;
    
    for m = 1:length(dev_cam_temp_Frame)
        dev_Video_Frame = evalin('base','dev_Video_Frame');
        dev_Video_Frame.value.metric_id = 233;
        dev_Video_Frame.value.video = dev_cam_temp_Frame(m).Vidhandle;
        dp.Publishers.Writers(2).write(dev_Video_Frame);
    end
end

[Sensor_volt, ~]=dp.Subscribers(1).Readers(3).read();

if (~isempty(Sensor_volt))
    
    Sensor_temp_volt = Sensor_volt;
    for M = 1:length(Sensor_temp_volt)
        if strcmp('Accxyz',Sensor_temp_volt(M).usi)
            aX = evalin('base','aX');
            aX.value.metric_id = 253;
            aX.value.value = Sensor_temp_volt(M).value(1,1)/4096;
            aY = evalin('base','aY');
            aY.value.metric_id = 254;
            aY.value.value = Sensor_temp_volt(M).value(1,2)/4096;
            aZ = evalin('base','aZ');
            aZ.value.metric_id = 255;
            aZ.value.value = Sensor_temp_volt(M).value(1,3)/4096;
            
            dp.Publishers.Writers(2).write(aX);
            dp.Publishers.Writers(2).write(aY);
            dp.Publishers.Writers(2).write(aZ);
        end
        
        if strcmp('Pulse',Sensor_temp_volt(M).usi)
            Pulse = evalin('base','Pulse');
            Pulse.value.metric_id = 243;
            Pulse.value.value = Sensor_temp_volt(M).value(1,1);
            dp.Publishers.Writers(2).write(Pulse);
        end
        
    end
end
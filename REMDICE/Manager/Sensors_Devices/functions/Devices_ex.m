%% Devices_ex
% This .m file contains three devices. This was done for timeing purpases.
% In matlab when you create a timer for each device numerious data samples
% are lost, Due to this all devices operate under the same syncrounus
% timer.
function Devices_ex(~,~,dp)
%% Video Device. 
% This device does not need to change any of the data sourced. The data is
% put into a data structure that the supervisor recognizes and publishes
% it.
[dev_cam_Frame, ~]=dp.Subscribers(1).Readers(2).read();
if (~isempty(dev_cam_Frame))
    
    dev_cam_temp_Frame = dev_cam_Frame;
    
    for m = 1:length(dev_cam_temp_Frame)
        dev_Video_Frame = evalin('base','dev_Video_Frame');
        dev_Video_Frame.value.metric_id = uint16(233);
        dev_Video_Frame.value.video = dev_cam_temp_Frame(m).Vidhandle;
        dp.Publishers.Writers(2).write(dev_Video_Frame);
    end
end

[Sensor_volt, ~]=dp.Subscribers(1).Readers(3).read();
if (~isempty(Sensor_volt))
    
    Sensor_temp_volt = Sensor_volt;
    for M = 1:length(Sensor_temp_volt)
%% Accelerometer Device 
% Accelerometer data comes in as a 12 bit digital voltage. The data is then
% normalized by 4096 and put into a data structure that the supervisor
% recognized adn publishes it. 
        if strcmp('Accxyz',Sensor_temp_volt(M).usi)
            aX = evalin('base','aX');
            
            aX.value.metric_id = uint16(253);
            aX.value.value = Sensor_temp_volt(M).value(1,1)/4096;
            aY = evalin('base','aY');
            aY.value.metric_id = uint16(254);
            aY.value.value = Sensor_temp_volt(M).value(1,2)/4096;
            aZ = evalin('base','aZ');
            aZ.value.metric_id = uint16(255);
            aZ.value.value = Sensor_temp_volt(M).value(1,3)/4096;
            
            dp.Publishers.Writers(2).write(aX);
            dp.Publishers.Writers(2).write(aY);
            dp.Publishers.Writers(2).write(aZ);
        end
%% Pulse Device
% The pulse is a true source of data. The data like the accelerometer is
% represented as a 12 bit analog voltage. the algorithms is designed to
% take in the data find the threshold of when a heart beat occurs and logs
% the time. 
        if strcmp('Pulse',Sensor_temp_volt(M).usi)
            thresh = 1500;
            Signal = Sensor_temp_volt(M).value(1,1);
            
            sense = evalin('base','sense');
            
            if Signal > thresh && sense == false
                sense = true;
                assignin('base','sense',sense);
                t1 = evalin('base','t1');
                IBI = evalin('base','IBI');
                
                clk = clock();
                t2 = clk(5)*60 + clk(6);
                Time = t2 - t1;
                t1 = t2;
                assignin('base','t1',t1);
                
                for i = 1:length(IBI)-1;
                    IBI(1,i) = IBI(1,i+1);
                end
                
                IBI(length(IBI)) = Time;
                HR = round(mean(IBI)*100);
                Pulse = evalin('base','Pulse');
                Pulse.value.metric_id = uint16(243);
                Pulse.value.value = HR;
                dp.Publishers.Writers(2).write(Pulse);
                assignin('base','IBI',IBI);
                
            elseif Signal < thresh && sense == true
                sense = false;
                assignin('base','sense',sense);
                return;
                
            else return; 
                
            end 
        end      
    end
end
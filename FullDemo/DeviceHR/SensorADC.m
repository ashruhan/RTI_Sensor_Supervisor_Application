function SensorADC(~,~,dp)
thresh = 1500;
[DigVoltage, ~]=dp.Subscribers(1).Readers(1).read();
% ACCxyz = evalin('base', 'ACCxyz');
if (~isempty(DigVoltage))
    
    dVolt = DigVoltage;
    for sen = 1:length(dVolt)
        if strcmp('Pulse ',dVolt(sen).usi)
            
            Signal = dVolt(sen).value;
            
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
                HR = mean(IBI)*100
                assignin('base','IBI',IBI);
            elseif Signal < thresh && sense == true
                sense = false;
                assignin('base','sense',sense);
                return;
                
            else return;
                
            end
            
            
%             Pulse = evalin('base','Pulse')
%             Pulse.usi = 'Pulse';
%             Pulse.value.metric_id = 243;
%             Pulse.value.value = dVolt(1).value;
%             
%             dp.write(HR);
        end
    end
end

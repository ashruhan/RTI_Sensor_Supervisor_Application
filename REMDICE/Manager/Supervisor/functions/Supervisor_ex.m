function Supervisor_ex(~,~,dp)
[Dev_val, ~]=dp.Subscribers(1).Readers(1).read();

if (~isempty(Dev_val))
    
    temp_Dev_Val = Dev_val;
    S = evalin('base','S');
    for M = 1:length(temp_Dev_Val)
        switch temp_Dev_Val(M).value.metric_id
            
            case 233
                
                %             figure(S.fh);
                set(S.video,'CData',temp_Dev_Val(M).value.video);
                refreshdata(S.video,'caller');
                set(S.hist,'CData',abs(fft(temp_Dev_Val(M).value.video)));
                refreshdata(S.hist,'caller');
                
            case 243
                pulse = evalin('base','pulse');
                for H = 1:(length(pulse)-1);
                    pulse(1,H) = pulse(1,H+1);
                end
                pulse(1,length(pulse)) = temp_Dev_Val(M).value.value;
                set(S.HR,'YData',pulse);
                refreshdata(S.HR,'caller')
                assignin('base','pulse',pulse);
                set(S.Data1,'str',{strcat('HR:',num2str(temp_Dev_Val(M).value.value))});
                
            case 253
                plotx = evalin('base','plotx');
                for H = 1:(length(plotx)-1);
                    plotx(1,H) = plotx(1,H+1);
                end
                plotx(1,length(plotx)) = temp_Dev_Val(M).value.value;
                set(S.X,'YData',plotx);
                refreshdata(S.X,'caller')
                assignin('base','plotx',plotx);
                set(S.Data2,'str',{strcat('X:',num2str(temp_Dev_Val(M).value.value))});
                
            case 254
                set(S.Data3,'str',{strcat('Y:',num2str(temp_Dev_Val(M).value.value))});
                
            case 255
                set(S.Data4,'str',{strcat('Z:',num2str(temp_Dev_Val(M).value.value))});
        end
    end
    
end
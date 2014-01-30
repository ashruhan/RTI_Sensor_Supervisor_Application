%% Supervisor_ex
% The supervisor has teh responsibility to analyze every piece of data that
% is being published on the topic and type that it is subscribed to. This
% version does not support the supervisor to write back to the devices and
% or sensors. 
function Supervisor_ex(~,~,dp)
[Dev_val, ~]=dp.Subscribers(1).Readers(1).read();
if (~isempty(Dev_val))
    
    temp_Dev_Val = Dev_val;
    S = evalin('base','S');
    for M = 1:length(temp_Dev_Val)
        switch temp_Dev_Val(M).value.metric_id
            
            case 233
                % temp_Dev_Val is the only thing that is important, the
                % rest is sample code that represents the data on the GUI                
                set(S.video,'CData',temp_Dev_Val(M).value.video);
                refreshdata(S.video,'caller');
                set(S.hist,'CData',abs(fft(temp_Dev_Val(M).value.video)));
                refreshdata(S.hist,'caller');
                
            case 243
                pulse = evalin('base','pulse');
                for H = 1:(length(pulse)-1);
                    pulse(1,H) = pulse(1,H+1);
                end
                % temp_Dev_Val is the only thing that is important, the
                % rest is sample code that represents the data on the GUI
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
                % temp_Dev_Val is the only thing that is important, the
                % rest is sample code that represents the data on the GUI
                plotx(1,length(plotx)) = temp_Dev_Val(M).value.value;
                set(S.X,'YData',plotx);
                refreshdata(S.X,'caller')
                assignin('base','plotx',plotx);
                set(S.Data2,'str',{strcat('X:',num2str(temp_Dev_Val(M).value.value))});
                
            case 254
                % Value is not being represented as a vector in the GUI do
                % to a matlab error. It will not allow me to assign
                % differnet plots to the same plot handle.
                set(S.Data3,'str',{strcat('Y:',num2str(temp_Dev_Val(M).value.value))});
                
            case 255
                % Value is not being represented as a vector in the GUI do
                % to a matlab error. It will not allow me to assign
                % differnet plots to the same plot handle.
                set(S.Data4,'str',{strcat('Z:',num2str(temp_Dev_Val(M).value.value))});
        end
    end
    
end
function NuObsSens(~,~,dp)

global S

[nuobsval, ~]=dp.Subscribers(1).Readers(1).read();

if (~isempty(nuobsval))
    
    tempVal = nuobsval;
    for dimt = length(tempVal);
        
        if strcmp('Pulse',tempVal(dimt).usi)
            
            pulse = evalin('base','pulse');
            for m = 1:(length(pulse)-1);
                pulse(1,m) = pulse(1,m+1);
            end
            
            set(S.HR,'YData',pulse);
            refreshdata(S.HR,'caller')
            assignin('base','pulse',pulse);
            
            set(S.Data1,'str',{strcat('X=',num2str(tempVal(dimt).value.value))});
        end
        if strcmp('Accel X',tempVal(dimt).usi)
            
            plotx = evalin('base','plotx');
            
            for m = 1:(length(plotx)-1);
                plotx(1,m) = plotx(1,m+1);
            end
            
            plotx(1,length(plotx)) = tempVal(dimt).value.value;
            set(S.X,'YData',plotx);
            refreshdata(S.X,'caller')
            assignin('base','plotx',plotx);
            
            %aXString = strcat('X=',num2str(tempVal(1).value.value));
            set(S.Data2,'str',{strcat('X=',num2str(tempVal(dimt).value.value))});
        end
        if strcmp('Accel Y',tempVal(dimt).usi)
            
            %aYString = strcat('X=',num2str(tempVal(1).value.value));
            set(S.Data3,'str',{strcat('Y=',num2str(tempVal(dimt).value.value))});
        end
        if strcmp('Accel Z',tempVal(dimt).usi)
            
            %aZString = strcat('X=',num2str(tempVal(1).value.value));
            set(S.Data4,'str',{strcat('Z=',num2str(tempVal(dimt).value.value))});
        end
    end
end
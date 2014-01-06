function NuObsSens(~,~,dp)

global S

[nuobsval, ~]=dp.Subscribers(1).Readers(1).read();

if (~isempty(nuobsval))
    
    tempVal = nuobsval;
    switch tempVal(1).value.metric_id
       
        case 233
            
            figure(S.fh);
            set(S.video,'CData',tempVal(1).value.video);
            refreshdata(S.video,'caller');
            set(S.hist,'CData',abs(fft(tempVal(1).value.video)));
            refreshdata(S.hist,'caller');
      
        case 243
            
            pulse = evalin('base','pulse');
            
            for m = 1:(length(pulse)-1);
                pulse(1,m) = pulse(1,m+1);
            end
            
            set(S.HR,'YData',pulse);
            refreshdata(S.HR,'caller')
            assignin('base','pulse',pulse);
            
            %HRString = strcat('X=',num2str(tempVal(1).value.value));
            set(S.Data1,'str',{strcat('X=',num2str(tempVal(1).value.value))});
       
        case 253
            
            plotx = evalin('base','plotx');
            
            for m = 1:(length(plotx)-1);
                plotx(1,m) = plotx(1,m+1);
            end
            
            plotx(1,length(plotx)) = tempVal(1).value.value;
            set(S.X,'YData',plotx);
            refreshdata(S.X,'caller')
            assignin('base','plotx',plotx);
            
            %aXString = strcat('X=',num2str(tempVal(1).value.value));
            set(S.Data2,'str',{strcat('X=',num2str(tempVal(1).value.value))});
       
        case 254
            
            %aYString = strcat('X=',num2str(tempVal(1).value.value));
            set(S.Data3,'str',{strcat('X=',num2str(tempVal(1).value.value))});
        
        case 255
            
            %aZString = strcat('X=',num2str(tempVal(1).value.value));
            set(S.Data4,'str',{strcat('X=',num2str(tempVal(1).value.value))});
    end 
    
end
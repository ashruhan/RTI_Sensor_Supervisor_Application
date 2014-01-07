function VideoSens(~,~,dp)

global S

[nuobsval, ~]=dp.Subscribers(1).Readers(1).read();

if (~isempty(nuobsval))
    
    tempVal = nuobsval;
    
    for dimt = length(tempVal);
        
        if strcmp('DIMTVideo1',tempVal(dimt).usi);
            
            figure(S.fh);
            temp = tempVal(dimt).value.video;
            set(S.video,'CData',temp);
            
             refreshdata(S.video,'caller');
            temp = abs(fftshift(fft(tempVal(dimt).value.video)));
            set(S.hist,'CData',temp);
            
           refreshdata(S.hist,'caller');
            
        end
    end
end
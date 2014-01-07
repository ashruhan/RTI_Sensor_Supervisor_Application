function Video(~,~,dp)

[Frame, ~]=dp.Subscribers(1).Readers(1).read();
% ACCxyz = evalin('base', 'ACCxyz');
if (~isempty(Frame))
    
    tempFrame = Frame;
    
    for sen = 1:length(tempFrame)
        if strcmp('Video1',tempFrame(sen).usi)
            
            VideoFrame = DIMT_NumericObsVal();
            VideoFrame.usi = 'DIMTVideo1';
            VideoFrame.value.metric_id = 233;
            VideoFrame.value.video = tempFrame(sen).Vidhandle;
            dp.write(VideoFrame);
            
        end
    end
    
end

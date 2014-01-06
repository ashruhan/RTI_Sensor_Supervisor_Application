function Video(~,~,dp)

[Frame, ~]=dp.Subscribers(1).Readers(1).read();
% ACCxyz = evalin('base', 'ACCxyz');
if (~isempty(Frame))
    
    tempFrame = Frame;
    
VideoFrame = evalin('base','VideoFrame');
VideoFrame.value.metric_id = 233;
VideoFrame.value.video = tempFrame(1).Vidhandle;
dp.write(VideoFrame);

end

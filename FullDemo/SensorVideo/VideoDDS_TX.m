function VideoDDS_TX(~,~,vid,dp)

VideoMat = evalin('base','VideoMat');
temp = step(vid);
VideoMat.Vidhandle = temp(:,:,1);
VideoMat.usi = 'Video1';

dp.write(VideoMat);




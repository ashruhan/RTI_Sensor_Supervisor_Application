function Sensor_ex(~,~,dp)
vid_handle = evalin('base','vid_handle');
VideoMat = evalin('base','VideoMat');
temp =step(vid_handle);
VideoMat.Vidhandle = temp(:,:,1);
dp.Publishers.Writers(1).write(VideoMat);
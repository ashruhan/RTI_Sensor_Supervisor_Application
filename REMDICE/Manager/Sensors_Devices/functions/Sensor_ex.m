%% Sensor_ex
% This sensor executable takesa registered webcam handle that was
% initialized in the Init function and takes frames from it. The frames are
% then put in a data structure and written to a device that is paired with
% it to parse the data.
function Sensor_ex(~,~,dp)
vid_handle = evalin('base','vid_handle');
VideoMat = evalin('base','VideoMat');
temp =step(vid_handle);
VideoMat.Vidhandle = temp(:,:,1);
dp.Publishers.Writers(1).write(VideoMat);
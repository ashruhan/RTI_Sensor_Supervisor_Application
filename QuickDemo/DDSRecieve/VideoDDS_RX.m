function VideoDDS_RX(~,~,dp)
global S

[Frame, ~]=dp.Subscribers(1).Readers(2).read();

if (~isempty(Frame))
    
figure(S.fh);

set(S.video,'CData',Frame(1).Vidhandle);
refreshdata(S.video,'caller');

set(S.hist,'CData',abs(fft(Frame(1).Vidhandle)));
refreshdata(S.hist,'caller');
end





classdef NuObsValue
   properties
      % In order for DDS to be pulled into Matlab the Data Structer must
      % match exactly. This NuObsValue has changed since This Matlab code
      % has been written. To debug Data structures Use RTI Analyzer. 
      metric_id = uint16(0);
      value = double(0);
      video = uint8(ones(120,160));
      
   end
   
   methods (Static = true)
        function keyFields = getKeyFields()
            keyFields = [false, false, false];
        end
   end
   
end
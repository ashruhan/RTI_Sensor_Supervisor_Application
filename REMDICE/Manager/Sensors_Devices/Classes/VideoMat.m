classdef VideoMat
   properties
      % In order for DDS to be pulled into Matlab the Data Structer must
      % match exactly. This NuObsValue has changed since This Matlab code
      % has been written. To debug Data structures Use RTI Analyzer. 
      
      Vidhandle = uint8(ones(120,160));
     
   end
   
   methods (Static = true)
        function keyFields = getKeyFields()
            keyFields = false;
        end
   end
   
end
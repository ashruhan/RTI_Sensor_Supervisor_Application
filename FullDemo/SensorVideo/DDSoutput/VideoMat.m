classdef VideoMat
   properties
      % In order for DDS to be pulled into Matlab the Data Structer must
      % match exactly. To debug Data structures Use RTI Analyzer. 
      
      Vidhandle = uint8(zeros(120,160));
     
   end
   
   methods (Static = true)
        function keyFields = getKeyFields()
            keyFields = false;
        end
   end
   
end
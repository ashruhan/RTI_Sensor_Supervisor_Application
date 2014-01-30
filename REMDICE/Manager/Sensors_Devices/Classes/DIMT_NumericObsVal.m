classdef DIMT_NumericObsVal  
    properties
        %Top level of the incomming data structure from the Pulse Ox
        %Remember that the data structure of MATlab must match exactly to
        %that of the output of the device. 
        udi = blanks(128);
        value = NuObsValue;       
    end
    
    methods (Static = true)
        function keyFields = getKeyFields()
            keyFields = [false, false];
        end
    end
    
end


classdef SensorADCVoltage
    properties
        usi = blanks(100);
        value = double(0);       
    end
    
    methods (Static = true)
        function keyFields = getKeyFields()
            keyFields = [true,false];
        end
    end
    
end


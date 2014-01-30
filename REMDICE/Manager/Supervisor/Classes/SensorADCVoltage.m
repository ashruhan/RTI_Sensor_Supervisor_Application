classdef SensorADCVoltage
    properties
        % The data structure will change in future releases. Currently this
        % data structure is a proof of concept. All we needed to publiish
        % sensor data is an identifyer and a means to carry data.
        usi = blanks(100);
        value = double(zeros(1,3));       
    end
    
    methods (Static = true)
        function keyFields = getKeyFields()
            keyFields = [true,false];
        end
    end
    
end


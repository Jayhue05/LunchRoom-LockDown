classdef newPlayer < handle
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        name = "James"
        x = 50
        y = 50
        speedMultiplier = 2
        matrix = zeros(16,16)

        


    end

    methods
        
        function createPlayer(obj, fullbg, totalColumns)
            for r = 1:16
                for c = 1:16
                    obj.matrix(r, c) = c + size(fullbg, 2) + (r - 1) * totalColumns;
                end
            end
        end

        function CursorMovement(obj, targetX, targetY)

            % Calculates direction to move
            direction = [(targetX - 500), (targetY - 500)];
            magnitude = sqrt( (direction(1))^2 + direction(2)^2 );
            normalized_vector = round([(direction(1) / magnitude), (direction(2) / magnitude)]);
            %disp([normalized_vector(1), normalized_vector(2)]);
            %disp([obj.x, obj.y])

            % Prevents #/0 from occuring
            if floor(normalized_vector(1)) ~= normalized_vector(1)
                return
            end

                  %Assigns position to temp variable
            obj.x = obj.x + normalized_vector(1) * obj.speedMultiplier;
            obj.y = obj.y + normalized_vector(2) * obj.speedMultiplier;
        end

        function addx(input)
            obj.x = obj.x + input;

        end
    end
end
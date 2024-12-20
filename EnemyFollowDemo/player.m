classdef player < handle
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        name = "James"
        x = 50
        y = 50
        speedMultiplier = 1
    end

    methods
        function CursorMovement(obj, targetX, targetY, board)

            % Calculates direction to move
            direction = [(targetX - obj.x), (targetY - obj.y)];
            magnitude = sqrt( (direction(1))^2 + direction(2)^2 );
            normalized_vector = round([(direction(1) / magnitude), (direction(2) / magnitude)]);

            %Assigns position to temp variable
            newPosX = obj.x + normalized_vector(1) * obj.speedMultiplier;
            newPosY = obj.y + normalized_vector(2) * obj.speedMultiplier;

            % Prevents #/0 from occuring
            if floor(normalized_vector(1)) ~= normalized_vector(1)
                return
            end

            % checks if position is already taken
            if board(newPosY, newPosX) == 1 || board(newPosY, newPosX) == 2
                obj.x = newPosX;
                obj.y = newPosY;
            end
        end
    end
end
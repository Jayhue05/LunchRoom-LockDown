classdef newPlayer < handle
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        name = "James"
        x = 50
        y = 50
        speedMultiplier = 2
        animation = {zeros(16,16),zeros(16,16),zeros(16,16),zeros(16,16),... % up animations
                     zeros(16,16),zeros(16,16),zeros(16,16),zeros(16,16),... % down animations
                     zeros(16,16),zeros(16,16),zeros(16,16),zeros(16,16),... % left animations
                     zeros(16,16),zeros(16,16),zeros(16,16),zeros(16,16)}    % right animations
        normalized_vector
    end

    methods

 
        
function createPlayer(obj, fullbg, totalColumns)
    % Preallocate obj.animation as a cell array to hold 16x16 matrices
    obj.animation = cell(16, 1); 

    % Populate each cell with a 16x16 matrix
    for cellNumber = 1:16
        tempMatrix = zeros(16, 16); % Temporary 16x16 matrix
        for r = 1:16
            for c = 1:16
            tempMatrix(r, c) = c + size(fullbg, 2) + (r - 1) .* totalColumns + 16 .* (cellNumber - 1); 
            end
        end
        obj.animation{cellNumber} = tempMatrix; % Store the 16x16 matrix in the cell array
    end
end


        function CursorMovement(obj, targetX, targetY)

            % Calculates direction to move
            direction = [(targetX - 570), (targetY - 390)];
            magnitude = sqrt( (direction(1))^2 + direction(2)^2 );
            obj.normalized_vector = round([(direction(1) / magnitude), (direction(2) / magnitude)]);
            %disp([normalized_vector(1), normalized_vector(2)]);
            %disp([obj.x, obj.y])

            % Prevents #/0 from occuring
            if floor(obj.normalized_vector(1)) ~= obj.normalized_vector(1)
                return
            end

                  %Assigns position to temp variable
            obj.x = obj.x + obj.normalized_vector(1) * obj.speedMultiplier;
            obj.y = obj.y + obj.normalized_vector(2) * obj.speedMultiplier;
        end
    end
end

classdef prisoner < handle
    % Assigns attributes to object (prisoner)
    properties
        Name = "Phil";
        level = 1;
        health = 10;
        x = 0;
        y = 0;
        rowSpawn = [1,2,99,100]
    end

    methods
        %Moves prisoner to the player
        function findPlayer(obj, playerX, playerY, board)
            
            % Calculates direction to move
            direction = [(playerX - obj.x), (playerY - obj.y)];
            magnitude = sqrt( (direction(1))^2 + direction(2)^2 );
            normalized_vector = round([(direction(1) / magnitude), (direction(2) / magnitude)]);

            % Assigns position to temp variable
            newPosX = obj.x + normalized_vector(1);
            newPosY = obj.y + normalized_vector(2);

            % Prevents #/0 from occuring
            if floor(normalized_vector(1)) ~= normalized_vector(1) || board(newPosY, newPosX) == 5
                return
            end

            dirNum = [-1,1];
            randNum = dirNum(randi([1,2]));
            

            % checks if position is already taken
            if board(newPosY, newPosX) == 1
                obj.x = newPosX;
                obj.y = newPosY;
            elseif (magnitude > 6) && board(obj.y, obj.x + randNum) == 1
                obj.x = obj.x + randNum;
                obj.y = obj.y;
            elseif(magnitude > 6) && board(obj.y + randNum, obj.x) == 1
                obj.x = obj.x;
                obj.y = obj.y + randNum;
            end
        end
        % This displays prisoner at random position on the map
        function spawnPrisoner(obj)
            % Gives player random pos
            obj.x = randi([1,100]);
            obj.y = randi([1,100]);
        end
    end
end



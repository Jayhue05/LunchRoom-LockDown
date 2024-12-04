
classdef newPrisoner < handle
    % Assigns attributes to object (prisoner)
    properties
        Name = "Phil";
        level = 1;
        health = 10;
        x = 50;
        y = 50;
        rowSpawn = [1,2,99,100]
        matrix = zeros(16,16)
        
    end

    methods
        function createPrisoner(obj, fullbg, totalColumns)
            for r = 1:16
                for c = 1:16
                    obj.matrix(r, c) = c + size(fullbg, 2) + (r - 1) * totalColumns;
                end
            end
            obj.x = randi([50,300]);
            obj.y = randi([50,300]);
           
        end
        
        %Moves prisoner to the player
        function findPlayer(obj, playerX, playerY, barrierBoard)
            
            % Calculates direction to move
            direction = [(playerX - obj.x), (playerY - obj.y)];
            magnitude = sqrt( (direction(1))^2 + direction(2)^2 );
            normalized_vector = round([(direction(1) / magnitude), (direction(2) / magnitude)]);



            % Assigns position to temp variable
            newX = obj.x + normalized_vector(1);
            newY = obj.y + normalized_vector(2);
            

            % Prevents #/0 from occuring
            if floor(normalized_vector(1)) ~= normalized_vector(1)
                return
            end
        


            dirNum = [-1,1];
            randNum = dirNum(randi([1,2]));
            
            if all(barrierBoard(newX:newX + 16,newY: newY + 16) == 0, 'all')
                obj.x = obj.x + normalized_vector(1);
                obj.y = obj.y + normalized_vector(2);
                %disp([obj.y, obj.x])
            elseif all(barrierBoard(obj.x + randNum:obj.x + randNum + 16,obj.y + randNum: obj.y + randNum + 16) == 0, 'all')
                obj.x = obj.x + randNum;
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




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

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        animation = {zeros(16,16),zeros(16,16),zeros(16,16),zeros(16,16),... % up animations
                     zeros(16,16),zeros(16,16),zeros(16,16),zeros(16,16),... % down animations
                     zeros(16,16),zeros(16,16),zeros(16,16),zeros(16,16),... % left animations
                     zeros(16,16),zeros(16,16),zeros(16,16),zeros(16,16)}    % right animations
        normalized_vector
        previousMotion = 2
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end

    methods
        function createPrisoner(obj, fullbg, totalColumns)
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
        
        %Moves prisoner to the player
        function findPlayer(obj, playerX, playerY)
            
            % Calculates direction to move
            direction = [(playerX - obj.x), (playerY - obj.y)];
            magnitude = sqrt( (direction(1))^2 + direction(2)^2 );
            obj.normalized_vector = round([(direction(1) / magnitude), (direction(2) / magnitude)]);



            % Assigns position to temp variable
            obj.x = obj.x + obj.normalized_vector(1);
            obj.y = obj.y + obj.normalized_vector(2);
            

    
        if      obj.normalized_vector == [-1,0] % up
            if obj.previousMotion == 9
                obj.matrix = obj.animation{10};
                obj.previousMotion = 10;
            elseif obj.previousMotion == 10
                obj.matrix = obj.animation{11};
                obj.previousMotion = 11;
            elseif obj.previousMotion == 11
                obj.matrix = obj.animation{12};
                obj.previousMotion = 12;
            else
                obj.matrix = obj.animation{9};
                obj.previousMotion = 9;
            end
    
        elseif  obj.normalized_vector == [1,0] % down
            if obj.previousMotion == 1
                obj.matrix = obj.animation{2};
                obj.previousMotion = 2;
            elseif obj.previousMotion == 2
                obj.matrix = obj.animation{3};
                obj.previousMotion = 3;
            elseif obj.previousMotion == 3
                obj.matrix = obj.animation{4};
                obj.previousMotion = 4;
            else
                obj.matrix = obj.animation{1};
                obj.previousMotion = 1;
            end
    
        elseif  obj.normalized_vector(2) == -1 % left
            if obj.previousMotion == 5
                obj.matrix = obj.animation{6};
                obj.previousMotion = 6;
            elseif obj.previousMotion == 6
                obj.matrix = obj.animation{7};
                obj.previousMotion = 7;
            elseif obj.previousMotion == 7
                obj.matrix = obj.animation{8};
                obj.previousMotion = 8;
            else
                obj.matrix = obj.animation{5};
                obj.previousMotion = 5;
            end
    
        elseif  obj.normalized_vector(2) == 1 % right
            if obj.previousMotion == 13
                obj.matrix = obj.animation{14};
                obj.previousMotion = 14;
            elseif obj.previousMotion == 14
                obj.matrix = obj.animation{15};
                obj.previousMotion = 15;
            elseif obj.previousMotion == 15
                obj.matrix = obj.animation{16};
                obj.previousMotion = 16;
            else
                obj.matrix = obj.animation{13};
                obj.previousMotion = 13;
            end
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



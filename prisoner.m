
classdef prisoner < handle
    % This class creates a prisoner to spawn in
    
    properties
        Name = "Phil";
        level = 1;
        health = 10;
        x = 0;
        y = 0;
    end

    methods
        function findPlayer(obj, playerX, playerY)

            slopeState = 1;
            if (obj.x - playerX) > 0
                obj.x = obj.x - 1;
                slopeState = -1;
            elseif (obj.x - playerX) < 0
                obj.x = obj.x + 1;
                slopeState = 1;
            else
                obj.x = obj.x;
            end
            
            slope = slopeState * round((obj.y - playerY) / (obj.x - playerX));
            obj.y = slope + obj.y;
            
        end
        function [x, y] = spawnPrisoner(obj)
            obj.x = randi([2,99]);
            obj.y = randi([2,99]);
            x = obj.x;
            y = obj.y;
 
        end
    end
end


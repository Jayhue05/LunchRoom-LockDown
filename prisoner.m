
classdef prisoner < handle
    % Assigns attributes to object (prisoner)
    properties
        Name = "Phil";
        level = 1;
        health = 10;
        x = 0;
        y = 0;
    end

    methods
        %Moves prisoner to the player
        function findPlayer(obj, playerX, playerY, board)
            
            % Calculates direction to move
            direction = [(playerX - obj.x), (playerY - obj.y)];
            magnitude = sqrt( (direction(1))^2 + direction(2)^2 );
            normalized_vector = round([(direction(1) / magnitude), (direction(2) / magnitude)]);

            %fprintf("The vector is: ( %i , %i ) \n", direction(1), direction(2));
            %fprintf("The magnitude is: %.f \n", magnitude)
            fprintf("The normalized vector is: %.f , %.f \n", normalized_vector(1), normalized_vector(2));
            
            newPosX = obj.x + normalized_vector(1);
            newPosY = obj.y + normalized_vector(2);

            % Prevents 0/0 from occuring and checks if position is already
            % taken
            if (floor(normalized_vector(1)) == normalized_vector(1) && board(newPosY, newPosX) == 1)
                obj.x = newPosX;
                obj.y = newPosY;
            end

        end
        % This displays prisoner at random upper position on the map
        function [x, y] = spawnPrisoner(obj)
            
            obj.x = randi([100]);
            obj.y = randi([100]);
            x = obj.x;
            y = obj.y;

        end
        % Legacy movement
        function OldFindPlayer(obj, playerX, playerY)
            % Flips the direction prisioner is navigating rows
            % Occurs when prisoner is right of the player
            slopeState = 1;
            % Changes column navigation direction depending on
            % which side they are on compared to player
            if (obj.x - playerX) > 0
                obj.x = obj.x - 1;
                slopeState = -1;
            elseif (obj.x - playerX) < 0
                obj.x = obj.x + 1;
                slopeState = 1;
            else
                obj.x = obj.x;
            end
            
            % Prevents #/0 erros 
            if obj.x == playerX
                fprintf("Error \n")
            else
                % Gets slope from prisoner to player + multiplied by
                % direction changer (slopeState)
                slope = slopeState * round((obj.y - playerY) / (obj.x - playerX));

                % Changes prisoner Y pos.
                obj.y = slope + obj.y;
            end
        end
    end
end



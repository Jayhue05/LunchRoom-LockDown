function tl = updateEnemy(tl,enemy, playerX, playerY)
% Updates all prisoners position
    for i = 1:size(enemy,2)
        % Deletes the previous postion of the prisoner
        tl(enemy(1,i).y, enemy(1,i).x) = 1;
    
        % Sets prisoners new position
        enemy(1,i).findPlayer(playerX, playerY  , tl);
        tl(enemy(1,i).y,enemy(1,i).x) = 2;
    end
end
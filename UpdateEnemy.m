function [barrierMatrix, fullbg, enemy] = UpdateEnemy(barrierMatrix,enemy, mainPlayerX, mainPlayerY)

    for i = 1:size(enemy,2)
        barrierMatrix(enemy(1,i).x:enemy(1,i).x + 16 - 1, enemy(1,i).y:enemy(1,i).y  + 16 -1 ) = zeros(16,16);
        enemy(1,i).findPlayer(mainPlayerY + 50, mainPlayerX + 50, barrierMatrix);
        fullbg(enemy(1,i).x:enemy(1,i).x + 16 - 1, enemy(1,i).y:enemy(1,i).y  + 16 -1 ) = enemy(1).matrix;
        barrierMatrix(enemy(1,i).x + 5:enemy(1,i).x + + 9 - 1, enemy(1,i).y + 5 :enemy(1,i).y + 9 - 1 ) = ones(4,4);
    end
end
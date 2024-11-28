function array = drawbox(tl, playerX, playerY)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
array = [];
    for j = 1:9
        for i = 1:9
            if (i == 1 || i == 9) || (j == 1 || j == 9)
                array = [array; playerX + 5 - i, playerY - 5 + j ];
                %tl(playerX + 5 - i, playerY - 5 + j) = 2;
            end
        end
    end
    disp(array)
end

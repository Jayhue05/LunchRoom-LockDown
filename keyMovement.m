function [currentRow, currentCol] = keyMovement(obj, row_start, col_start, currentRow, currentCol, gamebgSize, gamebg, cfullplayer, rfullplayer)

    if obj.currentKeys.up
        row_start = max(row_start - 1, 1);
        if row_start < gamebgSize(1) * .05
            currentRow = max(currentRow - 1, 1 + 34); % top of fullboard is 34 away from top of playable area
        end
    end
    if obj.currentKeys.down
        row_start = min(row_start + 1, size(gamebg,1) - rfullplayer + 1);
        if row_start > gamebgSize(1) * .95 - 16
            currentRow = min(currentRow + 1, rfullbg - gamebgSize(1) + 1 - 64); % bottom of fullboard is 64 away from bottom of playable area
        end
    end
    if obj.currentKeys.left
        col_start = max(col_start - 1, 1);
        if col_start < gamebgSize(2) * .05
            currentCol = max(currentCol - 1, 1 + 64); % left of fullboard is 64 away from left of playable area
        end
    end
    if obj.currentKeys.right
        col_start = min(col_start + 1, size(gamebg,2) - cfullplayer - 1);
        if col_start > gamebgSize(2) * .95 - 16
            currentCol = min(currentCol + 1, cfullbg - gamebgSize(2) + 1 - 62); % right of fullboard is 62 away from right of playable area
        end
    end
    disp(currentCol)
end

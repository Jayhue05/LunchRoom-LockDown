function [TL] = spawnTable(board, x, y)
    for rows = 1:5
        for columns = 1:10
            board(x + rows, y + columns) = 4;
        end
    end
    TL = board;

end
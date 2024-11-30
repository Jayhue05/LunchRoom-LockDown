clear;
clc;
close all;

% Change value of sprite factor
factor = 2;

% Initialize game engine
obj = simpleGameEngine('background (1).png', factor, factor, 6);

% Creates background for game
rfullbg = 632 / factor;
cfullbg = 776 / factor;
fullbg = zeros(rfullbg, cfullbg);
totalColumns = size(imread('background (1).png'), 2) / factor;
for r = 1:size(fullbg, 1)
    for c = 1:size(fullbg, 2)
        fullbg(r, c) = c + (r - 1) * totalColumns;
    end
end

% Defines size of zoomed in area
window_height = 45;
window_width = 80;

% Defines the size of the zoomed in area
gamebgSize = [90,160];
currentRow = size(fullbg,1) ./ 2 - gamebgSize(1) ./ 2;
currentCol = size(fullbg,2) ./ 2 - gamebgSize(2) ./ 2;

% Game Board made from zoomed in full board
gamebg = fullbg(currentRow:currentRow+gamebgSize(1)-1, ...
    currentCol:currentCol+gamebgSize(2)-1);

% Creates player for game
rfullplayer = 32 / factor;
cfullplayer = 32 / factor;
player = zeros(rfullplayer, cfullplayer);
for r = 1:rfullplayer
    for c = 1:cfullplayer
        player(r, c) = c + size(fullbg, 2) + (r - 1) * totalColumns;
    end
end

% Creates a blank matrix of board size
player4display = 10693 * ones(gamebgSize(1), gamebgSize(2)); % 8x8 blank is 1386 | 4x4 blank is 2771 | 2x2 blank is 10693

% Position of top-left of player on board
row_start = gamebgSize(1) / 2;
col_start = gamebgSize(2) / 2;

% Main loop
keepRunning = true;
while keepRunning
    % Update player position based on key inputs
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
    
    % Update Game Board display matrix
    gamebg = fullbg(currentRow:currentRow+gamebgSize(1)-1, ...
    currentCol:currentCol+gamebgSize(2)-1);

    % Update player display matrix
    player4display(:) = 10693; % Reset to blank
    player4display(row_start:row_start + rfullplayer - 1, col_start:col_start + cfullplayer - 1) = player;
 
    % Draw the scene
    drawScene(obj,gamebg,player4display)
    pause(0.01); % Small pause to prevent high CPU usage

    if obj.currentKeys.escape
        keepRunning = false;
        close all
    end
end    


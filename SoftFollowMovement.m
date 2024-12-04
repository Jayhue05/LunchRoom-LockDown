clear;
clc;
close all;

% Initialize game engine | Sprite height and width = 2
obj = simpleGameEngine('everything and tables.png', 2, 2, 6);

% Creates background for game
fullbg = zeros(320, 614);
totalColumns = size(imread('everything and tables.png'), 2) / 2;
for r = 1:size(fullbg, 1)
    for c = 1:size(fullbg, 2)
        fullbg(r, c) = c + (r - 1) * totalColumns;
    end
end

% Defines the size of the zoomed in area
gamebgSize = [100,100];
currentRow = size(fullbg,1) ./ 2 - gamebgSize(1) ./ 2;
currentCol = size(fullbg,2) ./ 2 - gamebgSize(2) ./ 2;

% Takes full board and grabs smaller instance | 73 + (73 + (90 - 1))
gamebg = fullbg(currentRow:currentRow+gamebgSize(1)-1, currentCol:currentCol+gamebgSize(2)-1);

% Creates player for game
playerRows = 16;
playerColumns = 16;
mainPlayer = newPlayer;
mainPlayer.createPlayer(fullbg, totalColumns);


% Creates a blank matrix of board size
player4display = 10693 * ones(gamebgSize(1), gamebgSize(2)); %2x2 blank is 10693

% Position of top-left of player on board
row_start = gamebgSize(1) / 2;
col_start = gamebgSize(2) / 2;
mainPlayer.x = col_start;
mainPlayer.y = row_start;
disp(mainPlayer.x);

% Grabs scene and starts polling mouse cord
drawScene(obj,gamebg,player4display)
FigureH = gcf;
set(FigureH, 'WindowButtonMotionFcn', @MotionFcn);

FigureH.Position = [500,50,1000,1000];
axis off; % Hides axes and removes margins
set(gca, 'Position', [0 0 1 1]);

% Prisoner Info
prisonerToSpawn = 1;
enemy = [];

% Create Prisoners
for i = 1:prisonerToSpawn
    enemy = [enemy, newPrisoner];
end

enemy(1).createPrisoner(fullbg,totalColumns);

% Used to index movement animations
previousMotion = 0;

% Main loop
while ~obj.currentKeys.escape
    
    % Start polling mouse positions 
    playerTarget = MotionFcn(FigureH);
    cursorTargetX = round(playerTarget(1));
    cursorTargetY = round(abs((playerTarget(2) - 810))); % Flips axis to start at top left
    

    mainPlayer.CursorMovement(cursorTargetX,cursorTargetY);
   
    currentRow = mainPlayer.y;
    currentCol = mainPlayer.x;
    % Update Game Board display matrix
    gamebg = fullbg(currentRow:currentRow+gamebgSize(1)-1, currentCol:currentCol+gamebgSize(2)-1);

    % Update player display matrix based on direction of motion
    if      mainPlayer.normalized_vector == [0,-1] % up
        if previousMotion == 9
            player4display(row_start:row_start + playerRows - 1, col_start:col_start + playerColumns - 1) = mainPlayer.animation{10};
            previousMotion = 10;
        elseif previousMotion == 10
            player4display(row_start:row_start + playerRows - 1, col_start:col_start + playerColumns - 1) = mainPlayer.animation{11};
            previousMotion = 11;
        elseif previousMotion == 11
            player4display(row_start:row_start + playerRows - 1, col_start:col_start + playerColumns - 1) = mainPlayer.animation{12};
            previousMotion = 12;
        else
            player4display(row_start:row_start + playerRows - 1, col_start:col_start + playerColumns - 1) = mainPlayer.animation{9};
            previousMotion = 9;
        end

    elseif  mainPlayer.normalized_vector == [0,1] % down
        if previousMotion == 1
            player4display(row_start:row_start + playerRows - 1, col_start:col_start + playerColumns - 1) = mainPlayer.animation{2};
            previousMotion = 2;
        elseif previousMotion == 2
            player4display(row_start:row_start + playerRows - 1, col_start:col_start + playerColumns - 1) = mainPlayer.animation{3};
            previousMotion = 3;
        elseif previousMotion == 3
            player4display(row_start:row_start + playerRows - 1, col_start:col_start + playerColumns - 1) = mainPlayer.animation{4};
            previousMotion = 4;
        else
            player4display(row_start:row_start + playerRows - 1, col_start:col_start + playerColumns - 1) = mainPlayer.animation{1};
            previousMotion = 1;
        end

    elseif  mainPlayer.normalized_vector(1) == -1 % left
        if previousMotion == 5
            player4display(row_start:row_start + playerRows - 1, col_start:col_start + playerColumns - 1) = mainPlayer.animation{6};
            previousMotion = 6;
        elseif previousMotion == 6
            player4display(row_start:row_start + playerRows - 1, col_start:col_start + playerColumns - 1) = mainPlayer.animation{7};
            previousMotion = 7;
        elseif previousMotion == 7
            player4display(row_start:row_start + playerRows - 1, col_start:col_start + playerColumns - 1) = mainPlayer.animation{8};
            previousMotion = 8;
        else
            player4display(row_start:row_start + playerRows - 1, col_start:col_start + playerColumns - 1) = mainPlayer.animation{5};
            previousMotion = 5;
        end

    elseif  mainPlayer.normalized_vector(1) == 1 % right
        if previousMotion == 13
            player4display(row_start:row_start + playerRows - 1, col_start:col_start + playerColumns - 1) = mainPlayer.animation{14};
            previousMotion = 14;
        elseif previousMotion == 14
            player4display(row_start:row_start + playerRows - 1, col_start:col_start + playerColumns - 1) = mainPlayer.animation{15};
            previousMotion = 15;
        elseif previousMotion == 15
            player4display(row_start:row_start + playerRows - 1, col_start:col_start + playerColumns - 1) = mainPlayer.animation{16};
            previousMotion = 16;
        else
            player4display(row_start:row_start + playerRows - 1, col_start:col_start + playerColumns - 1) = mainPlayer.animation{13};
            previousMotion = 13;
        end
    end
    %disp([currentRow, currentCol])
    % Spawn Enemy
    %disp([enemy(1,1).x, enemy(1,1).y]);
    fprintf("Enemy position: %i,%i\n",enemy(1,1).x, enemy(1,1).y )
    fprintf("Player position: %i,%i\n",mainPlayer.x,mainPlayer.y)
    %disp([mainPlayer(1).x,mainPlayer(1).y])
    enemy(1,1).findPlayer(mainPlayer(1).y + 50, mainPlayer(1).x + 50);
    fullbg(enemy(1,1).x:enemy(1,1).x + playerRows - 1, enemy(1,1).y:enemy(1).y  + playerColumns -1 ) = enemy(1,1).matrix;

    % Draw the scene
    drawScene(obj,gamebg,player4display);
    pause(0.01); % Small pause to prevent high CPU usage
end    
close all
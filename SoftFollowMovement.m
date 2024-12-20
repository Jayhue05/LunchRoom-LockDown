clear;
clc;
close all;

% Initialize game engine | Sprite height and width = 2
obj = simpleGameEngine('background (1).png', 2, 2, 6);

% Creates background for game
fullbg = zeros(316, 388);
totalColumns = size(imread('background (1).png'), 2) / 2;
for r = 1:size(fullbg, 1)
    for c = 1:size(fullbg, 2)
        fullbg(r, c) = c + (r - 1) * totalColumns;
    end
end

%Creates barrier matrix
barrierMatrix = zeros(size(fullbg,1),size(fullbg, 2));

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


% Grabs scene and starts polling mouse cord
drawScene(obj,gamebg,player4display);
FigureH = gcf;
set(FigureH, 'WindowButtonMotionFcn', @MotionFcn);

FigureH.Position = [500,50,1000,1000];
axis off; % Hides axes and removes margins
set(gca, 'Position', [0 0 1 1]);

% Prisoner Info
prisonerToSpawn = 10;
enemy = [];

% Create Prisoners
for i = 1:prisonerToSpawn
    enemy = [enemy, newPrisoner];
    enemy(1, i).createPrisoner(fullbg,totalColumns);
end


player4display(row_start:row_start + playerRows - 1, col_start:col_start + playerColumns - 1) = mainPlayer.matrix;
    
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

    % Update Enemy
    for i = 1:prisonerToSpawn
        barrierMatrix(enemy(1,i).x:enemy(1,i).x + playerRows - 1, enemy(1,i).y:enemy(1,i).y  + playerColumns -1 ) = zeros(16,16);
        enemy(1,i).findPlayer(mainPlayer(1).y + 50, mainPlayer(1).x + 50, barrierMatrix);
        fullbg(enemy(1,i).x:enemy(1,i).x + playerRows - 1, enemy(1,i).y:enemy(1,i).y  + playerColumns -1 ) = enemy(1,1).matrix;
        barrierMatrix(enemy(1,i).x + 5:enemy(1,i).x + + 9 - 1, enemy(1,i).y + 5 :enemy(1,i).y + 9 - 1 ) = ones(4,4);
    end

    % Draw the scene
    drawScene(obj,gamebg,player4display);
    pause(0.01); % Small pause to prevent high CPU usage
end    
close all
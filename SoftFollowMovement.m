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

    % Update player display matrix
    player4display(row_start:row_start + playerRows - 1, col_start:col_start + playerColumns - 1) = mainPlayer.matrix;
    
    %disp([currentRow, currentCol])
    % Spawn Enemy
    %disp([enemy(1,1).x, enemy(1,1).y]);
    fprintf("Enemy position: %i,%i\n",enemy(1,1).x, enemy(1,1).y )
    fprintf("Player position: %i,%i\n",mainPlayer.x,mainPlayer.y)
    %disp([mainPlayer(1).x,mainPlayer(1).y])
    enemy(1,1).findPlayer(mainPlayer(1).y + 50, mainPlayer(1).x + 50);
    fullbg(enemy(1,1).x:enemy(1,1).x + playerRows - 1, enemy(1,1).y:enemy(1).y  + playerColumns -1 ) = enemy(1).matrix;

    % Draw the scene
    drawScene(obj,gamebg,player4display);
    pause(0.01); % Small pause to prevent high CPU usage
end    
close all
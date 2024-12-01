clc 
clear
close all

% Create Board
bl = ones(316,388);
tl = ones(316,388);
scene = simpleGameEngine("background (1).png", 2,2);

drawScene(scene, bl, tl);

% Start polling mouse position
FigureH = gcf;
set(FigureH, 'WindowButtonMotionFcn', @MotionFcn);

% Removes margins for consistent moues positions
FigureH.Position = [500,50,1000,1000];
axis off; % Hides axes and removes margins
set(gca, 'Position', [0 0 1 1]);

% Create main player
mainPlayer = newPlayer;
tl(mainPlayer.x, mainPlayer.y) = 5;

% Prisoner Info
prisonerToSpawn = 10;
enemy = [];

% Create Prisoners
for i = 1:prisonerToSpawn
    enemy = [enemy, prisoner];
end

%Spawn prisoner
for i = 1:prisonerToSpawn 
    enemy(1,i).spawnPrisoner;
end

while true

    % Updates all prisoners positions
    tl = updateEnemy(tl, enemy, mainPlayer.x, mainPlayer.y);

    % Grabs Mouse position
    playerTarget = MotionFcn(FigureH);
    
    tl(mainPlayer.y, mainPlayer.x) = 1;
    playerTargetX = round(playerTarget(1)/10);
    playerTargetY = round(abs((playerTarget(2) - 1000))/10);
    
    mainPlayer.CursorMovement(playerTargetX, playerTargetY, tl);

    tl(mainPlayer.y, mainPlayer.x) = 5;
   

    drawScene(scene, bl, tl);
    pause(.001);

end

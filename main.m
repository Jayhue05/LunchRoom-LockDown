clc
clear
% Sizing
sideLength = 100;

% Create Board
bl = ones(sideLength);
tl = ones(sideLength);
scene = simpleGameEngine("retro_cards.png", 16,16);

%Placeholder Player
tl(50,50) = 2;

% Prisoner Info
enemy = [];
prisonerToSpawn = 1;

%Create Prisoners
for i = 1:prisonerToSpawn
    enemy = [enemy, prisoner];
end

%Spawn prisoner
for i = 1:prisonerToSpawn 
    [x, y] = enemy(1,i).spawnPrisoner;
    tl(x,y) = 2;
end

while true

    % Reset current spot
    tl(enemy(1,1).x, enemy(1,1).y) = 1;
    % Change to new spot
    
    % Sets prto new position
    enemy(1,1).findPlayer(50,50);
    tl(enemy(1,1).y,enemy(1,1).x) = 2;

    drawScene(scene, bl, tl);
    pause(.1);
end




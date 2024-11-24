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
end

while true

    % Reset current spot
    fprintf("Position erased: %.f %.f\n", enemy(1,1).x , enemy(1,1).y)
    tl(enemy(1,1).y, enemy(1,1).x) = 1;
    
    % Sets prisoners new position
    enemy(1,1).findPlayer(50,50);

    tl(enemy(1,1).y,enemy(1,1).x) = 2;
    fprintf("New Position: %.f %.f\n", enemy(1,1).x , enemy(1,1).y)

    drawScene(scene, bl, tl);
    pause(.01);
end




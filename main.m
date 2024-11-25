clc
clear
close all
% Sizing
sideLength = 100;

% Create Board
bl = ones(sideLength);
tl = ones(sideLength);
scene = simpleGameEngine("retro_cards.png", 16,16);
tl = spawnTable(tl, 25, 50);
tl = spawnTable(tl, 25, 20);

%Placeholder Player
tl(50,50) = 5;

% Prisoner Info
enemy = [];
prisonerToSpawn = 100;

%Create Prisoners
for i = 1:prisonerToSpawn
    enemy = [enemy, prisoner];
end

%Spawn prisoner
for i = 1:prisonerToSpawn 
    [x, y] = enemy(1,i).spawnPrisoner;
end

while true
        
    for i = 1:size(enemy,2)
    %while enemy(1,1).x ~= 50 && enemy(1,1).y ~= 50
        % Deletes the previous postion of the prisoner
        tl(enemy(1,i).y, enemy(1,i).x) = 1;
    
        % Sets prisoners new position
        enemy(1,i).findPlayer(50,50, tl);
        tl(enemy(1,i).y,enemy(1,i).x) = 2;
    end
    %end
    drawScene(scene, bl, tl);
    pause(.1);
end



% Dont nerf to 1 but make it go down that many times before it goes over 
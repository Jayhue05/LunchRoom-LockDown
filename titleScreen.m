clear;
clc;

% Load sprites
background = simpleGameEngine("background.png", 179, 319, 5);
startButton = simpleGameEngine("startButton.png", 179, 319, 5);

% Initialize variables
startScreen = true;

% Function to update the frame for animation
function updateBackground(background)
    persistent frame;
    
    % Only set frame equal to 1 once
    if isempty(frame)
        frame = 1;
    end

    drawScene(background, frame);
    
    frame = mod(frame, 8) + 1;

end

% Create a timer to handle animation in the background
animationTimer = timer('ExecutionMode', 'fixedRate', ...
                       'Period', 0.1, ...            % Frame update interval (0.1 seconds)
                       'TimerFcn', @(~, ~) updateBackground(background), ... % Timer callback function
                       'TasksToExecute', inf);       % Run indefinitely until stopped

% Start the animation timer
start(animationTimer);

% Main loop 
while startScreen
    % button stuff
end

% Stop the timer when exiting the loop
% stop(animationTimer);

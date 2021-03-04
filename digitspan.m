% Clears workspace and variables
sca;
close all;
clearvars;
Screen('Preference', 'SkipSyncTests',1);

% sets up screens
PsychDefaultSetup(2);
screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);

% Begin experiment
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);
numSecs = 1; % duration each frame will be displayed for
vbl = Screen('Flip', window);
for frame = 1:10
 
    % fill the screen with a random color
    randR = rand();
    randG = rand();
    randB = rand();
    Screen('FillRect', window, [randR randG randB]);
 
    % Flip to the screen
    vbl = Screen('Flip', window, vbl + numSecs - ifi/2);

end
Priority(0);
sca;
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

% text
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('TextSize', window, 70);
Screen('TextFont', window, 'Helvetica');
DrawFormattedText(window, 'Hello World',...
'center', screenYpixels * 0.5, [0 0 1]);
Screen('Flip', window);

KbStrokeWait;
sca;


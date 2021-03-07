% Boilerplate Setup
sca;
close all;
clearvars;
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 0)

% Setting up the screen Color
screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Opening a window
[window, windowRect] = PsychImaging('OpenWindow',screenNumber, black);
% Getting the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
ifi = Screen('GetFlipInterval', window);

% Setting up the images used as the background in this experiment
elevator_up = imread('IMG_0449.jpg');
imageTexture_up = Screen('MakeTexture', window, elevator_up);
elevator_down = imread('IMG_0451.jpg');
imageTexture_down = Screen('MakeTexture', window, elevator_down);
% Setting up the sounds used in the experiment
[wavedata, freq] = audioread('Elevator Beep.m4a');
InitializePsychSound(1);
pahandle = PsychPortAudio('Open', [], 1, 1, freq, 2);
PsychPortAudio('FillBuffer', pahandle, [wavedata, wavedata]');

% Setting up Text size
Screen('TextSize', window, 70);
% Introductory explanation of the Elevator Experiment
DrawFormattedText(window, 'Welcome to the Attention Experiment!', 'center', screenYpixels * 0.5, white);
Screen('Flip', window);
WaitSecs(3);
DrawFormattedText(window, ['Today you will be doing' '\n a modified version of a' '\n Test of Everyday Attention' '\n known as Elevator Counting'],'center', 'center', white);
Screen('Flip', window);
WaitSecs(4);
DrawFormattedText(window, ['In this task, your goal' '\n is to guess which floor you are on' '\n based on the number of beeps you hear' '\n and the direction of the elevator arrow'], 'center', screenYpixels * 0.5, white);
Screen('Flip', window);
WaitSecs(7);
DrawFormattedText(window, 'The beep will sound like this', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(2);
% Playing a sample of the elevator sound audio
PsychPortAudio('Start', pahandle);
PsychPortAudio('Stop', pahandle, 1);
% Continuation of explaining the experiment
DrawFormattedText(window, ['You will imagine entering the elevator' '\n on the 1st floor'], 'center', 'center', white);
Screen('Flip', window);
WaitSecs(5);
DrawFormattedText(window, ['You need to find what floor you are on' '\n by counting the beeps!'], 'center', 'center', white);
Screen('Flip', window);
WaitSecs(5);
DrawFormattedText(window, ['Each beep means you have' '\n risen or dropped a floor'], 'center', 'center', white);
Screen('Flip', window);
WaitSecs(5);
DrawFormattedText(window, 'Pay attention to the direction of the arrow!', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(3);
DrawFormattedText(window, 'Lets try a practice round!', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(2);
DrawFormattedText(window, 'Press any key to start', 'center', 'center', white);
Screen('Flip', window);
KbStrokeWait;
% Trial Run of the experiment
Screen('DrawTexture', window, imageTexture_up, [], [], 0);
Screen('Flip', window);
PsychPortAudio('Start', pahandle);
PsychPortAudio('Stop', pahandle, 4);

KbStrokeWait
sca;




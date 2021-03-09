% Boilerplate Setup
sca;
close all;
clearvars;
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 0);

% Setting up the screen and the colors black and white.
screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Opening a black window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
% Getting the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
% Getting flip interval
ifi = Screen('GetFlipInterval', window);

% Setting up the images used as the background in this experiment
elevator_up = imread('IMG_0449.jpg'); % elevator going up
imageTexture_up = Screen('MakeTexture', window, elevator_up);
elevator_down = imread('IMG_0451.jpg'); % elevator going down
imageTexture_down = Screen('MakeTexture', window, elevator_down);
% Setting up the sounds used in the experiment
[wavedata1, freq1] = audioread('Elevator Beep.m4a'); % Elevator sound
[wavedata2, freq2] = audioread('Distracting Sound.m4a'); % Distracting sound
InitializePsychSound(1);
pahandle1 = PsychPortAudio('Open', [], 1, 1, freq1, 2); % pahandle for elevator sound
pahandle2 = PsychPortAudio('Open', [], 1, 1, freq2, 2); % pahandle for distracting sound
PsychPortAudio('FillBuffer', pahandle1, [wavedata1, wavedata1]');
PsychPortAudio('FillBuffer', pahandle2, [wavedata2, wavedata2]');


% Setting up Text size
Screen('TextSize', window, 70);

% Introductory explanation of the Elevator Experiment
DrawFormattedText(window, 'Welcome to the Experiment!', 'center', screenYpixels * 0.5, white);
Screen('Flip', window);
WaitSecs(3);
DrawFormattedText(window, ['Today you will be doing' '\n a modified version of a' '\n Test of Everyday Attention' '\n known as Elevator Counting.'],'center', 'center', white);
Screen('Flip', window);
WaitSecs(4);
DrawFormattedText(window, ['In this task, your goal' '\n is to guess which floor you are on' '\n based on the number of beeps you hear' '\n and the direction of the elevator arrow.'], 'center', 'center', white);
Screen('Flip', window);
WaitSecs(7);
DrawFormattedText(window, 'The beep will sound like this:', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(2);
% Playing a sample of the elevator sound audio
PsychPortAudio('Start', pahandle1);
PsychPortAudio('Stop', pahandle1, 1,1);
% Continuation of explaining the experiment
DrawFormattedText(window, ['You will imagine entering the elevator' '\n on the 10th floor.'], 'center', 'center', white);
Screen('Flip', window);
WaitSecs(5);
DrawFormattedText(window, ['You need to find what floor you are on' '\n by counting the beeps.'], 'center', 'center', white);
Screen('Flip', window);
WaitSecs(5);
DrawFormattedText(window, ['Each beep means you have' '\n risen or dropped a floor'], 'center', 'center', white);
Screen('Flip', window);
WaitSecs(5);
DrawFormattedText(window, ['Pay attention to the direction of the arrow' '\n that will show up in the background.'], 'center', 'center', white);
Screen('Flip', window);
WaitSecs(4);
DrawFormattedText(window, 'Lets try a practice round!', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(2);
DrawFormattedText(window, 'Press the space key to start', 'center', 'center', white);
Screen('Flip', window);
KbStrokeWait;
% Trial Run of the experiment
Screen('DrawTexture', window, imageTexture_up, [], [], 0); % Sets up image of an elevator going up
Screen('Flip', window);
% Plays 4 beeps going up. 
WaitSecs(1);
PsychPortAudio('Start', pahandle1);
PsychPortAudio('Stop', pahandle1, 1,1,4);
% Plays 2 beeps going down. 
WaitSecs(2);
Screen('DrawTexture', window, imageTexture_down, [], [], 0);
Screen('Flip', window);
PsychPortAudio('Start', pahandle1);
PsychPortAudio('Stop', pahandle1, 1,1,2);

% Collecting the Response.
Test_Response = GetEchoString(window, 'What floor are you on?', 100, 450, white, black);
% Assessing whether the answer is right or not with messages. 
% Message if the answer is correct.
if (Test_Response == num2str(12))
    Screen('Flip', window);
    DrawFormattedText(window, 'Nice Job! That is correct!', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(2);
    DrawFormattedText(window, 'Lets enter the real experiment', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(3);
    DrawFormattedText(window, 'Press the space key to begin', 'center', 'center', white);
    Screen('Flip', window);
    KbStrokeWait
% Message if the answer is incorrect.
else 
    Screen('Flip', window);
    DrawFormattedText(window, 'The correct response is 12.', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(2);
    DrawFormattedText(window, ['Starting from the 10th floor,' '\n there were 4 beeps going up' '\n and 2 beeps going down.' '\n That is the 10+4-2 which is the 12th floor'], 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(6);
    DrawFormattedText(window, 'Lets enter the real experiment.', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(3);
    DrawFormattedText(window, 'There will be 3 rounds.', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(3);
    DrawFormattedText(window, 'Press any key to begin', 'center', 'center', white);
    Screen('Flip', window);
    KbStrokeWait
end

correct_round = 0; % Number of correctly identified floors
for Round_Number = 1:3 % 3 total rounds of the experiment
    Floor_Number = 10; % Starting Floor Level
    Screen('Flip', window);
    DrawFormattedText(window, '10th floor', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(2);
    for jj = 1:3 % 3 repeats of a block with one block having an elevator going up and going down
        Random_Number = randi(10,1,4); % Generating a vector of 4 random numbers from 1-10.
        % Switching to an up arrow elevator
        Screen('DrawTexture', window, imageTexture_up, [], [], 0);
        Screen('Flip', window);
        WaitSecs(1);
        % Starting audio and playing the number of tones from the vector
        % Random_Number position jj. 
        PsychPortAudio('Start', pahandle1);
        PsychPortAudio('Stop', pahandle1, 1,1, Random_Number(jj)); 
        WaitSecs(2);
        % Calculating what floor you would be on
        Floor_Number = Floor_Number + Random_Number(jj);
        % Switching to a down elevator
        Screen('DrawTexture', window, imageTexture_down, [], [], 0);
        Screen('Flip', window);
        WaitSecs(1);
        % Starting audio and playing the number of tones from the vector
        % Random_Number position jj. 
        PsychPortAudio('Start', pahandle1);
        PsychPortAudio('Stop', pahandle1, 1,1, Random_Number(jj+1));
        WaitSecs(2);
        % Calculating what floor you would be on
        Floor_Number = Floor_Number - Random_Number(jj+1);
    end
    Response = GetEchoString(window, 'What floor are you on?', 100, 450, white, black);
    if num2str(Floor_Number) == Response
        correct_round = correct_round + 1;
    else 
        correct_round = correct_round + 0;
    end
    WaitSecs(2);
end
Screen('Flip', window);
DrawFormattedText(window, ['You got ' num2str(correct_round) ' correct.'] , 'center', 'center', white);
Screen('Flip', window);
WaitSecs(3);
DrawFormattedText(window, 'Lets increase the difficulty of the test.', 'center', 'center', white);
Screen('Flip', window);
DrawFormattedText(window, ['Now there is a distracting sound that' '\n you will have to ignore when counting floor.'], 'center', 'center', white);
Screen('Flip', window);
WaitSecs(3);
DrawFormattedText(window, 'It sounds like this:', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(2);
% Playing a sample of the elevator sound audio
PsychPortAudio('Start', pahandle2);
PsychPortAudio('Stop', pahandle2, 1,1);
KbStrokeWait;
sca;

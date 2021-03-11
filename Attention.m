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
InitializePsychSound(1); % Initializing the PsychToolBox Sound. 
pahandle1 = PsychPortAudio('Open', [], 1, 1, freq1, 2); % pahandle for elevator sound
pahandle2 = PsychPortAudio('Open', [], 1, 1, freq2, 2); % pahandle for distracting sound
PsychPortAudio('FillBuffer', pahandle1, [wavedata1, wavedata1]'); 
PsychPortAudio('FillBuffer', pahandle2, [wavedata2, wavedata2]');

% Setting up Text size
Screen('TextSize', window, 70);

% Introductory explanation of the Elevator Experiment
% The text will flash on the screen with a black background and white text.
% WaitSecs(n) waits on that screen for n seconds. 
DrawFormattedText(window, 'Welcome to the Experiment!', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(3);
DrawFormattedText(window, ['Today you will be doing' '\n a modified version of a' '\n Test of Everyday Attention' '\n known as Elevator Counting.'],'center', 'center', white);
Screen('Flip', window);
WaitSecs(4);
DrawFormattedText(window, ['In this task, your goal' '\n is to guess which floor you are on' '\n based on the number of beeps you hear' '\n and the direction of the elevator arrow.'], 'center', 'center', white);
Screen('Flip', window);
WaitSecs(6);
DrawFormattedText(window, 'The beep will sound like this:', 'center', 'center', white); 
Screen('Flip', window);
WaitSecs(2);
% Playing a sample of the elevator sound audio
PsychPortAudio('Start', pahandle1);
PsychPortAudio('Stop', pahandle1, 1,1);
% Continuation of explaining the experiment
DrawFormattedText(window, ['You will imagine entering the elevator' '\n on the 10th floor.'], 'center', 'center', white);
Screen('Flip', window);
WaitSecs(3);
DrawFormattedText(window, ['You need to find what floor you are on' '\n by counting the beeps.'], 'center', 'center', white);
Screen('Flip', window);
WaitSecs(5);
DrawFormattedText(window, ['Each beep means you have' '\n risen or dropped a floor'], 'center', 'center', white);
Screen('Flip', window);
WaitSecs(3);
DrawFormattedText(window, ['Pay attention to the direction of the arrow' '\n that will show up in the background.'], 'center', 'center', white);
Screen('Flip', window);
WaitSecs(4);
DrawFormattedText(window, 'Lets try a practice round!', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(2);
DrawFormattedText(window, 'Press the space key to start', 'center', 'center', white);
Screen('Flip', window);
KbStrokeWait; % Wait until the space key is pressed. 

% Trial Run of the experiment
% Displays what floor you start on. 
DrawFormattedText(window, '10th floor', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(2);
Screen('DrawTexture', window, imageTexture_up, [], [], 0); % Sets up image of an elevator going up
Screen('Flip', window); % Flips to the image of an elevator going up.
WaitSecs(1);
% Plays 4 beeps going up.
PsychPortAudio('Start', pahandle1);
PsychPortAudio('Stop', pahandle1, 1,1,4);
WaitSecs(2);
Screen('DrawTexture', window, imageTexture_down, [], [], 0); % Sets up image of an elevator going down. 
Screen('Flip', window); % Flips to the image of an elevator going down.
% Plays 2 beeps going down. 
PsychPortAudio('Start', pahandle1);
PsychPortAudio('Stop', pahandle1, 1,1,2);

% Explanation to the participant on how to submit the response.
DrawFormattedText(window, 'Type your response and press enter.', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(2);
% Collecting the Response from participant.
Test_Response = GetEchoString(window, 'What floor are you on?', 100, 450, white, black);
% Assessing whether the answer is right or not with messages. 
% Message if the answer is correct.
if (Test_Response == num2str(12)) % If Test_response is equal to 12
    Screen('Flip', window);
    DrawFormattedText(window, 'Nice Job! That is correct!', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(2);
    % Entering the real experiment message. 
    DrawFormattedText(window, 'Lets enter the real experiment', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(3);
    DrawFormattedText(window, 'Press the space key to begin', 'center', 'center', white);
    Screen('Flip', window);
    KbStrokeWait % Wait until the space key is pressed.
% Message if the answer is incorrect.
else % If Test_response is not equal to 12. 
    Screen('Flip', window);
    DrawFormattedText(window, 'The correct response is 12.', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(2);
    % Explaining how to get the right answer. 
    DrawFormattedText(window, ['Starting from the 10th floor,' '\n there were 4 beeps going up' '\n and 2 beeps going down.' '\n That is 10+4-2 which is the 12th floor'], 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(6);
    % Entering the real experiment message. 
    DrawFormattedText(window, 'Lets enter the real experiment.', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(2);
    DrawFormattedText(window, 'Press any key to begin', 'center', 'center', white);
    Screen('Flip', window);
    KbStrokeWait % Wait until the space key is pressed.
end

correct_round = 0; % Number of correctly identified floors
for Round_Number = 1:3 % 3 total rounds of the experiment
    Floor_Number = 10; % Starting Floor Level
    Screen('Flip', window); % Flip to a blank black screen. 
    % Displays what floor you start on. 
    DrawFormattedText(window, '10th floor', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(2);
    Random_iteration = randi(3,1,1); % Generates a random number from 1-3. 
    for jj = 1:Random_iteration % 1-3 plays of a block with one block having an elevator going up and going down
        Random_Number = randi(10,1,4); % Generating a vector of 4 random numbers from 1-10.
        % Switching to an up arrow elevator
        Screen('DrawTexture', window, imageTexture_up, [], [], 0);
        Screen('Flip', window);
        WaitSecs(1);
        % Starting audio and playing the number of tones from the vector
        % Random_Number position jj. 
        PsychPortAudio('Start', pahandle1);
        PsychPortAudio('Stop', pahandle1, 1,1, Random_Number(jj)); 
        WaitSecs(1);
        % Calculating what floor you would be on after going up.
        Floor_Number = Floor_Number + Random_Number(jj);
        % Switching to a down elevator
        Screen('DrawTexture', window, imageTexture_down, [], [], 0);
        Screen('Flip', window);
        WaitSecs(1);
        % Starting audio and playing the number of tones from the vector
        % Random_Number position jj. 
        PsychPortAudio('Start', pahandle1);
        PsychPortAudio('Stop', pahandle1, 1,1, Random_Number(jj+1));
        WaitSecs(1);
        % Calculating what floor you would be on after going down. 
        Floor_Number = Floor_Number - Random_Number(jj+1);
    end
    % Participant explanation on how to submit the answer.
    DrawFormattedText(window, 'Type your response and press enter.', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(2);
    % Collects participant response. 
    Response = GetEchoString(window, 'What floor are you on?', 100, 450, white, black);
    % Calculates how many rounds were correct
    if num2str(Floor_Number) == Response % if Response is equal to Floor_Number
        correct_round = correct_round + 1; % Add one to variable correct_round
    else % if Response is not equal to Floor_Number
        correct_round = correct_round + 0; % Add zero to variable correct_round
    end
    WaitSecs(2);
end

% Affirming how many rounds you got correct. 
Screen('Flip', window);
DrawFormattedText(window, ['You got ' num2str(correct_round) ' rounds correct.'] , 'center', 'center', white);
Screen('Flip', window);
WaitSecs(3);
% Explanation for the next kind of Elevator Counting Task 
DrawFormattedText(window, 'Lets increase the difficulty of the test.', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(2);
DrawFormattedText(window, ['Now there is a distracting sound that' '\n you will have to ignore when counting floors.'], 'center', 'center', white);
Screen('Flip', window);
WaitSecs(4);
DrawFormattedText(window, 'It sounds like this:', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(2);
% Playing a sample of the distracting sound for 1 second.
PsychPortAudio('Start', pahandle2);
PsychPortAudio('Stop', pahandle2, 1,1);
% More introductory words. 
DrawFormattedText(window, 'Lets try a practice round.', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(2);
DrawFormattedText(window, 'Press the space key to start', 'center', 'center', white);
Screen('Flip', window);
KbStrokeWait; % Wait until the space key is pressed.

% Trial Run of the second experiment. 
% Shows what floor you will start on. 
DrawFormattedText(window, '10th floor', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(2);
Screen('DrawTexture', window, imageTexture_up, [], [], 0); % Sets up image of an elevator going up
Screen('Flip', window);
% Plays 4 beeps going up. 
WaitSecs(1);
PsychPortAudio('Start', pahandle1);
PsychPortAudio('Stop', pahandle1, 1,1,4);
% Plays 1 distracting sound.
WaitSecs(1);
PsychPortAudio('Start', pahandle2);
PsychPortAudio('Stop', pahandle2, 1, 1, 1);
% Plays 2 beeps going up. 
WaitSecs(1);
PsychPortAudio('Start', pahandle1);
PsychPortAudio('Stop', pahandle1, 1,1,2);
% Participant explanation on how to submit the response. 
DrawFormattedText(window, 'Type your response and press enter.', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(2);
% Collecting the Response.
Test_Response = GetEchoString(window, 'What floor are you on?', 100, 450, white, black);

% Assessing whether the answer is right or not with messages. 
% Message if the answer is correct.
if (Test_Response == num2str(16)) % If Test_response is equal to 16
    Screen('Flip', window);
    DrawFormattedText(window, 'Nice Job! That is correct!', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(2);
    DrawFormattedText(window, 'Lets enter the experiment.', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(3);
    DrawFormattedText(window, 'Press the space key to begin.', 'center', 'center', white);
    Screen('Flip', window);
    KbStrokeWait % Wait until the space key is pressed.
% Message if the answer is incorrect.
else % If Test_response is not equal to 16
    Screen('Flip', window);
    DrawFormattedText(window, 'The correct response is 16.', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(2);
    % Explaining how to get the correct answer.
    DrawFormattedText(window, ['Starting from the 10th floor,' '\n there were 4 beeps going up' '\n a distracting sound,' 'and 2 beeps going up.' '\n That is 10+4+0+2 which is the 16th floor'], 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(6);
    % Entering the real experiment message. 
    DrawFormattedText(window, 'Lets enter the real experiment.', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(3);
    DrawFormattedText(window, 'There will be 3 rounds.', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(3);
    DrawFormattedText(window, 'Press any key to begin', 'center', 'center', white);
    Screen('Flip', window);
    KbStrokeWait % Wait until the space key is pressed.
end

correct_round = 0; % Number of correctly identified floors
for Round_Number = 1:3 % 3 total rounds of the experiment
    Floor_Number = 10; % Starting Floor Level
    Screen('Flip', window); % Sets up black screen. 
    DrawFormattedText(window, '10th floor', 'center', 'center', white); % Shows "10th floor" on the screen.
    Screen('Flip', window);
    WaitSecs(2);
    Random_iteration = randi(3,1,1); % Generates one random integer from 1-3. 
    for jj = 1:Random_iteration % 1-3 repeats of a block with one block having an elevator going up and going down. 
        Random_Number = randi(5,1,6); % Generating a vector of 6 random numbers from 1-5. Values used to determine the number of beeps.
        Random_Number_distracting = randi(2,1,4); % Generating a vector of 4 random numbers that are either 1 or 2 for distracting sounds. 
        % Switching to an up arrow elevator
        Screen('DrawTexture', window, imageTexture_up, [], [], 0);
        Screen('Flip', window);
        WaitSecs(1);
        % Starting audio and playing the number of tones from the vector
        % Random_Number position jj. Plays beeps Random_Number(jj) times. 
        PsychPortAudio('Start', pahandle1);
        PsychPortAudio('Stop', pahandle1, 1,1, Random_Number(jj)); 
        WaitSecs(1);
        % Calculating what floor you would be on after going up. 
        Floor_Number = Floor_Number + Random_Number(jj);
        % Play Distracting Sound Random_Number_distracting(jj) number of times. 
        PsychPortAudio('Start', pahandle2);
        PsychPortAudio('Stop', pahandle2, 1, 1, Random_Number_distracting(jj));
        WaitSecs(1);
        % Plays Random_Number(jj+1) times. 
        PsychPortAudio('Start', pahandle1);
        PsychPortAudio('Stop', pahandle1, 1,1, Random_Number(jj+1)); 
        WaitSecs(1);
        % Calculating what floor you would be on after going up.
        Floor_Number = Floor_Number + Random_Number(jj+1);
        % Switching to a down elevator background
        Screen('DrawTexture', window, imageTexture_down, [], [], 0);
        Screen('Flip', window);
        WaitSecs(1);
        % Starting audio and playing the number of tones from the vector Random_Number(jj+2). 
        PsychPortAudio('Start', pahandle1);
        PsychPortAudio('Stop', pahandle1, 1,1, Random_Number(jj+2));
        WaitSecs(1);
        % Calculating what floor you would be on after going down. 
        Floor_Number = Floor_Number - Random_Number(jj+2);
         % Play Distracting Sound Random_Number_distracting(jj+1) number of times. 
        PsychPortAudio('Start', pahandle2);
        PsychPortAudio('Stop', pahandle2, 1, 1, Random_Number_distracting(jj+1));
    end
    
    DrawFormattedText(window, 'Type your response and press enter.', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(2);
    % Collecting the response
    Response = GetEchoString(window, 'What floor are you on?', 100, 450, white, black);
    % Counting how many rounds were correct. 
    if num2str(Floor_Number) == Response % If Response is equal to Floor_Number
        correct_round = correct_round + 1; % Add one to variable correct_round
    else % Any other answer 
        correct_round = correct_round + 0; % Add zero to variable correct_round
    end
    WaitSecs(2);
end
Screen('Flip', window);
% Tells participant how many rounds were correct. 
DrawFormattedText(window, ['You got ' num2str(correct_round) ' rounds correct.'] , 'center', 'center', white);
Screen('Flip', window);
WaitSecs(2);
% Thanks for participating message
DrawFormattedText(window, 'Thanks for participating!', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(2);
% Close window
sca;

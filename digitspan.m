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
%variables for flipping
[~, ~] = Screen('WindowSize', window);
ifi = Screen('GetFlipInterval', window);
rr = FrameRate(window);

%visual sketchpad code 
% variables
score_span = 0 ; %score 
count = 1 ; %number of rounds participant is on
rounds = 5; %total number of rounds set by tester
error_span = 0; %number of errors
correct = zeros(1, rounds);

%code note: start fitting these vars into loop??

DrawFormattedText(window, 'Directions: Type the numbers you see and press enter when done.' ,...
'center', 'center');
Screen('Flip', window, 1);
WaitSecs(1);


while count <= rounds %actual loop
span_output = randi( 9, 1, count); %output of digit span
%str_span_output = num2str(span_output); %string version of output of digit span
%stimuli text 
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);
numSecs = 1; % duration each frame will be displayed for
vbl = Screen('Flip', window, numSecs); 
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('TextSize', window, 70);
Screen('TextFont', window, 'Helvetica');
DrawFormattedText(window, num2str(span_output) ,...
'center', screenYpixels * 0.5, [0 0 1]);
Screen('Flip', window, vbl + (2*numSecs) - ifi/2);
WaitSecs(1);
%input text code 
span_input = str2num(GetEchoString(window, 'Type digits here:', 500, 675, black, white));

	if  span_output == span_input 
		score_span = score_span + 1;
        correct(count) = count;
        count = count + 1;
    else
        error_span = error_span + 1;
        disp(['Round ', num2str(count), ' was incorrect'])
        count = count + 1; 
    end
    
end
x = max(correct);
disp([num2str(x), ' is the max number memorized'])
disp(score_span)
disp(error_span)

%KbStrokeWait;
sca;

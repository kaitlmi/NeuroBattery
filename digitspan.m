% Clears command window, workspace, and variables
sca;
close all;
clc;
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
rounds = 12; %total number of rounds set by tester, 7-9 usually max
error_span = 0; %number of errors
correct = zeros(1, rounds);


% Directions and Welcome of the digitspantask
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
DrawFormattedText(window, 'Welcome to the visuospatial digit span experiment!', 'center', screenYpixels * 0.5, white);
Screen('Flip', window);
WaitSecs(3.5);
DrawFormattedText(window, ['In this task, your goal' '\n is to memorize as many digits as possible'], 'center', 'center', white);
Screen('Flip', window);
WaitSecs(4.0);
DrawFormattedText(window, 'Type the numbers you see and press enter when done.' ,...
'center', 'center');
Screen('Flip', window, 1);
WaitSecs(3.5);
DrawFormattedText(window, 'Be sure to put spaces between your numbers.' ,...
'center', 'center');
Screen('Flip', window, 1);
WaitSecs(3.5);
DrawFormattedText(window, 'Let''s practice', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(3.5);

%Example run
Screen('TextSize', window, 70);
Screen('TextFont', window, 'Helvetica');
test_output = [1:3];
DrawFormattedText(window, num2str(test_output) ,'center', screenYpixels * 0.5, [0 0 1]);
Screen('Flip', window);
WaitSecs(1);
test_input = str2num(GetEchoString(window, 'Type digits here:', 45, 675, black, white));
	if  length(test_input) ~= length(test_output) %incorrect response 
        DrawFormattedText(window, 'Hm... That''s not quite right.', 'center', 'center');
        Screen('Flip', window);
        WaitSecs(3.5);
        DrawFormattedText(window, 'The correct response was 1 2 3', 'center', 'center');
        Screen('Flip', window);
        WaitSecs(2.5);
    elseif test_input ~= test_output %incorrect response 
		DrawFormattedText(window, 'Hm... That''s not quite right.', 'center', 'center');
        Screen('Flip', window);
        WaitSecs(3.5);
        DrawFormattedText(window, 'The correct response was 1 2 3', 'center', 'center');
        Screen('Flip', window);
        WaitSecs(2.5);
    else %correct response
		DrawFormattedText(window, 'Great work. Now onto the real task.', 'center', 'center');
        Screen('Flip', window);
        WaitSecs(3.5);
    end
    
%%%% Actual Task %%%     
while count <= rounds %actual loop
span_output = randi( 9, 1, count); %output of digit span

%stimuli text 

%window setup
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);
numSecs = 1; % duration each frame will be displayed for
vbl = Screen('Flip', window, numSecs); 
%[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('TextSize', window, 70);
Screen('TextFont', window, 'Helvetica');
DrawFormattedText(window, num2str(span_output) ,...
'center', screenYpixels * 0.5, [0 0 1]);
    if count <= 5
       Screen('Flip', window, vbl + (2*numSecs) - ifi/2);
       WaitSecs(1); %designed bc longer stimuli lines get longer reading time
    elseif count <= 9
       Screen('Flip', window, vbl + (2*numSecs) - ifi/2);
       WaitSecs(1.75);
    else
       Screen('Flip', window, vbl + (2*numSecs) - ifi/2);
       WaitSecs(2.3);
    end
    
%input text code 
span_input = str2num(GetEchoString(window, 'Type digits here:', 45, 675, black, white));

	if  length(span_output) ~= length(span_input) %incorrect resp
        error_span = error_span + 1;
        disp(['Round ', num2str(count), ' was incorrect'])
        count = count + 1; 
    elseif span_output ~= span_input %incorrect resp
		error_span = error_span + 1;
        disp(['Round ', num2str(count), ' was incorrect'])
        count = count + 1; 
    else %correct resp
		score_span = score_span + 1;
        correct(count) = count;
        count = count + 1; 
    end
    
end
x = max(correct);
disp([num2str(x), ' is the max number memorized'])
disp(score_span)
sca;

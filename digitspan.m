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
rounds = 5; %total number of rounds set by tester, 7-9 usually max
error_span = 0; %number of errors
correct = zeros(1, rounds);


% Introductory explanation of the digitspantask
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
DrawFormattedText(window, ['Let''s practice'], 'center', 'center', white);
Screen('Flip', window);
WaitSecs(3.5);
%example run
Screen('TextSize', window, 70);
Screen('TextFont', window, 'Helvetica');
DrawFormattedText(window, '1 2 3' ,'center', screenYpixels * 0.5, [0 0 1]);
Screen('Flip', window);
WaitSecs(1);
test_input = GetEchoString(window, 'Type digits here:', 45, 675, black, white);
	if  test_input ~= '1 2 3' 
		DrawFormattedText(window, ['Hm... That''s not quite right.'], 'center', 'center', white);
        Screen('Flip', window);
        WaitSecs(3.5);
        DrawFormattedText(window, ['The correct response was 1 2 3'], 'center', 'center', white);
        Screen('Flip', window);
        WaitSecs(2.5);
    else
		DrawFormattedText(window, ['Great work. Now onto the real task.'], 'center', 'center', white);
        Screen('Flip', window);
        WaitSecs(3.5);
    end

while count <= rounds %actual loop
span_output = randi( 9, 1, count); %output of digit span
%str_span_output = num2str(span_output); %string version of output of digit span
%stimuli text 
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
       WaitSecs(1);
    elseif count <= 9
       Screen('Flip', window, vbl + (2*numSecs) - ifi/2);
       WaitSecs(1.75);
    else
       Screen('Flip', window, vbl + (2*numSecs) - ifi/2);
       WaitSecs(2.3);
    end
%input text code 
span_input = str2num(GetEchoString(window, 'Type digits here:', 45, 675, black, white));

	if  length(span_output) ~= length(span_input)
        error_span = error_span + 1;
        disp(['Round ', num2str(count), ' was incorrect'])
        count = count + 1; 
    elseif span_output ~= span_input 
		error_span = error_span + 1;
        disp(['Round ', num2str(count), ' was incorrect'])
        count = count + 1; 
    else
		score_span = score_span + 1;
        correct(count) = count;
        count = count + 1; 
    end
    
end
x = max(correct);
disp([num2str(x), ' is the max number memorized'])

sca;

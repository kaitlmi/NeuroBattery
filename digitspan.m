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
rounds = 2; %total number of rounds set by tester
error_span = 0; %number of errors
span_output = randi( 9, 1, count); %output of digit span
str_span_output = num2str(span_output); %string version of output of digit span

while count <= rounds %actual loop 
	ii =  count ;
%stimuli text 
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);
numSecs = 2; % duration each frame will be displayed for
vbl = Screen('Flip', window, 0.5);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('TextSize', window, 70);
Screen('TextFont', window, 'Helvetica');
DrawFormattedText(window, str_span_output ,...
'center', screenYpixels * 0.5, [0 0 1]);
Screen('Flip', window, vbl + numSecs - ifi/2);
%input text 
span_input = GetEchoString(window, 'Type digits here:', 500, 675, black, white);
	if  span_output == span_input 
		score_span = score_span + 1;
		count = count + 1;
    else
        error_span = error_span + 1;
        span_output = randi( 9, 1, ii+1); 
    end
end
disp(score_span)
disp(error_span)



KbStrokeWait;
sca;


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

%visual sketchpad code 
% variables
score_span = 0 ;
count = 1 ;
rounds = 2;
error_span = 0;

%actual loop 
while count <= rounds
	ii =  count ;
	span_output = randi( 9, 1, ii);
    str_span_output = num2str(span_output);
        
    % text
        [screenXpixels, screenYpixels] = Screen('WindowSize', window);
        Screen('TextSize', window, 70);
        Screen('TextFont', window, 'Helvetica');
        DrawFormattedText(window, str_span_putput ,...
        'center', screenYpixels * 0.5, [0 0 1]);
        span_input = GetEchoString(window, 'Type the digits here:', 700, 675, black, white);
        Screen('Flip', window);
 
	if  span_output == span_input 
		score_span = score_span + 1;
		count = count + 1;
	else
		error_span = error_span + 1;
        span_output = randi( 9, 1, ii); 
    end
end
disp(score_span)
disp(error_span)



KbStrokeWait;
sca;


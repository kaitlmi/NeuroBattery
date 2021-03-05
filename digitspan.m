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
score_span = 0 ; %score 
count = 1 ; %number of rounds participant is on
rounds = 2; %total number of rounds set by tester
error_span = 0; %number of errors
span_output = randi( 9, 1, count); %output of digit span
str_span_output = num2str(span_output); %string version of output of digit span

%text
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('TextSize', window, 70);
Screen('TextFont', window, 'Helvetica');
DrawFormattedText(window, str_span_output ,...
'center', screenYpixels * 0.5, [0 0 1]);
Screen('Flip', window, 0.25);
span_input = GetEchoString(window, 'Type digits here:', 500, 675, black, white);

%actual loop 
%while count <= rounds
	%ii =  count ;
	
        
  
 
	%if  span_output == span_input 
		%score_span = score_span + 1;
		%count = count + 1;
	%else
		%error_span = error_span + 1;
       % span_output = randi( 9, 1, ii+1); 
    %end
%end
%disp(score_span)
%disp(error_span)



KbStrokeWait;
sca;


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
 
%auditory loop code 
% variables
score_span = 0 ; %score 
count = 1 ; %number of rounds participant is on
rounds = 12; %total number of rounds set by tester, 7-9 usually max
error_span = 0; %number of errors
correct = zeros(1, rounds);
 
DrawFormattedText(window, 'Directions: Type the numbers you hear and press enter when done.' ,...
'center', 'center');
Screen('Flip', window, 1);
WaitSecs(2);

while count <= rounds %actual loop
span_output = randi( 9, 1, count); %output of digit span
sound_output = span_output;

%stimuli 
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);
numSecs = 1; % duration each frame will be displayed for
vbl = Screen('Flip', window, numSecs); 

%PSEUDO: as long as there are digits in span_output
if sound_output(1) == 0
%PLAY SOUND zero
 	span_output(1) = [ ];
elseif sound_output(1) == 1
%PLAY SOUND one
 	span_output(1) = [ ];
elseif sound_output(1) == 2
%PLAY SOUND two
 	span_output(1) = [ ];
elseif sound_output(1) == 3
%PLAY SOUND three
 	span_output(1) = [ ];
elseif sound_output(1) == 4
%PLAY SOUND four
 	span_output(1) = [ ];
elseif sound_output(1) == 5
%PLAY SOUND five
 	span_output(1) = [ ];
elseif sound_output(1) == 6
%PLAY SOUND six
 	span_output(1) = [ ];
elseif sound_output(1) == 7
%PLAY SOUND seven
 	span_output(1) = [ ];
elseif sound_output(1) == 8
%PLAY SOUND eight
 	sound_output(1) = [ ];
else
%PLAY SOUND nine
 	sound_output(1) = [ ];
end

%input text code 
span_input = str2num(GetEchoString(window, 'Type digits here:', 500, 675, black, white));
 
   	if  span_output ~= span_input 
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
 
%KbStrokeWait;
sca;


[wavedata, freq] = audioread('Elevator Beep.m4a'); % load sound file
InitializePsychSound(1); % initializes sound driver with low latency settings
pahandle = PsychPortAudio('Open', 3, 1, 1, freq, 2);
PsychPortAudio('FillBuffer', pahandle, [wavedata, wavedata]');
PsychPortAudio('Start', pahandle); %starts sound immediately
PsychPortAudio('Stop', pahandle, 1); % wait for the audio to finish playing
PsychPortAudio('Close', pahandle); % Close the audio device





[wavedata, freq] = audioread('Elevator Beep.m4a'); % load sound file
InitializePsychSound(1); % initializes sound driver with low latency settings
pahandle = PsychPortAudio('Open', [], 1, 1, freq, 2);
PsychPortAudio('FillBuffer', pahandle, [wavedata, wavedata]');
PsychPortAudio('Start', pahandle); %starts sound immediately
PsychPortAudio('Stop', pahandle, 1); % wait for the audio to finish playing
PsychPortAudio('Close', pahandle); % Close the audio device



[wavedata, freq] = audioread('Elevator Beep.m4a'); % load sound file
InitializePsychSound(1); % initializes sound driver with low latency settings
% Open Psych-Audio port, with the following arguments
% (1) [] = default sound device
% (2) 1 = sound playback only
% (3) 1 = default level of latency
% (4) Requested frequency in samples per second
% (5) 2 = number of channels, for stereo output
pahandle = PsychPortAudio('Open', [], 1, 1, freq, 2);
% here, we add an array with the wavedata twice, once per channel
PsychPortAudio('FillBuffer', pahandle, [wavedata, wavedata]');
PsychPortAudio('Start', pahandle); %starts sound immediately
PsychPortAudio('Stop', pahandle, 1); % wait for the audio to finish playing
PsychPortAudio('Close', pahandle); % Close the audio device


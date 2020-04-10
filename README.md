# SWD_AUTOSCORE REPOSITORY FOR SWD AUTODETECTION IN SYNGAP1 RATS

1. Create folder on C://SCRIPTS
2. Save SEIZURE_AUTOSCORE folder and set path with subfolders on Matlab

3. Load SWD_autodetect.m and replace variables according to:

%%% VARIABLES TO FEED

%% DEFINE RECORDING
 
pn='F:\DATA\EEG_From_Tom'; %% Main folder
d='Rat_692_Baseline_tone_light'; %% Recording folder
day= 'Baseline_tone_light'; %% Day
ratname='Rat_692'; %% Rat name
c='101_CH12.continuous'; % Channel to Analyse i.e for CAGES A-B-C-D = 20 - 52 - 84 - 116

%% DEFINE THRESHOLD CORRECTION FOR TAINI (USE TAINI CORRECTION 1 FOR CLEAN DATA AS YOURS)
Taini_correction=1; % 1 for Taini, 0 for Open Ephys USE TAINI CORRECTION LAST TIME AND WORKED


%% DEFINE WHOLE OR PART OF RECORDING = not need to round
Define_sample = 0; %% if 0 uses whole recording, if 1 to use defined start/end below
start_t=1; %% Sample point to start analysis 
end_t=7632000; %% Sample point to end analysis

%% DEFINE SAMPLING RATE (KEEP DOWNSAMPLING, USE Downsamp_factor = 2)
Origin_rate = 2000 %% Original Sampling Rate in Hz
Downsamp_factor = 2 %% To get sampling rate at 1 KHz (better analysis). i.e = for 250 original, downsampling factor = 0.25 to get 1 KHz

4. Run SWD_autodetect.m and answer to the incoming windows/menus


POP-UP WINDOWS: ANSWER YES TO CHECK EVENTS AND NO WHEN YOU WANT TO STOP CHECKING
ANSWER YES TO SAVE RESULTS
WILL ASK YOU AGAIN TO CHECK EVENTS, YOU CAN PROCEED OR SAY NO AND LEAVE

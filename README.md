# SWD_AUTOSCORE REPOSITORY FOR SPIKE AND WAWE DISCHARGES (SWD) AUTODETECTION IN SYNGAP1 RATS BY CEPSTRUM ANALYSIS OF EEG SIGNAL
Dr. Ingrid Buller 2020 
Contact for code: Dr. Alfredo Gonzalez-Sulser: agonzal2@ed.ac.uk
@Gonzalez-Sulser-Team
CDBS - SIDB - University of Edinburgh 

CODE WRITERN ON MATLAB R2018b

1. Create folder on C://SCRIPTS
2. Put inside the provided toolbox folders (analysis-tools-master, openephys and chronux_2_11 packaged on a .rar file)
3. Also put the main SWD-autodetection codes: cepstral_detection.m, SWD_autoscore.m and first_spec.m. 

4. Load the main script SWD_autodetect.m and replace variables according to:

%%% VARIABLES TO FEED

%% DEFINE RECORDING
pn='F:\DATA\EEG_recoding; %% Main folder
d='Rat_1'; %% Recording folder
day= 'BL'; %% Day
ratname='Rat_1'; %% Rat name
c='100_CH1.continuous'; % EEG Channel to Analyse 

%% DEFINE THRESHOLD METHOD DEPENDING RECODING QUALITY 
quality_correction=0; % 1 for Clean or Filtered Records, 0 for Raw Noisy Records

%% DEFINE WHOLE OR PART OF RECORDING
Define_sample = 0; %% if 0 uses whole recording, if 1 to use defined start/end below
start_t=1; %% Sample point to start analysis 
end_t=7632000; %% Sample point to end analysis

%% DEFINE SAMPLING RATE
Origin_rate = 1000; %% Original Sampling Rate in Hz
Downsamp_factor = 1; %% To get sampling rate at 1 KHz (better analysis). i.e = for 2000 Hz original, downsampling factor = 2 to get 1 KHz

5. Run SWD_autodetect.m and answer to the incoming windows/menus


POP-UP WINDOWS: ANSWER YES TO CHECK EVENTS AND NO WHEN YOU WANT TO STOP CHECKING
ANSWER YES TO SAVE RESULTS


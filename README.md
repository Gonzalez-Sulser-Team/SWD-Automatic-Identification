# SWD_AUTOSCORE REPOSITORY FOR SPIKE AND WAWE DISCHARGES (SWD) AUTODETECTION IN SYNGAP1 RATS BY CEPSTRUM ANALYSIS OF EEG SIGNAL
 


Contact for code: Dr. Alfredo Gonzalez-Sulser: agonzal2@ed.ac.uk
@Gonzalez-Sulser-Team
CDBS - SIDB - University of Edinburgh 
[[DOI](https://zenodo.org/badge/254316014.svg)](https://zenodo.org/doi/10.5281/zenodo.12700971)

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

![SWD Detection](https://github.com/Gonzalez-Sulser-Team/SWD-Automatic-Identification/blob/master/AutomaticSWDDetection.jpg?raw=true "SWD Detection")


Automatic Detection of SWD Example Method. A) Example spectrogram of SWD. B) Raw EEG trace corresponding to time interval of the spectrogram in A (bottom), with two selected SWD epochs (0.2 sec each) marked with blue and red vertical lines. Inserts (top) show respective cestral power analysis showing the fundamental frequency (f0) peak on the pseudo-time domain (top inset) and pseudo-frequency domain (bottom inset). C) Peak absolute maximum value and transformed into z-scores. Threshold for detection SWD events marked with dashed red line. D) Detected SWDs transformed into zeros (below threshold) or ones (threshold or over) in the time interval shown in A and B. Events counted as one (< 1 s) between events) are marked by blue lines, whereas black squares desgignate discarded events (length <0.8 s). 


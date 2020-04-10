%%% SPIKE AND WAWE DISCHARGES (SWD) AUTODETECTION
%%% DETECTS ABSCENCE SEIZURES BY CEPSTRUM ANALYSIS OF SIGNAL
%%% Ingrid Buller 2020 - ingrid.buller@ed.ac.uk
%%% @Gonzalez-Sulser-Team
%%% CDBS - SIDB - University of Edinburgh 

%%% MAIN SCRIPT TO RUN ANALYSIS
%%% VARIABLES TO FEED


clearvars;
%% DEFINE RECORDING 
pn='F:\DATA\EEG_recoding'; %% Main folder
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

dn = [pn '\' d];
c1= [dn '\' c]; 
samprate = Origin_rate/Downsamp_factor;

%%% Load as Mat
cn1=load_open_ephys_data(c1);

%%% Downsampling
ch=downsample(cn1,Downsamp_factor);

%%% Subsample to part of recording
if Define_sample == 1
	samp_start = start_t;
      else
	samp_start = 1;
end

if Define_sample == 1
	samp_end = end_t/Downsamp_factor;
      else
	samp_end = length(ch);
end    

ch1=ch(samp_start:samp_end);	
eegch = ch1;

[Seizures,Seiz_Totals,timesec,freq,logspec,timedomain,cspectral,id_cspectral,seiz_cepstral,Seiz_score] = cepstral_detection(eegch,samprate,ratname,day,pn,quality_correction);


%% MT SPECGRAM
function [spec]=first_spec(eegch,tstartstop,samprate)

ds=1; %%downsampling if wanted

W=2; 
T=1; %%secs 
p=1;
t= (2*T*W)-p

movingwin=[T 0.2];

params.tapers= [W T p];
params.pad=1;

params.fpass=[0 80];
params.trialave=1;

%load channel for FFT
csc = eegch;
ts = 1/samprate:1/samprate:length(eegch)/samprate;
    %load channel data
    %[csc0, ts0, info0] = load_open_ephys_data([dn '\' fn]);
     % downsampled
     %csc = downsample(csc0,ds);
     %ts = downsample(ts0,ds);
         
     [ind]=find_in_interval(tstartstop, ts);
     % filter the raw traces
     % [cscf] = eegfilt(csc,200,1,100);
        
     
     params.Fs=samprate;
     
     [S,t,f]=mtspecgramc(csc(ind),movingwin,params); 
     
  spec.S=S;
  spec.t=t;
  spec.f=f;
 
 
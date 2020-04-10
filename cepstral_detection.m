
%%% CEPSTRAL ANALYSIS FOR SWD AUTODETECTION
%%% Ingrid Buller 2020 - ingrid.buller@ed.ac.uk
%%% @Gonzalez-Sulser-Team
%%% CDBS - SIDB - University of Edinburgh 


function [Seizures,Seiz_Totals,timesec,freq,logspec,timedomain,cspectral,id_cspectral,seiz_cepstral,Seiz_score] = cepstral_detection(eegch,samprate,ratname,day,pn,quality_correction)

tstartstop = [0 length(eegch)/samprate]; %In secs
done=1;
while done==1
[spec]=first_spec(eegch,tstartstop,samprate);
done = exist('spec')-1;
end
done=1;
while done==1
	timedomain = (1:1:length(eegch));
	freqdomain = getfield(spec,'S');
	logspec = log(abs(freqdomain)+sqrt(-1)*unwrap(angle(freqdomain)));
	done=0;
end

%%% WAIT HERE FOR SPECTROGRAM COMPUTATION------------------------------------------------------------
logspec = logspec'; % rows to cols

%%%--------------------------------------------------------------------------------------------------
%% CEPSTRAL ANALYSIS--------------------------------------------------------

cspectral = real(ifft(logspec)); %cepstrum analisys
freq = getfield(spec,'f'); %freq vector in hz
tiempo = getfield(spec,'t'); %time vector in secs
yt=[,0.10 0.30 ];
yt=yt';
tiempo_fin=length(tiempo);
yy=[, tiempo(1,tiempo_fin)+0.2,tiempo(1,tiempo_fin)+0.4,tiempo(1,tiempo_fin)+0.6];
yy=yy';
tiempo = tiempo';
timesec =[yt;tiempo;yy];
pw_cepts = 4*(cspectral);

bins = samprate./freq;
q = bins/samprate; % Quefrency
q(~isfinite(q)) = 2*q(1,2);
half_q = 1./q;

%%%%THRESHOLD ON THETA BAND OR LOWEST-------------------------------
if quality_correction == 1
    delta=sum(pw_cepts(3:12,:)); %(eliminate delta from main component)
    theta_cespt=pw_cepts(1,:)-delta;
    th=(15);
    maxval = max(theta_cespt,[],1); %max value in theta
    seiz_cepstral=maxval;
else
    theta_cespt = pw_cepts([10:20],:); %(focus on theta)
    th=(2.2*10^-5);
    maxval = max(theta_cespt,[],1); %max value in theta
    peak=max(maxval); %max theta value in all bins
    seizscore=maxval/peak; %proportion of max
    seizscore(isnan(seizscore))=0; %Clears NANs
    norm_seizscore = normalize(seizscore); %normalize values to homogenize amplitude differences
    seiz_cepstral=norm_seizscore;
end

seiz_cepstral(seiz_cepstral < th) = 0; %sets 1 to seizure bins (2.2 SD from avg)
seiz_cepstral(seiz_cepstral >= th) = 1; %sets 1 to seizure bins (2.2 SD from avg)
id_cspectral = pw_cepts;
[~,n] = size(logspec);



%%%--------------------------------------------------------------------------------------------------
%%% GET DGE SEIZ DGE FOR VISUAL COMPARISON ON IGOR-------------------------------------------------------------
DGE_seiz = [];
for i = 1:numel(seiz_cepstral)
	if seiz_cepstral(i) == 1 
	   	   DGE_seiz(i) = 6;
	        else
	           DGE_seiz(i) = 4;
	        end
end
xt=[,4 4 ];
xt=xt';
xx=[, 4 4 4];
xx=xx';
DGE_seiz = DGE_seiz'; %TO COLUMN
Seiz_score=[xt;DGE_seiz;xx];

%%%--------------------------------------------------------------------------------------------------
%%%GET TIME START-STOP AND TOTALS -------------------------------------------------------------------
%timesec=timesec';
score_start=[];
    for i = 2:n
            if Seiz_score(i) ==  6 & Seiz_score(i-1) ==  4 
		     score_start(i) = 1;
               else
		     score_start(i) = 0;
	    end
    end
score_start=score_start';
times=find(score_start>0);
time_start=timesec(times);

score_end=[];
    for i = 1:n
            if Seiz_score(i) ==  6 & Seiz_score(i+1) ==  4 | Seiz_score(end) ==  6
		     score_end(i) = 1;
               else
		     score_end(i) = 0;
	    end
    end
score_end=score_end';
times=find(score_end>0);
time_end=timesec(times);

 for i = 1:numel(time_start)
            if Seiz_score(i) ==  6 & Seiz_score(i+1) ==  4 | Seiz_score(end) ==  6
		     score_end(i) = 1;
               else
		     score_end(i) = 0;
	    end
    end 
%%%--------------------------------------------------------------------------------------------------
%%%CHECK IF START-END VECTOR HAVE SAME SIZE ---------------------------------------------------------
if numel(time_end(:,1)) < numel(time_start(:,1))
   time_start(end,:) = []; 
end

if numel(time_end(:,1)) > numel(time_start(:,1))
   time_end(end,:) = []; 
end

dur=time_end-time_start;
if max(dur) == 0
   disp 'NO SEIZURES FOUND!!!!!!!';
   choice = menu('No Seizures Found, Quit?','Yes','No');
	  if choice==1 | choice==0
   	     return;
	  end
	disp 'GO';
end


%%%--------------------------------------------------------------------------------------------------
%%% (NOT!) REMOVE EVENTS WITH DURATION = 0 -----------------------------------------------------------------
ceros=find(dur>=0);
timestart_end = [time_start(ceros) time_end(ceros)]; 
%%%--------------------------------------------------------------------------------------------------
%%% COLLAPSE EVENTS SEPARATED BY LESS THAN 2 SEC ----------------------------------------------------
maxLag = 2;
[idx,idx] = sort(timestart_end(1,:));
times_close = timestart_end(:,idx);
test = times_close(2:end,1)-times_close(1:end-1,2);
tooCloseIDs = find(test < maxLag );%& test >=0);

%%% COLLAPSE LOOP -----------------------------------------------------------------------------------
while numel(tooCloseIDs) > 0
    for i = numel(tooCloseIDs):-1:1
        times_close(tooCloseIDs(i),2) = times_close(tooCloseIDs(i)+1,2);
    end
    times_close(tooCloseIDs+1,:) = [];
    test = times_close(2:end,1)-times_close(1:end-1,2);
    tooCloseIDs = find(test < maxLag );%& test >=0);
    disp 'collapsing events...';
end

Falses=find((times_close(:,2)-times_close(:,1))>0.8); %%% REMOVE ISOLATED "EVENTS" OF <0.8 SEC
seizEvtsMerged= [times_close(Falses,1) times_close(Falses,2)]; 


%%%--------------------------------------------------------------------------------------------------
%%% GETS NEW DURATIONS ------------------------------------------------------------------------------
seizEvtsMerged(:,3) = seizEvtsMerged(:,2) - seizEvtsMerged(:,1);  %Gets new Dur

%if length(seizEvtsMerged) <= 5 %%% CONSIDER OVER 5 EVENTS AS SEIZURE PRESENT
%   disp 'NO SEIZURES FOUND!!!!!!!';
%end

%%%--------------------------------------------------------------------------------------------------
%%% GET TOTAL NUMBER OF EVENTS AND MEAN DURATION IN SECS --------------------------------------------
N_seiz=length(seizEvtsMerged(:,3));
Mean_dur=mean(seizEvtsMerged(:,3));


%%%--------------------------------------------------------------------------------------------------
%%% CREATE TABLES WITH RESULTS ----------------------------------------------------------------------
colNames_A = {'N_event','mean_dur'};
colNames_B = {'sec_start','sec_end','dur'};
ALL= round(seizEvtsMerged,2);
Seizures= array2table(ALL,'VariableNames',colNames_B);

Totals = [N_seiz Mean_dur];
Seiz_Totals = array2table(Totals,'VariableNames',colNames_A);

while(1)
	choice = menu('Check Events?','Yes','No');
	if choice==1 | choice==0
   		for i = 1:N_seiz
    		figure(1);
    		set(gcf,'position',[51.4 456.2 1408 252.8])
    		clf;
    		subplot(2,1,1)
    		plot(timedomain,eegch)
		a=ALL(i,1);
		b=ALL(i,2);
		v=a*samprate;
		u=b*samprate;
    		xlim([v u])
    		ylim([-1000 1000])
    		ylabel ('Power (db)')
    		xlabel ('sample'); 
    		subplot(2,1,2)
    		imagesc(timesec,freq,logspec)
    		colormap jet
    		set(gca, 'ydir','normal', 'clim',[0 7])
    		set(gca, 'xlim' ,[a b]); %chunk of secs
    		xlabel ('Time (sec)')
    		ylabel ('Frequency (Hz)');
    		choice = menu('Keep checking?','Yes','No');
	  		if choice==2 | choice==0
   	     		break;
	  		end
		end
	else
	        break;
	end
end

while(1)
	choice = menu('Save Results?','Yes','No');
	if choice==1 | choice==0
   		%%% CREATE NEW DIR AND SAVE TOTALS AS .CSV ----------------------------------------------------------
		mkdir ([pn '\',ratname '_' day '-Seiz']);
		cd([pn '\',ratname '_' day '-Seiz']);
		outputdir=pwd;
		writetable(Seiz_Totals,[ratname '_' day '_Seiz_Totals.csv'])
		writetable(Seizures,[ratname '_' day '_Seizures.csv'])
	else
	        break;
	end
end
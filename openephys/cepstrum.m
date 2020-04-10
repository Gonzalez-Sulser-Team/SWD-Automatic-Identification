%%% CEPSTRUM ANALYSIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Cepstral Analysis with MATLAB Implementation  %
%                                                %
% Author: M.Sc. Eng. Hristo Zhivomirov  10/15/13 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [C, q] = cepstrum(x, fs)
% function: [C, q] = cepstrum(x, fs)
% x - signal in the time domain
% fs - sampling frequency, Hz
% C - real cepstrum
% q - quefrency vector, s

% represent x as column-vector
x = x(:);

% length of the signal
N = length(x);

% windowing
win = hanning(N, 'periodic');
x = x.*win;

% calculate the number of unique fft points
NumUniquePts = ceil((N+1)/2);

% cepstral analysis
C = real(ifft(log(abs(fft(x)))));       % two-sided cepstrum
C = C(1:NumUniquePts);                  % one-sided cepstrum
                                        
% quefrency vector computation
q = (0:NumUniquePts-1)/fs;              % complete quefrency vector

end
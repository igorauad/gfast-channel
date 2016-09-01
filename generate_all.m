clear all, close all
clc

set(0,'DefaultTextInterpreter','LaTex')
set(0,'DefaultAxesFontSize',11)

if (~exist('data/'))
    mkdir('data/');
end
%% Parameters
filename    = 'gfast_';
oversample  = 2;          % 1 if not using, > 1 for using
BW          = 105.984e6;
delta_f     = 51.75e3;    % Tone spacing
Zl          = 100;
Zso         = 100;

Params.shapingFunction = 1;  % Shaping function for TNO model:
                             %     0: 'rat'
                             %     1: 'sqrt_rat'

%% Consider the oversampling factor

% Original DFT size
Nfft = 2*BW / delta_f;

% Scale the FFT size based on the oversampling ratio:
Nfft      = oversample * Nfft;

% Final sampling frequency
Fs        = Nfft * delta_f;
% Note delta_f does not change with oversampling.

%% Derived Parametes

Params.Nfft      = Nfft;             % FFT size
Params.bandwidth = oversample*BW;    % Bandwidth
Params.Zl        = Zl;               % Load impedance
Params.Zso       = Zso;              % Source impedance

topologies = { 'D1-H1',... %1
               'D2-H2',... %2
               'D2-H1',... %3
               'D3-H5',... %4
               'D4-H5',... %5
               'D4-H3',... %6
               'D6-H6',... %7
               'D6-none'}; %8

BW          = Params.bandwidth;
Nfft        = Params.Nfft;
nTones      = Params.Nfft/2 + 1;
nLines      = length(topologies);
toneSpacing = Fs / Nfft;

%% Update filename

filename = [filename, 'spacing_', num2str(delta_f), '_N_', num2str(Nfft)];

%% Calculate equivalent ABCD

for iLine = 1:nLines
	% String specifying the current topology
    topology = topologies{iLine};
    % Load a struct definining each segment of the current topology
    Segments = assembleTopology(topology);
    % ABCD paramaters for each segment of the topology
    ABCD = topologyABCD(Params, Segments);
    % Overall channel impulse response:
    h = cirFromABCD( ABCD, Params );
    % Frequency response:
    H = fft(h, Nfft);
    % Save results
    save(['data/', filename, '_', topology], ...
        'H', 'h', 'Nfft', 'delta_f', 'Fs')
end


clear all
clc

set(0,'DefaultTextInterpreter','LaTex')
set(0,'DefaultAxesFontSize',11)

%% Parameters
filename = 'gfast_bundle_212mhz';

Params.shapingFunction = 1;  % Shaping function for TNO model:
                                %     0: 'rat'
                                %     1: 'sqrt_rat'
Params.Nfft      = 2*4096;         % FFT size
Params.bandwidth = 2*105.984e6;    % Bandwidth
Params.Zl        = 100;            % Load impedance
Params.Zso       = 100;            % Source impedance

topologies = { 'D1-H1',... %1
               'D2-H2',... %2
               'D2-H1',... %3
               'D3-H5',... %4
               'D4-H5',... %5
               'D4-H3',... %6
               'D6-H6',... %7
               'D6-none'}; %8

%% Derived Parametes

bandwidth = Params.bandwidth;
Nfft = Params.Nfft;
fs = 2 * bandwidth;
nTones = Params.Nfft/2 + 1;
nLines = length(topologies);
toneSpacing = fs / Nfft;


%% Calculate equivalent ABCD

H = zeros(nTones, nLines, nLines);

for iLine = 1:nLines
    topology = topologies{iLine};
    Segments = assembleTopology(topology);
    % ABCD paramaters for the topology
    ABCD = topologyABCD(Params, Segments);
    % Channel Impulse response:
    h = cirFromABCD( ABCD, Params );
    % Frequency response:
    H_freq = fft(h, Nfft);
    H(:, iLine, iLine) = H_freq(1:nTones, 1);
    figure
    plot(h)
end

%% Export channel struct

K = nTones;
N = nLines;
f = (0:(nTones - 1))*toneSpacing;

save(filename, 'H', 'K', 'N', 'f')


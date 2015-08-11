clear all, close all
clc

set(0,'DefaultTextInterpreter','LaTex')
set(0,'DefaultAxesFontSize',11)

%% Parameters
filename    = 'gfast_bundle_212mhz_oversampledBy2';
oversample  = 2;            % 1 if not using, > 1 for using
bandwidth   = 105.984e6;
Nfft        = 4096;
Zl          = 100;
Zso         = 100;


Params.shapingFunction = 1;  % Shaping function for TNO model:
                                %     0: 'rat'
                                %     1: 'sqrt_rat'

%% Derived Parametes

Params.Nfft      = oversample*2*Nfft;         % FFT size
Params.bandwidth = oversample*2*bandwidth;    % Bandwidth
Params.Zl        = Zl;                        % Load impedance
Params.Zso       = Zso;                       % Source impedance

topologies = { 'D1-H1',... %1
               'D2-H2',... %2
               'D2-H1',... %3
               'D3-H5',... %4
               'D4-H5',... %5
               'D4-H3',... %6
               'D6-H6',... %7
               'D6-none'}; %8

bandwidth = Params.bandwidth;
Nfft = Params.Nfft;
fs = 2 * bandwidth;
nTones = Params.Nfft/2 + 1;
nLines = length(topologies);
toneSpacing = fs / Nfft;

if(oversample > 1)
    D = fdesign.pulseshaping(oversample,'Raised Cosine', ...
        'Nsym,Beta', Nfft, 0.2);
    Hwindow = design(D); % H is a DFILT
    [Hd_window, W] = freqz(Hwindow, Nfft, 'whole');
    figure, plot(W/(2*pi), 20*log10(abs(Hd_window)))
    title('Frequency-domain Window');
    ylabel('Magnitude Response (dB)')
    xlabel('Digital Frequency (f / fs)')
end

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

    % If oversample is adopted, apply a non-rectangular window in freq.
    if(oversample > 1)
        figure
        plot((0:(Nfft-1))*toneSpacing*1e-6, 10*log10(abs(H_freq)))

        % Note: standard IFFT uses rectangular window, which may induce
        % ripples in the resulting impulse response.
        w = abs(Hd_window);

        % Apply window
        H_freq = H_freq .* w;

        hold on
        plot((0:(Nfft-1))*toneSpacing*1e-6, 10*log10(abs(H_freq)), 'r')
        legend('Original', 'Windowed')
        xlabel('Freq (MHz)')
    end

    H(:, iLine, iLine) = H_freq(1:nTones, 1);

    figure
    plot(h)

    if(oversample > 1)
        % New (windowed) response
        h = ifft(H_freq, Nfft);

        hold on
        plot(h, 'r')
        legend('Original', 'Windowed')
    end
end

%% Export channel struct

K = nTones;
N = nLines;
f = (0:(nTones - 1))*toneSpacing;

save(filename, 'H', 'K', 'N', 'f')


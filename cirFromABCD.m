function [ h ] = cirFromABCD( ABCD, Params )
% Compute the channel impulse response from ABCD parameters
% ---------------------------------------------------------
% [ h ] = cirFromABCD( ABCD, Params )
%
% Input passed within Params struct:
%   Nfft    - FFT size
%   Zl      - Load Impedance
%   Zso     - Source Impedance

%% Parameters

Nfft = Params.Nfft; % FFT size

% ABCD parameters:
A = squeeze(ABCD(1, 1, :));
B = squeeze(ABCD(1, 2, :));
C = squeeze(ABCD(2, 1, :));
D = squeeze(ABCD(2, 2, :));

% Load and Source Impedances:
Zl = Params.Zl;
Zso = Params.Zso;


%% Computation

%Transfer function from the equivalent ABCD parameters:
H = (Zl + Zso)./(A*Zl + B + Zso*(C*Zl+D) );

% Analytical representation:
H_ana = [H(1)/2; H(2:end-1); H(end)/2; zeros((Nfft/2)-1,1)];

% Channel Impulse Response:
h = 2*real(ifft(H_ana));


end


function [ABCD] = BT_ABCD(bandwidth, Nfft, params, dist, isBridgeTap)
% 	Compute a multi-dimensional ABCD matrix using BT model fitting
% ----------------------------------------------------------------
%   ABCD matrix has dimensions (2, 2, nTones)
%
% Input Parameters:
%              - bandwidth
%              - Nfft: FFT size
%              - params: model parameters
%              - dist: Cable length
%              - isBridgeTap: flag that indicates a bridge tap

% Frequency vector
f_spacing = (2*bandwidth)/Nfft;
f = (eps:f_spacing:((Nfft/2)*f_spacing)).';

% Preallocate ABCD matrix
ABCD = zeros(2, 2, Nfft/2+1);

%% Store input parameters

roc = params(1); ac = params(2); ros = params(3); as = params(4);
l0 = params(5); linf = params(6); fm = params(7); nb = params(8);
g0 = params(9); nge = params(10); c0 = params(11); cinf = params(12);
nce = params(13);

%% Calculation of intermediary parameters

% R(f)
R = sqrt(sqrt( roc.^4 + ac*(f.^2) ));

% L(f)
ffmb = (f/fm).^nb;
L = (l0 + linf*ffmb)./(1 + ffmb);

%% C(f) and G(f)
C = cinf + c0*(f.^(-nce));
G = g0*(f.^(nge));

% Secondary Parameters and KHM Fitting to the segment
Zs = R + 1j*2*pi*f.*L;
Yp = G + 1j*2*pi*f.*C;

%% Evaluate Twisted-pair Primary and Secondary Parameters

Z0 = sqrt(Zs./Yp);                             % Characteristic Impedance
gamma = sqrt(Zs.*Yp);                          % Propagation Constant

arg=gamma*(dist/1000);            % Argument for the following hyperbolic
                                  % functions

%% Compute ABCD matrix and return

if (isBridgeTap) % If the requested ABCD are from a bridged tap
    A = ones(Nfft/2+1,1);
    B = zeros(Nfft/2+1,1);
    C = tanh(arg)./Z0;
    D = ones(Nfft/2+1,1);
else
    A = cosh(arg);
    B = Z0.*sinh(arg);
    C = (1./Z0).*sinh(arg);
    D = A;
end

% Compose ABCD matrix
ABCD(1, 1, :) = A;
ABCD(1, 2, :) = B;
ABCD(2, 1, :) = C;
ABCD(2, 2, :) = D;

end










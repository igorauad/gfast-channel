function [ABCD] = TNO_ABCD(bandwidth, Nfft, params, distance, isBridgeTap, shapingFunction)
% 	Compute multi-dimensional ABCD matrix using TNO model
% ---------------------------------------------------------
%   ABCD matrix has dimensions (2, 2, nTones)
%
%   Input Parameteres:
% bandwidth             Bandwidth
% Nfft                  FFT size
% params                TNO parameters
% distance              Cable length
% isBridgeTap           Flag to indicate a bridge tap
%
%   Output:
% A, B, C and D matrices
%
% Note: A, B, C and D are a function of the frequency.

%% Definitions

f_spacing = (2*bandwidth)/Nfft;                % FFT frequency spacing
f = (eps:f_spacing:((Nfft/2)*f_spacing)).';    % Frequency vector
w=2.*pi.*f;                                 % Angular frequency

%% Store input parameters
switch shapingFunction
        case 0 % rat
        Z0inf = params(1); nvf=params(2); Rs0=params(3); ql=params(4);
        qh=params(5); phi=params(6); fd=params(7);
        case 1 % sqrt_rat
        Z0inf = params(1); nvf=params(2); Rs0=params(3); ql=params(4);
        qh=params(5); qx=params(6); qy=params(7); phi=params(8);
        fd=params(9);
end

%% Calculation of intermediary parameters

c0 = 3*10^8;
mu0 = 4*pi*10^-7;
Lsinf = (1/(nvf*c0))*Z0inf;
Cp0 = (1/(nvf*c0))*(1/Z0inf);
qs = 1/(qh^2*ql);
ws = qh^2*((4*pi*Rs0)/mu0);
wd = 2*pi*fd;

if (length(params) == 10)
    qc = params(10);
end

%% Select desired shaping function

switch shapingFunction
    case 0 % rat
    qshap = sqrt( qs^2 + 2*(j.*w./ws) );
    case 1 % sqrt_rat
    qshap = qs -qs*qx + sqrt( (qs^2)*(qx^2) + (2*j.*w./ws).* ...
        ( (qs^2 + (j.*w./ws)*qy)./( ((qs^2)/qx) + (j.*w./ws).*qy ) ) );
end

%% Evaluate Twisted-pair Primary and Secondary Parameters

Zs = j.*w.*Lsinf + Rs0.*( 1-qs + qshap);       %Series Impedance

%Shunt Admitance:
if(exist('qc','var'))
    Yp = j.*w.*Cp0*(1-qc).*(1+ (j.*w./wd)).^(-2*phi/pi) + j.*w.*Cp0*qc;
else
    Yp = j.*w.*Cp0.*(1+ (1j.*w./wd)).^(-2*phi/pi);
end

Z0 = sqrt(Zs./Yp);                             % Characteristic Impedance
gamma = sqrt(Zs.*Yp);                          % Propagation Constant

arg=gamma*distance;       % Argument for the following hyperbolic functions

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





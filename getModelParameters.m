function [ params ] = getModelParameters(cable, shapingFunction)
%   Return the set of parameters for a given cable modle
%  -------------------------------------------------------------
%  [ params ] = getModelParameters(cable, shapingFunction)
%
%       Parameters returned are according to the choice of the cable type
% and shaping function (when TNO model is used).
%
%   Cable_type defines the type of the cable, e.g. CAT5, Medium Quality,
%   Low Quality, KPN, etc
%
%   shapingFunction - if TNO model is adopted, this parameter is required.
%   It defines the reference shaping function (rat or sqrt_rat)
%       0: 'rat'
%       1: 'sqrt_rat'
%
%
% Current available cables:
% 1 - CAT5 from 11GS3-028
% 2 - Medium Quality from 11GS3-028
% 3 - Low quality cable from 11GS3-028
% 4 - KPN cable 11GS3-028
% 5 - CAD55 (B05a) from G.fast Draft (2013-07-Q4-R20)
% 6 - T05u from G.fast Draft (2013-07-Q4-R20)
% 7 - T05b from G.fast Draft (2013-07-Q4-R20)
% 8 - T05h from G.fast Draft (2013-07-Q4-R20)
% 9 - A26j (AWG 26)
% 10 - A24u (AWG 24)
% 11 - TNO CAT5 cable
%
% Note: Usually there are 9 TNO model paramaters. However, on G.fast draft,
% for some cables a 10th parameter (qc) is informed. When qc is informed,
% put it as the last element of the parameters vector (see case 5, for
% example, in which qc = 1.0016).
switch cable
    case 1
        if (shapingFunction)
            % Set of reference parameters for CAT5 (pg 5 of 11GS3-028)
            params = [98 0.690464 165.900000e-3 2.150000 0.859450 0.500000 0.722636 0.973846e-3 1];
        else
            % Set of parameters to compare with the curves shown in 11GS3-028 (pg 20-24)
            params = [100 0.685777 166.700000e-3 2.150000 0.836789 1.038058e-3 1];
        end

    case 2
        if (shapingFunction)
            % Set of reference parameters for medium quality cable (pg 5 of 11GS3-028)
            params = [132.348256 0.675449 170.500000e-3 1.789725 0.725776 0.799306 1.030832 0.005222e-3 1];
        else
            % Set of parameters to compare with the curves shown in 11GS3-028 (pg 29-33)
            params = [131.056172 0.671482 172.400000e-3 1.742162 0.753511 0.740625 1.031628 0.799537e-3 1];
        end

    case 3
        if (shapingFunction)
            % Set of reference parameters for low quality cable (pg 5 of 11GS3-028)
            params = [98.369783 0.681182 170.800000e-3 1.700000 0.650000 0.777307 1.500000 3.023930e-3 1];
        else
            % Set of parameters to compare with the curves shown in 11GS3-028 (pg 38-42)
            params = [99.108537 0.678032 170.600000e-3 1.700000 0.650000 0.767736 1.499999 3.113495e-3 1];
        end

    case 4
        if (shapingFunction)
            % Set of reference parameters for KPN cable (pg 5 of 11GS3-028)
            params = [125.636455 0.729623 180.000000e-3 1.666055 0.740000 0.848761 1.207166 1.762056e-3 1];
        else
            % Set of parameters to compare with the curves shown in 11GS3-028  (pg 45-48)
            params = [128.009539 0.729667 180.000000e-3 1.716635 0.709986 0.928581 1.350286 1.952262e-3 1];
        end
    case 5  % G.fast Draft - CAD55 (B05a) - Pg. 112 2013-07-Q4-R20
        params = [105.0694 0.6976 0.1871 1.5315 0.7415 1 0 -0.2356 1 1.0016];
    case 6  % G.fast Draft - T05u - Pg. 112 2013-07-Q4-R20
        params = [125.636455 0.729623 180.000000e-3 1.666050 0.74 0.848761 1.207166 1.762056e-3 1];
    case 7  % G.fast Draft - T05b - Pg. 112 2013-07-Q4-R20
        params = [132.348256, 0.675449, 170.500000e-3, 1.789725, 0.725776, 0.799306, 1.030832, 0.005222e-3, 1];
    case 8  % G.fast Draft - T05h - Pg. 112 2013-07-Q4-R20
        params = [98.369783, 0.681182, 170.8e-3, 1.7, 0.65, 0.777307, 1.5, 3.023930e-3, 1];
    case 9  % A26j  ANSI_26AWG
        params = [286.17578, 0.14769620, 0, 0, 0.00067536888, 0.00048895186, 806338.63, 0.92930728, 0, 0, 0, 50e-9, 0];
    case 10 % A24u - AWG 24
        params = [174.55888, 0.053073481, 0, 0, 0.00061729593, 0.00047897099, 553760.63, 1.1529766, 0, 0, 0, 50e-9, 0];
    case 11 % TNO CAT5 cable model
        params = [98 0.690464 165.900000e-3 2.150000 0.859450 0.500000 0.722636 0.973846e-3 1];
    case 12 % CAD55-1 by BT
        params = [187.0831, 0.0457, 0, 0, 6.5553e-004, 5.0973e-004, 8.1241e+005, 1.0142, 1.0486e-010, 1.1500, -6.9514e-011, 4.5578e-008, -0.1500];
end
end


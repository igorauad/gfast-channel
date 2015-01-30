function [Segments] = assembleTopology(topology)
%   Assembles the topology segments into a struct
% ----------------------------------------------------------
%   [Segments] = assembleTopology(topology)
%       Struct should contain the segment Id, its length, a flag to
% indicate whether it is a bridge tap or not (ABCD formula changes for a
% bridge tap) and the model to be used for computing the ABCD.
%
% Input: topology choice
%
%
% Available Topologies:
%   - D1-H1 (missing A26u parameters, substituted by A26j)
%   - D2-H2 (missing CAT-3 parameters, substituted by A24u)
%   - D2-H1
%   - D3-H5 (missing B05??? and B05cw, both substituted by B05a)
%   - D4-H5 (missing B05???, B05u and B05cw, all substituted by B05a)
%   - D4-H3 (missing B05???, B05u and B05cw, all substituted by B05a)
%   - D6-H6
%   - D6-none
%
% Note: A26j and A24u parameters were also not provided in the G.fast
% draft. They are being modeled by BT parameters specified for AWG26 and
% AWG24.
%

%% Main
switch topology

    case 'D1-H1'
        nSegments = 4;

        % Preallocate
        Segments(nSegments).id = [];
        Segments(nSegments).length = [];
        Segments(nSegments).isBridgeTap = [];
        Segments(nSegments).model = [];

        % 1st segment (A26j, AWG 26, 0.6 m)
        Segments(1).id = 9;
        Segments(1).length = 0.6;
        Segments(1).isBridgeTap = 0;
        Segments(1).model = 'BT';

        % 2nd segment (A26u, 60 m)
        % Temporarily using the same paraters as A26j
        Segments(2).id = 9;
        Segments(2).length = 60;
        Segments(2).isBridgeTap = 0;
        Segments(2).model = 'BT';

        % 3rd segment (A24u, AWG 24, 93 m)
        Segments(3).id = 10;
        Segments(3).length = 93;
        Segments(3).isBridgeTap = 0;
        Segments(3).model = 'BT';

        % 4th segment (CAT-5, 1.5m)
        Segments(4).id = 11;
        Segments(4).length = 22.5;
        Segments(4).isBridgeTap = 0;
        Segments(4).model = 'TNO';

    case 'D2-H2'
        nSegments = 9;
        % Preallocate
        Segments(nSegments).id = [];
        Segments(nSegments).length = [];
        Segments(nSegments).isBridgeTap = [];
        Segments(nSegments).model = [];

        % 1st segment (A26j, AWG 26, 0.6 m)
        Segments(1).id = 9;
        Segments(1).length = 0.6;
        Segments(1).isBridgeTap = 0;
        Segments(1).model = 'BT';

        % 2nd segment (A24u, AWG 24, 93 m)
        Segments(2).id = 10;
        Segments(2).length = 93;
        Segments(2).isBridgeTap = 0;
        Segments(2).model = 'BT';

        % Bridge taps:

        % 1st - CAT-3 30 m
        Segments(3).id = 10;
        Segments(3).length = 30;
        Segments(3).isBridgeTap = 1;
        Segments(3).model = 'BT';

        % 2nd - CAT-3 22.5 m
        Segments(4).id = 10;
        Segments(4).length = 22.5;
        Segments(4).isBridgeTap = 1;
        Segments(4).model = 'BT';

        % 3rd - CAT-3 15 m
        Segments(5).id = 10;
        Segments(5).length = 15;
        Segments(5).isBridgeTap = 1;
        Segments(5).model = 'BT';

        % 4th - CAT-3 7.5 m
        Segments(6).id = 10;
        Segments(6).length = 7.5;
        Segments(6).isBridgeTap = 1;
        Segments(6).model = 'BT';

        % 5th - CAT-3 3.8 m
        Segments(7).id = 10;
        Segments(7).length = 3.8;
        Segments(7).isBridgeTap = 1;
        Segments(7).model = 'BT';

        % 3rd segment (CAT-3, 45m)
        Segments(8).id = 10;
        Segments(8).length = 45;
        Segments(8).isBridgeTap = 0;
        Segments(8).model = 'BT';

        % 4th segment (CAT-5, 1.5m)
        Segments(9).id = 11;
        Segments(9).length = 1.5;
        Segments(9).isBridgeTap = 0;
        Segments(9).model = 'TNO';

    case 'D2-H1'

        nSegments = 3;
        % Preallocate
        Segments(nSegments).id = [];
        Segments(nSegments).length = [];
        Segments(nSegments).isBridgeTap = [];
        Segments(nSegments).model = [];

        % 1st segment (A26j, AWG 26, 0.6 m)
        Segments(1).id = 9;
        Segments(1).length = 0.6;
        Segments(1).isBridgeTap = 0;
        Segments(1).model = 'BT';

        % 2nd segment (A24u, AWG 24, 93 m)
        Segments(2).id = 10;
        Segments(2).length = 93;
        Segments(2).isBridgeTap = 0;
        Segments(2).model = 'BT';

        % 3rd segment (CAT-5, 22.5m)
        Segments(3).id = 11;
        Segments(3).length = 22.5;
        Segments(3).isBridgeTap = 0;
        Segments(3).model = 'TNO';

    case 'D3-H5'

        nSegments = 3;

        % Preallocate
        Segments(nSegments).id = [];
        Segments(nSegments).length = [];
        Segments(nSegments).isBridgeTap = [];
        Segments(nSegments).model = [];

        % 1st segment (B05???, assume as B05a, 0.6 m)
        Segments(1).id = 5;
        Segments(1).length = 0.6;
        Segments(1).isBridgeTap = 0;
        Segments(1).model = 'TNO';

        % 2nd segment (B05a, 35 m)
        Segments(2).id = 5;
        Segments(2).length = 35;
        Segments(2).isBridgeTap = 0;
        Segments(2).model = 'TNO';

        % 3rd segment (B05cw, assume as B05a, 10 m)
        Segments(3).id = 5;
        Segments(3).length = 10;
        Segments(3).isBridgeTap = 0;
        Segments(3).model = 'TNO';

    case 'D4-H5'

        nSegments = 4;

        % Preallocate
        Segments(nSegments).id = [];
        Segments(nSegments).length = [];
        Segments(nSegments).isBridgeTap = [];
        Segments(nSegments).model = [];

        % 1st segment (B05???, assume as B05a, 0.6 m)
        Segments(1).id = 5;
        Segments(1).length = 0.6;
        Segments(1).isBridgeTap = 0;
        Segments(1).model = 'TNO';

        % 2nd segment (B05u, assume as B05a, 3 m)
        Segments(2).id = 5;
        Segments(2).length = 3;
        Segments(2).isBridgeTap = 0;
        Segments(2).model = 'TNO';

        % 3rd segment (B05a, 70 m)
        Segments(3).id = 5;
        Segments(3).length = 70;
        Segments(3).isBridgeTap = 0;
        Segments(3).model = 'TNO';

        % 4th segment (B05cw, assume as B05a, 10 m)
        Segments(4).id = 5;
        Segments(4).length = 10;
        Segments(4).isBridgeTap = 0;
        Segments(4).model = 'TNO';

    case 'D4-H3'

        nSegments = 6;

        % Preallocate
        Segments(nSegments).id = [];
        Segments(nSegments).length = [];
        Segments(nSegments).isBridgeTap = [];
        Segments(nSegments).model = [];

        % 1st segment (B05???, assume as B05a, 0.6 m)
        Segments(1).id = 5;
        Segments(1).length = 0.6;
        Segments(1).isBridgeTap = 0;
        Segments(1).model = 'TNO';

        % 2nd segment (B05u, assume as B05a, 3 m)
        Segments(2).id = 5;
        Segments(2).length = 3;
        Segments(2).isBridgeTap = 0;
        Segments(2).model = 'TNO';

        % 3rd segment (B05a, 70 m)
        Segments(3).id = 5;
        Segments(3).length = 70;
        Segments(3).isBridgeTap = 0;
        Segments(3).model = 'TNO';

        % 4th segment (B05cw, assume as B05a, 10 m)
        Segments(4).id = 5;
        Segments(4).length = 10;
        Segments(4).isBridgeTap = 0;
        Segments(4).model = 'TNO';

        % 5th segment, bridge tap (B05cw, assume as B05a, 5 m)
        Segments(5).id = 5;
        Segments(5).length = 5;
        Segments(5).isBridgeTap = 1;
        Segments(5).model = 'TNO';

        % 6th segment (B05cw, assume as B05a, 10 m)
        Segments(6).id = 5;
        Segments(6).length = 10;
        Segments(6).isBridgeTap = 0;
        Segments(6).model = 'TNO';

    case 'D6-H6'

        nSegments = 6;

        % Preallocate
        Segments(nSegments).id = [];
        Segments(nSegments).length = [];
        Segments(nSegments).isBridgeTap = [];
        Segments(nSegments).model = [];

        % 1st segment (A26j, ANSI AWG 26, 0.6 m)
        Segments(1).id = 9;
        Segments(1).length = 0.6;
        Segments(1).isBridgeTap = 0;
        Segments(1).model = 'BT';

        % 2nd segment (T05u, 50 m)
        Segments(2).id = 6;
        Segments(2).length = 50;
        Segments(2).isBridgeTap = 0;
        Segments(2).model = 'TNO';

        % 3rd segment (T05b, 30 m)
        Segments(3).id = 7;
        Segments(3).length = 30;
        Segments(3).isBridgeTap = 0;
        Segments(3).model = 'TNO';

        % 4th segment (T05h, 10 m)
        Segments(4).id = 8;
        Segments(4).length = 10;
        Segments(4).isBridgeTap = 0;
        Segments(4).model = 'TNO';

        % Bridge tap (T05h, 5 m)
        Segments(5).id = 8;
        Segments(5).length = 5;
        Segments(5).isBridgeTap = 1;
        Segments(5).model = 'TNO';

        % 5th segment (T05h, 10 m)
        Segments(6).id = 8;
        Segments(6).length = 10;
        Segments(6).isBridgeTap = 0;
        Segments(6).model = 'TNO';

    case 'D6-none'

        nSegments = 3;

        % Preallocate
        Segments(nSegments).id = [];
        Segments(nSegments).length = [];
        Segments(nSegments).isBridgeTap = [];
        Segments(nSegments).model = [];

        % 1st segment (A26j, ANSI AWG 26, 0.6 m)
        Segments(1).id = 9;
        Segments(1).length = 0.6;
        Segments(1).isBridgeTap = 0;
        Segments(1).model = 'BT';

        % 2nd segment (T05u, 50 m)
        Segments(2).id = 6;
        Segments(2).length = 50;
        Segments(2).isBridgeTap = 0;
        Segments(2).model = 'TNO';

        % 3rd segment (T05b, 30 m)
        Segments(3).id = 7;
        Segments(3).length = 30;
        Segments(3).isBridgeTap = 0;
        Segments(3).model = 'TNO';
end



end
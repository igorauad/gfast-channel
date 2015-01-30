function [Segments] = assembleTopology(topology)
%   Assembles the topology segments into a struct
% ----------------------------------------------------------
%   [Segments] = assembleTopology(topology)
%       Struct should contain the segment Id, its length, a flag to
% indicate whether it is a bridge tap or not (ABCD formula changes for a
% bridge tap) and the model to be used for computing the ABCD.
%
% Input: topology choice

%% Main
switch topology

    case 'D2-H2'
        nSegments = 9;
        % Preallocate
        Segments(nSegments).id = [];
        Segments(nSegments).length = [];
        Segments(nSegments).isBridgeTap = [];
        Segments(nSegments).model = [];

        % 1st segment (AWG 26, 0.6 m)
        Segments(1).id = 9;
        Segments(1).length = 0.6;
        Segments(1).isBridgeTap = 0;
        Segments(1).model = 'BT';

        % 2nd segment (AWG 24, 93 m)
        Segments(2).id = 10;
        Segments(2).length = 93;
        Segments(2).isBridgeTap = 0;
        Segments(2).model = 'BT';

        % Bridge taps:

        % 1st - 30 m
        Segments(3).id = 10;
        Segments(3).length = 30;
        Segments(3).isBridgeTap = 1;
        Segments(3).model = 'BT';

        % 2nd - 22.5 m
        Segments(4).id = 10;
        Segments(4).length = 22.5;
        Segments(4).isBridgeTap = 1;
        Segments(4).model = 'BT';

        % 3rd - 15 m
        Segments(5).id = 10;
        Segments(5).length = 15;
        Segments(5).isBridgeTap = 1;
        Segments(5).model = 'BT';

        % 4th - 7.5 m
        Segments(6).id = 10;
        Segments(6).length = 7.5;
        Segments(6).isBridgeTap = 1;
        Segments(6).model = 'BT';

        % 5th - 3.8 m
        Segments(7).id = 10;
        Segments(7).length = 3.8;
        Segments(7).isBridgeTap = 1;
        Segments(7).model = 'BT';

        % 3rd segment (CAT 3, 45m)
        Segments(8).id = 10;
        Segments(8).length = 45;
        Segments(8).isBridgeTap = 0;
        Segments(8).model = 'BT';

        % 4th segment (CAT 5, 1.5m)
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

        % 1st segment (AWG 26, 0.6 m)
        Segments(1).id = 9;
        Segments(1).length = 0.6;
        Segments(1).isBridgeTap = 0;
        Segments(1).model = 'BT';

        % 2nd segment (AWG 24, 93 m)
        Segments(2).id = 10;
        Segments(2).length = 93;
        Segments(2).isBridgeTap = 0;
        Segments(2).model = 'BT';

        % 3rd segment (CAT 5, 1.5m)
        Segments(3).id = 11;
        Segments(3).length = 22.5;
        Segments(3).isBridgeTap = 0;
        Segments(3).model = 'TNO';

    case 'D1-H1'
        nSegments = 4;

        % Preallocate
        Segments(nSegments).id = [];
        Segments(nSegments).length = [];
        Segments(nSegments).isBridgeTap = [];
        Segments(nSegments).model = [];

        % 1st segment (AWG 26, 0.6 m)
        Segments(1).id = 9;
        Segments(1).length = 0.6;
        Segments(1).isBridgeTap = 0;
        Segments(1).model = 'BT';

        % 2nd segment (A26u, 60 m)
        % Temporarily using the same paraters as AWG 26
        Segments(2).id = 9;
        Segments(2).length = 60;
        Segments(2).isBridgeTap = 0;
        Segments(2).model = 'BT';

        % 3rd segment (AWG 24, 93 m)
        Segments(3).id = 10;
        Segments(3).length = 93;
        Segments(3).isBridgeTap = 0;
        Segments(3).model = 'BT';

        % 4th segment (CAT 5, 1.5m)
        Segments(4).id = 11;
        Segments(4).length = 22.5;
        Segments(4).isBridgeTap = 0;
        Segments(4).model = 'TNO';


    case 'D3-H5' % Not entirely equal to the reference presented on draft

        nSegments = 3;

        % Preallocate
        Segments(nSegments).id = [];
        Segments(nSegments).length = [];
        Segments(nSegments).isBridgeTap = [];
        Segments(nSegments).model = [];

        % 1st segment (BT CAD55, 0.6 m)
        Segments(1).id = 12;
        Segments(1).length = 0.6;
        Segments(1).isBridgeTap = 0;
        Segments(1).model = 'BT';

        % 2nd segment (B05a, 35 m)
        Segments(2).id = 5;
        Segments(2).length = 35;
        Segments(2).isBridgeTap = 0;
        Segments(2).model = 'TNO';

        % 3rd segment (assume also B05a, 10 m)
        Segments(3).id = 5;
        Segments(3).length = 10;
        Segments(3).isBridgeTap = 0;
        Segments(3).model = 'TNO';

    case 'D6-H6'

        nSegments = 6;

        % Preallocate
        Segments(nSegments).id = [];
        Segments(nSegments).length = [];
        Segments(nSegments).isBridgeTap = [];
        Segments(nSegments).model = [];

        % 1st segment (ANSI AWG 26, 0.6 m)
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

        % 1st segment (ANSI AWG 26, 0.6 m)
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
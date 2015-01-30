function [ABCD] = topologyABCD(Params, Segments)
% Computes the equivalent ABCD parameters for the given topology
% ---------------------------------------------------------------
%   [ABCD] = topologyABCD(Params, Segments)
%   Given the Segments struct, computes the ABCD parameters of the
%   topology, by multiplication of the individual ABCD parameters of each
%   segment.
%

%% Parameters
shapingFunction = Params.shapingFunction;
Nfft            = Params.Nfft;
bandwidth       = Params.bandwidth;

%% Derived Parameters
nSegments       = length(Segments);
nTones          = Nfft/2 + 1;

%% Preallocations
ABCD = zeros(2, 2, nTones);
ABCDs = cell(nSegments, 1);

%% Main

% Get the ABCD matrices for each segments
for iSegment = 1:nSegments
    % Retrieve segment info
    id = Segments(iSegment).id;
    lineLength = Segments(iSegment).length;
    isBridgeTap = Segments(iSegment).isBridgeTap;
    model = Segments(iSegment).model;

    modelParameters = getModelParameters(id, shapingFunction);

    if (strcmp(model, 'BT'))
        ABCDs{iSegment} = BT_ABCD(bandwidth, Nfft, modelParameters, ...
                            lineLength, isBridgeTap);
    elseif (strcmp(model, 'TNO'))
        ABCDs{iSegment} = TNO_ABCD(bandwidth, Nfft, modelParameters, ...
                            lineLength, isBridgeTap, shapingFunction);
    else
        error('Wrong model');
    end
end

% Compute the equivalent ABCD
for i = 1:nTones,
    operation = sprintf('ABCDs{1}(:, :, i)');

    for iSegment = 2:nSegments
        operation = [operation, ...
            sprintf(' * ABCDs{%d}(:, :, i)', iSegment)];
    end

    ABCD(:,:,i) = eval(operation);
end

end


Channel Modeling
---

Software developed for generating bundles composed by topologies modeled with BT and TNO models.

### About
Currently, the main script for generating channel `.mat` files is `generateBundle.m`. There, the topology desired for each line in the bundle should be defined, accordingly to the available topologies configured in the `assembleTopology.m` file.

The channel response of a given topology is computed by the equivalent ABCD parameters, obtained through multiplication of the individual ABCD parameters of each segment in the topology. These individual ABCD paramaters, in turn, are computed from BT or TNO models, as mandated in `assembleTopology.m`. These models are fitted using the parameters retrieved from `getModelParameters.m`, which lists the parameters for miscellaneous segments, *e.g.* the ones listed on G.fast draft.


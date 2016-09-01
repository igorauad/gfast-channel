Channel Modeling
---

Software developed for generating bundles composed by topologies modeled with BT and TNO models.

### About
There are two main scripts for generating channel `.mat` files, 'generate_all.m' and `generateBundle.m`. The former generates the response of each individual topology as a standalone file. In contrast, the latter generates matrices containing the responses of bundles with arbitrary combination of topologies. In both cases, the available topologies are read from the `assembleTopology.m` file.

The channel response of a given topology is computed by the equivalent ABCD parameters, obtained through multiplication of the individual ABCD parameters of each segment in the topology. These individual ABCD paramaters, in turn, are computed from BT or TNO models, as mandated in `assembleTopology.m`. These models are fitted using the parameters retrieved from `getModelParameters.m`, which lists the parameters for miscellaneous segments, *e.g.* the ones listed on G.fast draft.


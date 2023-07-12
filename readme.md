## Tensor decomposition
Is a mathematical technique used to decompose a higher-order tensor into a combination of lower-rank tensors. It is analogous to matrix decomposition (e.g., singular value decomposition or eigenvalue decomposition) but extended to higher-dimensional data structures.

A tensor is a multi-dimensional array that can represent complex data structures, such as multi-dimensional arrays, images, time series, or networks. Tensor decomposition aims to express a given tensor as a sum of a set of simpler and interpretable tensors, usually with lower ranks.

### The decomposition of a tensor can be useful in several ways:

- Dimensionality Reduction: Tensor decomposition can reduce the dimensionality of the data by representing it in a lower-dimensional space. This reduction can help with computational efficiency, storage, and visualization.

- Data Compression: By approximating a high-dimensional tensor with a combination of lower-rank tensors, tensor decomposition can compress the data while retaining important information.

- Feature Extraction: Tensor decomposition can identify meaningful patterns and extract latent features from high-dimensional data. It can reveal underlying structures and relationships among the data variables.

- Noise Removal: In some cases, tensor decomposition can separate the signal from noise or unwanted variations in the data. By representing the data using a lower-rank approximation, it can remove noisy or irrelevant components.

## Several tensor decomposition methods exist, in this repo I implemented:

- (CP) Decomposition: Also known as tensor rank decomposition or parallel factor analysis, CP decomposition expresses a tensor as a sum of rank-one tensors.

- Tucker Decomposition: Tucker decomposition decomposes a tensor into a core tensor multiplied by factor matrices for each mode. It allows for flexibility in preserving the structure of the original tensor.

I used both types of tensor decompostion to compress a heat sensor readings in a .avi  format on matlab
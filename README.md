# Spatially informed optimal control
This repository includes data and example code for illustrating the incorporation of spatial information into the optimal control framework.

DISCLAIMER: All software is provide <b>as is</b>.

In general, we consider the following linear dynamical system:

$\dot{x} = Ax + Bu$

In this expression, $x$ is a $N_{node} \times 1$ vector that represents the brain "state"; $A$ is a $N_{nodes} \times N_{nodes}$ coupling matrix that specifies the connectivity between pairs of nodes; $u$ is a $N_{\kappa} \times x$ set of input signals injected in to $N_{\kappa}$ input sites (nodes); and $B$ is the $N_{nodes} \times N_{\kappa}$ input matrix that specifies the mapping of input signals to nodes.

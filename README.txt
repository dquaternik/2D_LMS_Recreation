This code is for use in MATLAB 2015a.

'TDALE.m' is a script generates a test image, adds Gaussian noise, then runs the two-dimensional adaptive line enhancer on the noisy image applying the 2D LMS algorithm to update the weights. 
Since most cases do not have an original good quality image to use as desired, the TDALE simply delays the image by one pixel and feeds that as the input to the TDLMS. The desired is the 
original noisy image. The step size of S depends on the image set. 

'TWDLMS.m' has the implemented 1 step of the 2D LMS adaptive algorithm. It takes a the input image, the desired image, and S. 
S is a struct with 3 parameters. Step: the convergence factor of the LMS. filterOrderNo: the square root of the total number of weights. initialCoefs: Initial 2D weight matrix
Returns the enhanced output image matrix, an error image matrix, and a 3D matrix with the weight coefficients at each step of LMS. 
Can be used to implement other applications such as DCT for compression. 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MANUAL CREATIOMN OF ARRAYS
% 1d ARRAYS
Ex_Array_01_a = [3 2 4];
Ex_Array_01_b = [3, 2, 4];
% Creation of numerical arrays in MATLAB is straightforward. 
% Just open a [ followed by the list of numerics seperated 
% by space. The delimiter space can also be replaced by a ',' 
% as demonstrated in example 01_b. Using these delimiters
% creates a matrix of numbers with a single row. MATLAB calls 
% such a matrix a row matrix. 
Ex_Array_02_a = [3; 2; 4];
Ex_Array_02_b = [3;
                 2;
                 4];
% Use the ';' delimiter instead to create a column matrix 
% having a single column and multiple rows.
% Such 1-D matrices are also comminlyt referred to as vectors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MANUAL CREATIOMN OF ARRAYS
% 2D ARRAYS
Ex_Array_03_a1 = [1 2 3; 3 4 5; 5 6 7; 2 3 4];
Ex_Array_03_a2 = [1,2,3; 3,4,5; 5,6,7; 2,3,4];
Ex_Array_03_b  = [1 2 3;
                  3 4 5;
                  5 6 7;
                  2 3 4];
Ex_Array_03_c  = [1 2 3
                  3 4 5
                  5 6 7
                  2 3 4]; % this is what it means in short
% A combination of delimiters {space or ,} and {next line or ;}
% should be used to create 2D matrices, that is matrices with 
% number of rows and columns greater than 1. In example 03_a, 
% delimiter ; is used to progress to next row. This example 
% shows the manual creation of a 4x3 matrix. In MATLAB, matrix
% order is represented as r x c, that is by number of rows and 
% number of columns.
% You might have recognized that the above examples are not 
% written here as below:
Ex_Array_03_a1=[1 2 3;3 4 5;5 6 7;2 3 4];
Ex_Array_03_a2=[1,2,3;3,4,5;5,6,7;2,3,4];
Ex_Array_03_b=[1 2 3;
    3 4 5;5 6 7; 
2 3 4];
Ex_Array_03_c  = [1 2 3
3 4 5
5 6 7
2 3 4];
% It is not difficult to see that the earlier way of writing 
% makes it more readable. It is crucial for a developer to 
% make the code as readable as possible because it would enable
% collabvoration easy and also the developer themselves will
% find it easy to work on the code and maintain the code.
% The last line in the example 03_c shows some text followed by a %
% These are comments which are not evaulated by MATLAB. They are by 
% a human for a human so that humans can trace and read the varibale 
% names, their importance, their use and further more. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
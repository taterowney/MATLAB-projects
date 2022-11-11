%evaluating transforms on a vector via SVD

%clean the workspace
clear;

%our transform (must be square!!)
a = [1 0 0; 0 1 0; 0 0 1];

%our vector to apply (must be compatable with matrix)
vector = [3 7 5];

%find the eigenvector
[V, D] = eig(a);
V_inv = inv(V);

%matrix_apply(a, vector)
matrix_apply(V, matrix_apply(D, matrix_apply(V_inv, vector)))


function ret = matrix_apply(matrix, row_vector)
    total = [];
    for i = 1:length(row_vector)
        subtotal = 0;
        for j = 1:length(row_vector)
            subtotal = subtotal + (row_vector(j)*matrix(i, j));
        end
        total(i) = subtotal;
    end
    ret = total;
end
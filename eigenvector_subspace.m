%the space defined by the eigenvectors of a matrix

clear

%the matrix we want to calculate
matrix = [1 2; 2 4];

[V, D] = eig(matrix);

disp(" ")
disp("rank of matrix: " + rank(matrix))
disp(" ")
disp("rank of eigenvectors: "+ rank(V))
disp(" ")

matrix_apply(matrix, [-0.8944, 0.4472])

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
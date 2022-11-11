%matlab matrix operations






classdef matrix
properties
    matrix_array = [1 2; 3 4]
end
methods
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
end
end


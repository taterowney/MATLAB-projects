

m = matrix;
matrix_multiply(m, m)
dot_product([1 2], [1 3]);


function ret = dot_product(v1, v2)
    total = 0;
    for i = 1:length(v2)
        total = total + (v1(i) * v2(i));
    end
    ret = total;
end

function ret = matrix_multiply(matrix1, matrix2)
        m1 = matrix1.matrix_array;
        m2 = matrix2.matrix_array;
        m1(1, :)
        for i = 1:height(m1)
            for j = 1:width(m1)
                m1_vectors(i, j) = m1(i, j);
                m2_vectors(i, j) = m2(j, i);
            end
        end
        for i = 1:height(m1)
            for j = 1:width(m1)
                m1_vectors(i)
                m2_vectors(j)
                m_out(i, j) = dot_product(m1_vectors(i), m2_vectors(j));
            end
        end
        ret = m_out;
end

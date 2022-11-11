clear;
m = [2 0 0 4; 1 3 0 2; 1 0 4 2; 1 0 0 2];

x = [2; 3; 5; 7;];

% x1 = find_dot_vector(x, rowspace(m));
% a = rowspace(m);
% x2 = find_dot_vector(x, nullspace(m));
% b = nullspace(m);
% round(a*transpose(x1) + b*transpose(x2))


m_inv = projection_matrix(sym(rowspace(m)))* transpose(m) * projection_matrix(sym(columnspace(m)));

%projection_matrix(sym(rowspace(m)))

%m_inv([1; 2; 3; 4;])

% function ret = m_inv(val)
%     global m;
%     ret = (projection_matrix(sym(rowspace(m)))* transpose(m) * projection_matrix(sym(columnspace(m))))*(val);
% end

function ret = pseudo_inverse(m)
    ret = projection_matrix(sym(rowspace(m)))* transpose(m) * projection_matrix(sym(columnspace(m)));
end


function ret = projection_matrix(c)
    val = zeros(size(c(:, 1)*transpose(c(:, 1))));
    for i=1:width(c)
        val = val + c(:, i)*transpose(c(:, i));
%        c(:, i)*transpose(c(:, i))
    end
    ret = val;
end


function ret = singular(val)
    if det(sym(val)) ~=0
        ret = false;
    else
        ret = true;
    end
end


function ret = find_dot_vector(x, basis)
    val = [];
    for i = 1:width(basis)
        val(i) = transpose(x)*basis(:, i); %#ok<AGROW> 
    end
    ret = val;
end


function csp = columnspace(m) %#ok<*DEFNU> 
    val = colspace(sym(m));
    for i = 1:width(val)
        val(:, i) = normalize(val(:, i));
    end
    csp = val;
end


function rsp = rowspace(m)
    val = colspace(sym(transpose(m)));
    for i = 1:width(val)
        val(:, i) = normalize(val(:, i));
    end
    rsp = val;
end


function nsp = nullspace(m)
    val = null(m);
    for i = 1:width(val)
        val(:, i) = normalize(val(:, i));
    end
    nsp = val;
end


function ntsp = nullspace_transpose(m)
    val = null(sym(transpose(m)));
    for i = 1:width(val)
        val(:, i) = normalize(val(:, i));
    end
    ntsp = val;
end


function ret = normalize(v)
    ret = transpose(v)/norm(v);
end


function ret = outer_product(v, u)
    ret = v * transpose(u);
end


function ret = ortho_complement(A, B)
   ortho = true;
   for i=1:length(A)
       for j=1:length(B)
           if transpose(A)*B ~= 0
               ortho = false;
               break
           end
       end
   end
   ret = ortho;
end
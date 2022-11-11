

find_roots_of_unity(8)


function ret = find_roots_of_unity(n)
    for j=0:(n-1)
        theta = j*((2*pi)/(n));
        roots(j+1) = cos(theta)+(1i+0)*sin(theta);
    end
    ret = roots;
end

function ret = create_discrete_fourier(m, n)
    
end
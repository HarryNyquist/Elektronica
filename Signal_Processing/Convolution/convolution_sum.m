    function [y] = convolution_sum(x,h)
    x_l= length(x);
    y_l = length(h);
    y = zeros(x_l + y_l-1, 1);
    %we are essentially just doing normal convolution procedure 
    %with 0-indexed arrays, and incremeenting index by 1 to
    %conform to the MATLAB standard
    for n = 0 : x_l + y_l - 2
        for k = 0:x_l - 1 
            if (n - k >= 0) && (n - k < y_l)
                y(n+1) = y(n+1) + x(k+1)*h(n-k+1);
            end
        end
    end
end


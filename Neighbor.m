function [Neighbors]  = Neighbor(x,y, data)
    % Gets the 4 nearest neighbors of a spin.

    m = data{1};
    n = data{2};
    spin = data{3};
    up = spin(mod(x-2,m)+1,y);
    down = spin(mod(x,m)+1,y);
    left  = spin(x,mod(y-2,n)+1);
    right = spin(x,mod(y,n)+1);
    Neighbors = [up ,down, left, right];
end 
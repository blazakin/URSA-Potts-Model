function [spin, spin_info] = InitSpin(m, n, seed)
    rng(seed,"twister")
    % Initialises a simple pore model

    
    rand_array = randperm(m*n);

    radius = floor((m-1)/3);
    
    ct_rm = 0;
    index=1;
    while(index <= size(rand_array, 2))
        [trow, tcol] = ind2sub([m,n], rand_array(index));
        if ((trow - 1)^2 + (tcol - 1)^2 <= radius^2 || ...
            (trow - m)^2 + (tcol - 1)^2 <= radius^2 || ...
            (trow - m)^2 + (tcol - n)^2 <= radius^2 || ...
            (trow - 1)^2 + (tcol - n)^2 <= radius^2)
            rand_array(index) = [];
            index = index-1;
            ct_rm = ct_rm + 1;
        end
        index = index+1;
    end
    
    total_spins = m*n - ct_rm;
    % cut1 = randi([3, total_spins]);
    % cut2 = randi([3, total_spins]);
    % cuts = sort([cut1, cut2]);
    % Can also set the values directly (must total to m*n)
    num_air = floor(total_spins*.05);
    num_ice = floor((total_spins-num_air)/2);
    num_water = total_spins - num_air - num_ice;
    cut1 = num_air;
    cut2 = num_air + num_ice;
    cuts = [cut1, cut2];
    
    [arow, acol] = ind2sub([m, n], rand_array(1:cuts(1)));
    [irow, icol] = ind2sub([m, n], rand_array(cuts(1)+1:cuts(2)));
    [wrow, wcol] = ind2sub([m, n], rand_array(cuts(2)+1:total_spins));
    
    spin = ones(m, n, "int8");

    for index=1:size(wrow, 2)
        spin(wrow(index), wcol(index)) = 2;
    end
    for index=1:size(irow, 2)
        spin(irow(index), icol(index)) = 3;
    end
    for index=1:size(arow, 2)
        spin(arow(index), acol(index)) = 4;
    end

    spin_info = {irow, icol, wrow, wcol, arow, acol};

end
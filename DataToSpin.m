function [spin, spin_info] = DataToSpin(m, n, file, seed)
    rng(seed,"twister")
    % Initializes a model from a data image. White in data represents rock.
 
    image = imread(file);
    image = imresize(image, [m, n], "nearest");
    image = (image == 255);
    % Switch comment on "image = int8(image);" to image = int8(~image);
    % in order to let black represent rock in the data
    % image = int8(image);
    image = int8(~image);
    array = find(image == 1);
    rand_array = array(randperm(size(array, 1)),:);
    

    total_spins = size(rand_array, 1);
    num_air = floor(total_spins*.05);
    num_ice = floor((total_spins-num_air)/2);
    num_water = total_spins - num_air - num_ice;
    cut1 = num_air;
    cut2 = num_air + num_ice;
    cuts = [cut1, cut2];
    
    [arow, acol] = ind2sub([m, n], rand_array(1:cuts(1)));
    [irow, icol] = ind2sub([m, n], rand_array(cuts(1)+1:cuts(2)));
    [wrow, wcol] = ind2sub([m, n], rand_array(cuts(2)+1:total_spins));
    irow = transpose(irow);
    icol = transpose(icol);
    wrow = transpose(wrow);
    wcol = transpose(wcol);
    arow = transpose(arow);
    acol = transpose(acol);

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
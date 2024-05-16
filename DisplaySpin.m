function [] = DisplaySpin(spin)
    % Displays the model lattice as an image

    cmap = [0, 0, 0; ... % Default to black
        0, 0, 0; ... % Black for rock
        .5, .5, .5; ... % Gray for water
        1, 1, 1; ... % White for ice
        0, 1, 0;]; % Green for air
    imshow(spin, cmap, 'InitialMagnification', 800)
    if size(spin,1) == size(spin, 2)
        axis square
    end
end
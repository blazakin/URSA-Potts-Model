function [e] = energy(row, col, spin, data)
    % Gets the local energy of a single spin from its interactions with its
    % neighbors

    hood = Neighbor(row, col, data);
    sum = 0;
    for i = 1:4
        sum = sum + w(spin, hood(i), data);
    end

    e = sum;
end
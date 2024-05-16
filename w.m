function [J] = w(spin, neighbor, data)
    % Gets interaction weight between 2 states in the model
    
    debase = sort([spin,neighbor]);
    ww = data{5}(1);
    ii = data{5}(2);
    rr = data{5}(3);
    aa = data{5}(4);

    wi = data{5}(5);
    ri = data{5}(6);
    rw = data{5}(7);
    ra = data{5}(8);
    wa = data{5}(9);
    ia = data{5}(10);

    if (debase(1) == debase(2))
        if debase(1) == 1
            J = ww;
        elseif (debase(1) == 2)
            J = ii;
        elseif (debase(1) == 3)
            J = rr;
        elseif (debase(1) == 4)
            J = aa;
        end
    elseif (debase(1) == 1 &&  debase(2) == 2)
        J = rw;
    elseif (debase(1) == 1 &&  debase(2) == 3)
        J = ri;
    elseif (debase(1) == 2 &&  debase(2) == 3)
        J = wi;
    elseif (debase(1) == 1 &&  debase(2) == 4)
        J = ra;
    elseif (debase(1) == 2 &&  debase(2) == 4)
        J = wa;
    elseif (debase(1) == 3 &&  debase(2) == 4)
        J = ia;
    end

end
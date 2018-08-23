function [ fd ] = c2d_euler( fc, h )
    function x_new = fproto( t, x )
        x_new = x + h*fc( t, x );
    end
    fd = @fproto;
end
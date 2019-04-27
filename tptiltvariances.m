function [tiltx, tilty]=tptiltvariances(N,H, q, fn, kmpup, kmdot)

    fone = @(x)((1-x).^2.*integralone(N,H, q, fn, kmpup, kmdot,x));
    ft =    @(x)((1-x).^2.*integralt(N,H, q, fn, kmpup, kmdot,x));
    [tiltx,~]= quadgk(fone,0,1,'RelTol',0,'AbsTol',1e-10);
    [tilty,~]= quadgk(ft,0,1,'RelTol',0,'AbsTol',1e-10);
    tiltx = tiltx-tilty;
    
    function I = integralone(N,H, q, fn, kmpup, kmdot,x)
        
        [I,~]=integral_one(N,H, q, fn, kmpup, kmdot,x);
        I=I';
        
    end

function I = integralt(N,H, q, fn, kmpup, kmdot,x)
        
        [I,~]=integral_t(N,H, q, fn, kmpup, kmdot,x);
        I=I';
        
end

end
    
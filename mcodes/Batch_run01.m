close;
CTF         = 0.55;
xsgsoffset  = 0;
ysgsoffset  = 0;
Npcrack     = 1000;


layers = [40 0 12 0];
CLF = [0.2 0.3 0.4 0.5 ];
theta = [0 20 40 60 80 100 120 140 160 180];

for l1 = 1:size(layers,1)
    for c1 = 1:numel(CLF)
        for t1 = 1:numel(theta)
            layerinfo = layers(l1,:)
            cdef = [theta(t1) CLF(c1) CTF xsgsoffset ysgsoffset Npcrack]
            sfeam('ag','de','2d',{'g1','nd.and.nf'},layerinfo,'',2,-1,cdef);
            close
 
        end
    end
end
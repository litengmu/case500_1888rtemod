function mpc = case1888rte_mod()
%
%
%
%
load('case1888rte_mlsols.mat')
gencost_poly = mpc.gencost;
gencost_qrad = gencost_poly(:,1:7);
gencost_qrad(:,1) = 2;
gencost_qrad(:,4) = 3;
for ig = 1:size(gencost_poly,1)
    npnts = gencost_poly(ig,4)-1;
    if npnts>=3
        x = gencost_poly(ig,5:2:(5+2*npnts));
        y = gencost_poly(ig,6:2:(6+2*npnts));
        p = polyfit(x,y,2);
        gencost_qrad(ig,5:7) = p;
    else
        x = gencost_poly(ig,5:2:(5+2*npnts));
        y = gencost_poly(ig,6:2:(6+2*npnts));
        p = polyfit(x,y,1);
        gencost_qrad(ig,5:7) =[0  p];
    end
end
gencost_qrad(gencost_qrad(:,6)<0.001,6) = 0.001;


mpc.gencost = gencost_qrad;


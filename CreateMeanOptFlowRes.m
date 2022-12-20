function [Results]=CreateMeanOptFlowRes(RFN)

%function to create a Results structure from Optical Flow Results 

    load(RFN)
    
    S=size(opflow3.Magnitude);
    SX=max(S);
    SY=min(S);
    X1=0.5*GSD:GSD:(SX - 0.5)*GSD;
    Y1=0.5*GSD:GSD:(SY - 0.5) *GSD;
    [X1,Y1]=meshgrid(X1,Y1);
   Results.Um = opflow3.Vx; %mean of U velocities
   Results.Vm = opflow3.Vy; %mean of V velocities
   Results.Velmag=opflow3.Magnitude;
   Results.X=X1;
   Results.Y=Y1;
   %Results.fps=fps
   Results.GSD =GSD;
end
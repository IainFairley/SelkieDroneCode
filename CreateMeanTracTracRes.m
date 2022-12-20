

function [Results]=CreateMeanTracTracRes(RFN)
%script to extract TracTrac results to mean vels, assuming all in
%subfolders
%RFN is the filename of the postprocessed data - by default this is 'jpgseq_PostProc.mat'

    load(RFN)
    
   Results.Um = cellfun(@mean,U); %mean of U velocities
   Results.Vm = cellfun(@mean,V); %mean of V velocities
   Results.Velmag=(Results.Um.^2 +Results.Vm.^2).^(1/2);
   Results.X=X;
   Results.Y=Y;
   Results.fps=fps
   Results.GSD =res
    clear dx dy E fps Frames res X Y U V
   
end
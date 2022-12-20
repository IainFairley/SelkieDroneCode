function [Results]=CreateMeanPIVLabRes(RFN)
%Function to create structure of mean PIVlab resutls from results exported
%from PIVlab
%input - RFN is the .mat file name of the extracted resutls
%output - Results is a matlab structure with results in, as specified below

load(RFN);

for ii=1:max(size(u_original));
    u_filt(:,:,ii)=u_filtered{ii,1};
    v_filt(:,:,ii)=v_filtered{ii,1};
end

Mag_filt=sqrt(u_filt.^2 + v_filt.^2);

Results.X=x{1,1}; %grid of points on ground
Results.Y=y{1,1};%grid of points on ground 
Results.Um=nanmean(u_filt,3); %gridded mean U velocities
Results.Vm=nanmean(v_filt,3); %gridded mean V velocities
Results.Velmag=nanmean(Mag_filt,3); %gridded mean velocity magnitude
end



function [ResGeo]=AddRealWorldCoords(Results,Yaw,XY)

%function to add realworldcoords to resutls structure based on yaw and xand
%y position
%input:
%Results structure - expected in MATLAB workspace already
%Yaw - yaw angle of gimbal in degrees
%XY x and y position in UTM coordinates (m)
%
%output: ResGeo - results structure with georeferenced co-ordinate grid
%(Xgeoref,Ygeoref) and rotated current vectors (Urot and Vrot) added

Yaw2=ones(size(Yaw)).*360 - Yaw;



R=[cosd(Yaw2) -sind(Yaw2); sind(Yaw2) cosd(Yaw2)]; %set up rotation matrix

%demean so origin is in middle for rotation
Results.Y= ones(size(Results.Y)).*max(Results.Y(:))-Results.Y;
Xm=Results.X-mean(Results.X(:));
Ym=(Results.Y-mean(Results.Y(:)));

XmR=Xm;
YmR=Ym;

%rotate
for ii=1:numel(Ym);
    
  C1=R*[Xm(ii);Ym(ii)];
  
  XmR(ii)=C1(1);
  YmR(ii)=C1(2);
end

%add real world coords of centre of image
XmRC=XmR+XY(1);
YmRC=YmR+XY(2);

%rotate current vecotrs
Urot=Results.Um;
Vrot=Results.Vm;
for ii=1:numel(Urot); 
    rot1=[Urot(ii) Vrot(ii)]*R; 
    Urot(ii)=rot1(1); 
    Vrot(ii)=rot1(2); 
end

Vrot=Vrot.*-1;  %because Y axis reverse when in image coords

%put into structure
Results.Ygeoref=YmRC; %georeferecend x grid
Results.Xgeoref=XmRC; %georeferenced y grid
Results.MXMY=XY; %real world image centre coords
Results.Yaw=Yaw; %image yaw
Results.Urot=Urot; %rotated current U vector for use with georeferenced coords
Results.Vrot=Vrot; %rotated current V vector for use with georeferenced coords

ResGeo=Results;
end



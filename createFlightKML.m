%script to set up a waypoint KML; assuming long axis perp to flow/stream
%centre. Edit parameters in first section


%% Edit the settings in this section

%image properties 
OverL = 0.5; %Overlap of imagery between 0 and 1
ImHG= 98; %image height length on ground (get from GetGSD)
ImLG = 55; %image width on ground

%grid size 
StreamN = 3; %number of grids in streamwise direction
CrossN = 3; %number of grids in cross flow direction

%Location parameters
LatC=     51.616931 ; %lat of center of flight area  54.381000
LonC=     -3.875688 ;% lon of cntre of flgiht area
StreamDir = 0 ; %direction of flow 
LatTO= 54.381911 ; %lat of Take off
LonTO=  -5.552320 ; %lon of Take off

%Output File
OutFile= 'CreateFlightOutput.kml'; %output file name, edit name prior to .kml


%% work out positions etc

%calc drone hover spacings to get overlap
DSX= ImHG.*(1-OverL); %X or cross flow spacing
DSY=ImLG.*(1-OverL); %Y or streamwise spacing

%convert centre points to utm so we can work in metres
[x,y,utm]=deg2utm(LatC,LonC);

%set up a grid of drone positions
DLXv=0:DSX:(CrossN-1).*DSX;
DLYv=0:DSY:(StreamN-1).*DSY;
[DLXg,DLYg]=meshgrid(DLXv,DLYv);

%flip the even x rows so we have a snake flight path not a zig-zag
for ii=2:2:length(DLXg); 
    DLXg(ii,:)=fliplr(DLXg(ii,:));
end

%put them into two vectors of x and y
DLXg=DLXg'; DLYg=DLYg';
DLX=DLXg(:);DLY=DLYg(:);

%demean both vectors ready to rotate so angled with flow direction
Xm=mean(DLX); Ym=mean(DLY);
DLX=DLX-Xm; DLY=DLY-Ym;

%set up rotation matrix and then rotate co-ords
Rt=[cosd(StreamDir+90) -sind(StreamDir+90); sind(StreamDir+90) cosd(StreamDir+90)];

DLXr=nan(size(DLX));
DLYr=nan(size(DLY));

    for kk=1:numel(DLX);
        C1=Rt*[DLX(kk);DLY(kk)];
        DLXr(kk)=C1(1);
        DLYr(kk)=C1(2);
    end;

    %add the actul centre co-ords in utm;
    DLXutm=DLXr+x;
    DLYutm=DLYr+y;
    
    %covert to lat and lon;
    
    for ii=1:length(DLXutm); utmV(ii,:)=utm; end
    
    [DL_lat,DL_lon]=utm2deg(DLXutm,DLYutm,utmV);
    
    %include take off location
    LatWP=[DL_lat];
    LonWP=[DL_lon];
    
    %write to kmlfile
    kmlwriteline(OutFile,LatWP,LonWP); 
    
    %clear variables used
    clear C1 CrossN DL_lat DL_lon DLX DLXg DLXr DLXv DLXutm DLY DLYg DLYr DLYutm DLYv DSX DSY ii ImHG ImLG kk
    clear LatC LatTO LatWP LonC LonTO LonWP OutFile OverL Rt StreamDir StreamN utm utmV x Xm y Ym
    
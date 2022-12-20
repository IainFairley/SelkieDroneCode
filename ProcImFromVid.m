function ProcImFromVid(VidFilename,FolderPath);
%function to take a video and extract frames at 15fps for 1 minute
%then save adjusted images. 
%VidFilename is the name of the video (assumed in matlab path), 
% FolderPath the folder to save images in

%set up videoreader object
V=VideoReader(VidFilename);

%create folder for images
    if not(isfolder(FolderPath))
     mkdir(FolderPath)
    end
    
    %sort out number of frames for 1 minute and interval
    Vinterval=round(V.FrameRate/15);
    Fr1min=ceil(V.FrameRate.*60);
    VFNum=min([V.NumFrames Fr1min]);
for ii=1:Vinterval:VFNum; %every other frame so 15fps for 60s

    
    f1=read(V,ii); %read one frame
    f1=rgb2gray(f1); %transform to greyscale
        f1=imadjust(f1,[0.015 0.985]); %contrast stretch
        
        %CLAHE with 40 by 40 pixiel window
         S=size(f1);
         f1=adapthisteq(f1,'NumTiles',[round(S(1)/40) round((S(2)/40))]); 

         %set up image file names
 if ii<10
        Ifn=['Im_000' num2str(ii) '.jpg'];
    elseif ii<100
        Ifn=['Im_00' num2str(ii) '.jpg'];
    elseif ii<1000
        Ifn=['Im_0' num2str(ii) '.jpg'];
    else
        Ifn=['Im_' num2str(ii) '.jpg'];
 end
    
    %write adjusted frame to image
    imwrite(f1,[FolderPath '\' Ifn]);
end
    close V
end

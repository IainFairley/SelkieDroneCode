
function writeImages2Vid15fps(VFN);
%function to write images from a directory to a video:
%VFN - VFN of the video, include .avi

%Get a set of images - assume function being run in directory with images
%in and that only one set of images in directory.

Files=dir;
n=1; 
for ii=1:length(Files); 
    if Files(ii).isdir==0;
    if strcmp('jpg',Files(ii).name(end-2:end));
        ImInd(n)=ii; 
        n=n+1; 
    end; 
    end
end

Files=Files(ImInd);

%set up videowriterObejct and specify 15fps
vs=VideoWriter(VFN); 
vs.FrameRate=15;
open(vs);


for ii=1:length(Files);
   
    I=imread(Files(ii).name);
   writeVideo(vs,I);
   
   end

close(vs);
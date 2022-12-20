%function to get Ground Pixel distance;
%equation taken from PIX4D online help, tested based on measuring know distances in
%images and it works.

%inputs:
%Elv - elevation above a datum
%Tide - tide level above same datum (if no tide data set to 0)
%SW - sensor width in mm
%Fr - Focal length in mm, real focal length not 35mm equiv.
%ImW - image width in pixels
%ImH - image height in pixesl

%outputs:
%GSD - ground sampling distance in m
%ImFootprint - image coverage on ground: width and height


%
function [GSD, ImFootprint]=GetGSD(Elv, Tide, SW, Fr, ImW, ImH);

H=Elv-tide;

GSD=((SW*H*100)./(Fr*ImW))./100;
ImFootprint=[(GSD*ImW) (GSD*ImH)];

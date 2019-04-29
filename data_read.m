function [x,y,z,ix,iy] = data_read(filename)
%Calibration Marks File Read


x=[];
y=[];
z=[];
ix=[];
iy=[];

fileID = fopen(filename,'r');
while ~feof(fileID)
    A = fgetl(fileID);
    if strcmp(A,'')
        continue
    end
    
    sp=strsplit(A,',');
    x=[x;str2double(sp(1))];
    y=[y;str2double(sp(2))];
    z=[z;str2double(sp(3))];
    ix=[ix;str2double(sp(4))];
    iy=[iy;str2double(sp(5))];
end

fclose(fileID);



end


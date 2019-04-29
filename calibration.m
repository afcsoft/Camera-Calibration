%Camera Calibration
%Abdülkadir ÇAKIR


%Load Camera Mark Points

%19_06_54.txt : 640x480 image mark file

[wx,wy,wz,ix,iy]=data_read('19_06_54.txt');
temp=wx;
wx=wy;
wy=temp;

%Create M Matrix

    M=[];
    
    for i=1:length(wx)
        axi=[-wx(i),-wy(i),-wz(i),-1,0,0,0,0,ix(i)*wx(i),ix(i)*wy(i),ix(i)*wz(i),ix(i)];
        ayi=[0,0,0,0,-wx(i),-wy(i),-wz(i),-1,iy(i)*wx(i),iy(i)*wy(i),iy(i)*wz(i),iy(i)];
        M=[M;axi;ayi;];
    end
    M=M*-1;
    
    % SVD
    
    [U, S, V]=svd(M);
    
    %diagonal 12x12 of S
    
    diag_s=diag(S(1:12,1:12));
    
    %Minimum Singular Value
    [s_value,s_index]=min(diag_s);
    
    %Singular Vector
    
    sing_vec=V(1:end,s_index);
    
    %Projection Matrix
    
    P=vec2mat(sing_vec,4);
    
    %Decomposition of P
    
    Hinf=P(1:3,1:3);
    
    h=P(1:3,4);
    
    %Translation Vector X0
    
    X0=-inv(Hinf)*h;
    
    %QR Decomposition of "Hinf"
    % K:Camera Constants R:Rotation Matrix
    
    [R,K]=qr(inv(Hinf));
    
    K=inv(K);
    
    %Non Homogenious
    
    K=K/K(3,3);
    
    disp('Rotation Matrix:');
    disp(R)
    
    disp('Calibration Matrix:');
    disp(K);
    
    
    
    
    
    
    
    
    
    
    
    



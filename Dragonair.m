clear
clc 
close all

t = 0;
while true
    %Body and tail
    [x, y, z] = ellipsoid(0,0,0,15,5,5,100);
    surf(x, y, z);
    colormap copper;
    hold on
    [x1,y1,z1] = ellipsoid(5,-1,0,15,5,5,100);
    surf(x1,y1,z1);
    hold on
    [x2,y2,z2] = ellipsoid(6,15,0,4,18,4,100);
    [x3,y3] = rotate(x2,y2,-pi/3);
    x3(x3 > 31) = NaN;
    y3(y3 < -5) = NaN;
    surf(x3,y3,z2);
    [x4,y4,z4] = ellipsoid(28,8,0,3,25,3,100);
    y4(y4 < 7) = NaN;
    %Tail flick
    x4(x4 > -100) = x4(x4 > -100) - 28;
    y4(y4 > -100) = y4(y4 > -100) - 8;
    th = sind(t) ./ 2;
    [x5,y5] = rotateFixed(x4,y4,th);
    x5(x5 > -100) = x5(x5 > -100) + 28;
    y5(y5 > -100) = y5(y5 > -100) + 8;
    surf(x5,y5,z4);

    %Upper Body
    %[x, y, z] = ellipsoid(0,0,0,15,5,5,30);
    [x30,y30,z30] = ellipsoid(-7,0,1,8,5,5,50);
    surf(x30,y30,z30)
    [x31,y31,z31] = ellipsoid(-7,0,2,7,5,5,50);
    surf(x31,y31,z31)
    [x32,y32,z32] = ellipsoid(-7,0,3,6,5,5,50);
    surf(x32,y32,z32)
    [x33,y33,z33] = ellipsoid(-7,0,4,5,5,5,50);
    surf(x33,y33,z33)
    [x34,y34,z34] = ellipsoid(-7,0,5,4,5,5,50);
    surf(x34,y34,z34)

    %Upper upper body
    [x35,y35,z35] = ellipsoid(-6.5,0,2,3.5,4.5,20,50);
    [x36,z36] = rotate(x35,z35,-pi/7);
    z36(z36 < 2.5) = NaN;
    surf(x36,y35,z36)
     %decor
    [x37,y37,z37] = ellipsoid(-4.75,0,19,1.5,1.5,1.5,50);
    surf(x37,y37,z37)

    %Head
    headRadius = 5;
    [x40,y40,z40] = ellipsoid(.5,0,27,headRadius,headRadius,headRadius+1,50);
    surf(x40,y40,z40)
    [x41,y41,z41] = ellipsoid(0,0,25,headRadius+2,headRadius-1,headRadius-1,50);
    x41(x41 > 0) = NaN;
    surf(x41,y41,z41)
    %Eyes
    [x42,y42,z42] = ellipsoid(-13,1.75,18,.5,1.25,1.75,50);
    [x43,z43] = rotate(x42,z42,-pi/7);
    surf(x43,y42,z43)
    [x44,y44,z44] = ellipsoid(-13,-1.75,18,.5,1.25,1.75,50);
    [x45,z45] = rotate(x44,z44,-pi/7);
    surf(x45,y44,z45)
    %Horn
    r = -linspace(0,2*pi);
    th = linspace(0,2*pi);
    [R,T] = meshgrid(r,th);
    x46 = R.*cos(T);
    y46 = R.*sin(T);
    z46 = R;
    x46(x46 > -100) = x46 - 10;
    x46(x46 > -100) = x46 / 3;
    y46(y46 > -100) = y46 / 3;
    z46(z46 > -100) = z46 + 30;
    z46(z46 > -100) = z46 / 1;
    [x47,z47] = rotate(x46,z46,pi/7);
    x47(x47 > -100) = x47 + 10;
    z47(z47 > -100) = z47 + 6;
    surf(x47,y46,z47)

    %Right Ears
    [x50,y50,z50] = ellipsoid(-.5,-4,32,2,.5,8,50);
    z50(z50 < 28) = NaN;
    surf(x50,y50,z50)
    [x51,y51,z51] = ellipsoid(1,-4,32,2,.5,6,50);
    z51(z51 < 29) = NaN;
    surf(x51,y51,z51)
    [x52,y52,z52] = ellipsoid(2.5,-3.5,32,2,.5,4,50);
    z52(z52 < 29) = NaN;
    surf(x52,y52,z52)
    %Left Ears
    [x53,y53,z53] = ellipsoid(-.5,4,32,2,.5,8,50);
    z53(z53 < 28) = NaN;
    surf(x53,y53,z53)
    [x54,y54,z54] = ellipsoid(1,4,32,2,.5,6,50);
    z54(z54 < 29) = NaN;
    surf(x54,y54,z54)
    [x55,y55,z55] = ellipsoid(2.5,3.5,32,2,.5,4,50);
    z55(z55 < 29) = NaN;
    surf(x55,y55,z55)
    
    axis equal
    shading interp;
    colormap winter;
    lightangle(0,0);
    xlabel('x')
    ylabel('y')
    zlabel('z')
    view(t ./ 5,abs(sind(t / 5) .* 20));
    pause(.03);
    t = t + 10;
    hold off
end

function [xx yy] = rotate(xx,yy,th)
    [rows cols] = size(xx);  
    n = rows .* cols;
    p1(1,:) = reshape(xx,1,n);
    p1(2,:) = reshape(yy,1,n);
    A = [cos(th) -sin(th)
        sign(th) cos(th)];
    p2 = A * p1;
    xx = reshape(p2(1,:),rows,cols);
    yy = reshape(p2(2,:),rows,cols);
end      

%fixes the sign(th) problem I coded in the original
%Rotates around the origin
function [xx yy] = rotateFixed(xx,yy,th)
    [rows cols] = size(xx);  
    n = rows .* cols;
    p1(1,:) = reshape(xx,1,n);
    p1(2,:) = reshape(yy,1,n);
    A = [cos(th) -sin(th)
        sin(th) cos(th)];
    p2 = A * p1;
    xx = reshape(p2(1,:),rows,cols);
    yy = reshape(p2(2,:),rows,cols);
end
    

clc;
clear all;
close all;
I=imread('man.tiff');
I=imresize(I,[512,512]);
[R,C,Z]=size(I);
if(size(I,3)~=1)
    I=rgb2gray(I);
end
H=imhist(I);
[Height, Peak]=max(H);
PixPeak=Peak-1;
I1=I;
for x=1:R
    for y=1:C
        if I(x,y)>PixPeak && I(x,y)<255
            I1(x,y)=I1(x,y)+1;
        end
    end
end
subplot(2,2,1); image(I);title('Original Image');
subplot(2,2,2); image(I1);title('Stego Image');

D=randi([0,1],1,Height);
K=1;
IS=I1;
for x=1:R
    for y=1:C
        if I1(x,y)==PixPeak
            DB=D(1,K);
            if DB==1
                IS(x,y)=IS(x,y)+1;
            end
        K=K+1;
        end
    end
end

subplot(2,2,3); image(IS);title('Stego Data Image');
E=IS;
IR=uint8(zeros(R,C));
ED=zeros(1,Height);%extracted data
k=1;
for x=1:R
    for y=1:C
        if E(x,y)==PixPeak
            ED(1,k)=0;
            k=k+1;
        elseif E(x,y)==(PixPeak+1)
            ED(1,k)=1;
            k=k+1;
        end
        if E(x,y)<=PixPeak
            IR(x,y)=E(x,y);
        elseif E(x,y) > PixPeak
            IR(x,y)=E(x,y);
        end
    end
end
imshow(IR);title('recovered image');

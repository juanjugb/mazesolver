function []=mazei(img_source)
i=imread(img_source);
%i=imresize(i,[51 51]);
[rows cols noofbands]=size(i);
rp=i(:,:,1);
bp=i(:,:,2);
gp=i(:,:,3);
plane=[rp bp gp];
con=max(plane);
rstd=std(single(rp(:)));
bstd=std(single(bp(:)));
gstd=std(single(gp(:)));
plane=[rstd bstd gstd];
con=max(plane);
mimg=single(con);
max(rstd,bstd);
mimg=single(rp);
%figure,imshow(mimg);
mx=max(max(mimg));
mi=min(min(mimg));
monoImage = uint8(255 * (single(mimg) - mi) / (mx - mi));
threshold=uint8((mx+mi)/2);
bi=255*(monoImage<threshold);
%figure,imshow(bi);
[labeli noofwalls]=bwlabel(bi,4);
collabel = label2rgb (labeli, 'hsv', 'k', 'shuffle');
%figure,imshow(collabel);
bi1=(labeli==1);
width=5;
bi1dil=imdilate(bi1,ones(width));
bi1fill=imfill(bi1dil,'holes');
bi1erode=imerode(bi1fill,ones(width));
bil=bi1fill-bi1erode;
%figure,imshow(bil);
bi=bi1fill;
bi(bi1erode)=0;
redplane=mimg;
greenplane=mimg;
blueplane=mimg;
redplane(bi)=255;
greenplane(bi)=0;
blueplane(bi)=0;
solvedimage=cat(3,redplane,blueplane,greenplane);

figure,imshow((solvedimage));

A=zeros(800,800); % black box
A(200:600,200:600)=1;% white box
imshow(A,[])

img = repmat(A, 10,10);
imshow(img)


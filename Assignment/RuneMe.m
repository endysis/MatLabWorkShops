% MATLAB script for Assessment Item-1
close all;

% Step-1: Load input image
I = imread('AssignmentInput.jpg');
%figure;
%imshow(I);
%title('Step-1: Load input image');

% Step-2: Conversion of input image to greyscale
% for you to fill in ??????????
IG = rgb2gray(I);  % Can I use this? IG == Image Gray
%figure;
%imshow(IG);
%title('Step-2: Conversion of input image to greyscale');

%

% Step-3:
%Noise removal - Median Filter - To remove Salt and Pepper Noise



%{ 
Manual Mode

x = size(IG,1); % Size of X Coordinates
y = size(IG,2); % Size of Y Coordinates

padI = zeros(x+2,y+2,'uint8'); % Creates a matrix with 2 pixels larger either side, for 0 padding. 
IF = zeros(x,y,'uint8'); % Final filterd image


x1 = 2; % Non padded matrix Counter
y1 = 2; %

for x = 1:size(IG,1)
    y1 = 2;
    for y = 1:size(IG,2)
        padI(x1,y1) = IG(x,y);
        y1 = y1 + 1;
    end
    x1 = x1 + 1;
end

mid = (9 + 1)/2;

for i = 1:size(padI,1)-2
    for j = 1:size(padI,2)-2
        win = zeros(9,1); % Linear Array
        c = 1; % Counter fo the linear array
        for e = 1:3 % Incremnts the neighbourhood
            for r = 1:3
                win(c) = padI(e+i-1,r+j-1); % Start from the top left of the neighbourhood and work down.
                c = c + 1; 
            end
        end
        med = sort(win);
        IF(i,j) = med(mid);
    end
end

imshow(IF); % Result

%}


% Function Mode
x = size(IG,1); % Size of the gray image X
y = size(IG,2); % Size of the gray image Y
IG = padarray(IG,[1,1]); % Funtions which pads the array
IG = medfilt2(IG); % Function performs a median filter

IF = zeros(x,y,'uint8'); % uint8 because range 0 - 255

x1 = 1; % Counter for new picture coordinates.
y1 = 1;

for i = 2:size(IG,1)-1 % Starts one in and ends one in
    y1 = 1;
    for j = 2:size(IG,2)-1
    IF(x1,y1) = IG(i,j);
    y1 = y1 + 1;
    end
    x1 = x1 + 1;
end

%figure
%imshow(IF); % Result



% Step 4
ID = 255*im2double(IF);

mi = min(min(ID)); % Finds the minimum pizel intensity. Old Min
ma = max(max(ID)); % Old Max


%ICS = imadjust(IF,[mi/255;ma/255],[0;1]); % Implements using a function
% Why?? Cannot get it to stretch


ICS = histeq(IF) % Histogram equalisation  Why??


figure;
subplot(2,2,1);
imshow(IF);
title('Original');

subplot(2,2,2);
imshow(ICS);
title('Equalised');

subplot(2,2,3);
imhist(IF);
title('Original Histogram');

subplot(2,2,4);
imhist(ICS);
title('Equalised Histogram');

%figure
%imshow(X);






% Task 5
% Manual
for i = 1:size(IF,1)
    for j = 1:size(IF,2)
        if ICS(i,j) < 50
            ICS(i,j) = 255;
        else
            ICS(i,j) = 0;
        end 
    end
end


%BW = im2bw(ICS,0.2);



% Task 6  - Understand how errode works
se = strel('square',3);

errI = imerode(ICS,se);

figure
subplot(1,2,1)
imshow(ICS);


subplot(1,2,2)
imshow(errI);

































































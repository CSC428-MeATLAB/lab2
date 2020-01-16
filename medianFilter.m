im = imread("boat2.tif");
im = applyMedianFilter(im,1);
imshow(im);

% Width/height of filter is 2*radius+1
function [B] = applyMedianFilter(im, radius)
    %Create a new image
    B = zeros(size(im,1), size(im,2));
    %Iterate over each pixel in the image
    for i=(1+radius):size(im,1)-radius
        for j=(1+radius):size(im,2)-radius
            %Set each pixel in the new image to the median value of the
            %surrounding pixels in the original image
            C = im((i-radius):(i+radius), (j-radius):(j+radius));
            B(i,j) = median(C,"all");
        end
    end
    %Trim out the borders in the new image
    B = B((1+radius):size(B,1)-radius,(1+radius):size(B,2)-radius);
    B = cast(B,"uint8");
end
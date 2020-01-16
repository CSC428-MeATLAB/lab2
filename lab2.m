% Read and Display 2 RGB images
img_1 = imread('building.gif');
img_2 = imread('Boat2.tif');
%img_1 = cast(img_1,'double');
%img_2 = cast(img_2,'double');
subplot(3,2,1), imshow(img_1, 'InitialMagnification', 200);
subplot(3,2,2), imshow(img_2, 'InitialMagnification', 200);

filtered_img_1 = apply_filter(img_1, ones(7)/49);
filtered_img_2 = apply_filter(img_2, ones(7)/49);

subplot(3,2,3), imshow(filtered_img_1, 'InitialMagnification', 200);
subplot(3,2,4), imshow(filtered_img_2, 'InitialMagnification', 200);

function [filtered_image] = apply_filter(image, matrix)
    cast_img = cast(image,'double');
    [numRows, numCols] = size(matrix);
    edgepadding = floor(numRows/2);
    filtered_image = cast_img(1 + edgepadding:end - edgepadding, 1 + edgepadding:end - edgepadding);
    for row=1:size(filtered_image,1)
        for col=1:size(filtered_image, 2)
            sub_matrix = cast_img(row:(row+numRows-1), col:(col+numCols-1));
            filtered_image(row, col) = sum(matrix.*sub_matrix,'all');
        end
    end
    filtered_image = cast(filtered_image,'uint8');
end
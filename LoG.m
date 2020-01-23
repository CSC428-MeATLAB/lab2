im = rgb2gray(imread("bike-lane.jpg"));
sigmasq=1;
sigma = sqrt(sigmasq);
size = 2*ceil(sigma*3-1)+1;
fil = fspecial("log", size, sigma); 
res=apply_filter(im,fil);
res = res < .45*max(max(res));
imshow(res);

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
    filtered_image = mat2gray(filtered_image);
end
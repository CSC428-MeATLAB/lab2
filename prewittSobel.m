im1 = rgb2gray(imread('bike-lane.jpg'));
[prewitt_G, prewitt_edge] = apply_prewitt_sobel(im1, 'prewitt', 0.2);
[sobel_G, sobel_edge] = apply_prewitt_sobel(im1, 'sobel', 0.2);

imwrite(prewitt_G, 'bike-line_prewitt_G.png');
imwrite(sobel_G, 'bike-line_sobel_G.png');
imwrite(prewitt_edge, 'bike-line_prewitt_edge.png');
imwrite(sobel_edge, 'bike-line_sobel_edge.png');

function [G, edge_map] = apply_prewitt_sobel(image, type, threshold_percent)
    Sx = fspecial(type);
    Sy = transpose(Sx);

    Gx = apply_filter(image, Sx);
    Gy = apply_filter(image, Sy);

    G = (Gx.^2 + Gy.^ 2).^0.5;
    
    threshold = max(G(:)) * threshold_percent;
    edge_map = G > threshold;
    
    G = mat2gray(G);
end

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
end
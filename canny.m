filename = 'bike-lane.jpg';
im1 = rgb2gray(imread(filename));

% Single image with different thresholds/sigma
values = transpose([
    [[0.05, 0.1], 0.5]
    [[0.05, 0.1], 1]
    [[0.05, 0.1], 1.5]
    [[0.1, 0.2], 1]
    [[0.1, 0.3], 1]
]);

for value = values
    thresholds = [value(1), value(2)];
    sigma = value(3);
    edge_map = edge(im1, 'canny', thresholds, sigma);
    figure;
    imshow(edge_map);
    imwrite(edge_map, sprintf('%s_[%.2f,%.2f]_%.2f.png', filename, thresholds(1), thresholds(2), sigma));
end

% All best results

im2 = rgb2gray(imread('corridor.jpg'));
thresholds = [0.05, 0.1];

im3 = rgb2gray(imread('New York City.jpg'));
im4 = rgb2gray(imgread('corner_window.jpg'));


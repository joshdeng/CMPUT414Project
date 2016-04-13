% This is the main program to train people counting for the motion capture
% database picture frames. These frames are made with pictures taken from
% images of bipeds loaded with the motion capture file
% With a 10-fold cross validation the program learns the parameter k of a
% k nearest neighbor program
n = 10;
load('training_set.mat');
load('vidf_mask.mat');
load('train_data.mat');
load('test_set.mat');
load('Practice.mat');
load('matlab.mat')
B = binary_mask;
mask = load('vidf_mask.mat');
srcFiles = dir('/Users/Klinton/Documents/MATLAB/vidf_images/*.png');  % the folder in which my images exists
histMatrix = zeros(128,25000);
X = zeros(128,25000);
y = training_set(:,2);
y = cell2mat(y);
for i = 1 : length(training_set)
    trainpic = cell2mat(training_set(i,1));
    filename = strcat('/Users/Klinton/Documents/MATLAB/vidf_images/',trainpic);
    I = imread(filename);
    feature = my_feature(I,B,128);
    X(:,i) = feature; 
    %figure, imshow(I);
end
k = cross_validate_knn(X,y,(1:8),n);

fullkdtree = vl_kdtreebuild(X);

Xt = zeros(128,7597);
Yt = training_set(:,2);
Yt = cell2mat(Yt);
for i = 1 : length(test_set)
    testpic = cell2mat(test_set(i,1));
    filename = strcat('/Users/Klinton/Documents/MATLAB/vidf_images/',testpic);
    I = imread(filename);
    feature = my_feature(I,B,128);
    Xt(:,i) = feature; 
    %figure, imshow(I);
end
%   Find out k nearest neighbors for Xt. Use the k value you learned
%   in Step 3. Compute average prediction error on the test set. Display
%   this error with "disp" function.
[~,smallestK] = min(k);
predError = PredictPeopleCount(X, y, Xt, smallestK, 'mean');
predError = abs(abs(mean(Yt)) - abs(mean(predError)));
disp('Error: ');
disp(predError);
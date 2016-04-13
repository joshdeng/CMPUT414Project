function yt = PredictPeopleCount(X, y, Xt, k, combine_method)
% This function returns predicted count yt for test data Xt
% It uses k nearest neighbor with training data (X, y) and parameter value k

% X is the training feature and y is the training response
% X is m by n and y is n by 1. n is the number of data points, m is the
% dimension of the feature vector.
% Xt is the m by p test feature. p is the number of test data points.
% k is the knn parameter k
% compbine_method is a string: 'mean' or 'mode'; you can use 'mean' for your
% assignment. When k is greater than 1, you will use combine_method to 
% combine the responses of the neareast neighbors. Use
% strcmp(combine_method, 'mean') to see if the input was 'mean', etc.
% yt is the predicted count for the test set Xt. dimention of yt is p by 1.
xkdtree = vl_kdtreebuild(X);
[index, distance] = vl_kdtreequery(xkdtree, X, Xt,'Numneighbors', k) ;
yt= y(index); %extracts all query indexs from y
if k > 1 && strcmp(combine_method, 'mean')
    yt = mean(yt);
end
    

% default parameters

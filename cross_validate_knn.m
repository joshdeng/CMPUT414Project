function ev = cross_validate_knn(X,y,ks,n)
% X: all feature vectors for all training set, this is a m by p matrix,
% where m is the dimention of the feature vector, and p is the number of
% data points
% y: people count for the training set, p by 1 vector
% ks: range of values of k of a knn classifier, say 1:8.
% n: a number indicating how many folds of cross validation to do,
% typically 10
% ev: mean error vector that you will output
%Cross validation
fold = (length(X)/n);
sum = 0;
 for k = drange(ks)
   for i = 1 : n
        front = (fold * (i) - fold) + 1;
        Xi  = X(:,front:fold * (i));
        yi  = y(front:fold * (i),:);
        Xi_ = [X(:,1:front-1),X(:,fold * (i)+1:end)];
        yi_ = [y(1:front-1);y(fold * (i)+1:end)];
       yip = PredictPeopleCount(Xi_, yi_, Xi, k, 'mean');

%       compute mean absolute error between yi and yip. Use Matlab

        ei = abs(abs(mean(yip))) - abs(mean(yi));
        sum = ei+sum;
   end 
 end 

% Compute ev, the mean error vector, as mean of ei's over n folds.
sum = mean(sum);
ev = abs(sum/n);
return
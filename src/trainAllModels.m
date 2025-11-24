% function model = trainModel(X, Y)
% 
%     % 80/20 stratified split
%     cv = cvpartition(Y, 'Holdout', 0.2);
% 
%     trainX = X(training(cv), :);
%     trainY = Y(training(cv));
% 
%     % Multi-class ensemble classifier
%     model = fitcensemble(trainX, trainY, ...
%         'Method', 'Bag', ...
%         'NumLearningCycles', 200);
% 
%     save('model.mat','model');
% end


function models = trainAllModels(X, Y)

    % Ensemble (Bagging)
    models.Ensemble = fitcensemble(X, Y, 'Method', 'Bag');

    % SVM (RBF)
    t = templateSVM('KernelFunction','rbf');
    models.SVM = fitcecoc(X, Y, 'Learners', t);

    % Naive Bayes
    models.NaiveBayes = fitcnb(X, Y);

    % Decision Tree
    models.Tree = fitctree(X, Y);

end

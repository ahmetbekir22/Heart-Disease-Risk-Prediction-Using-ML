function accuracy = evaluateModel(model, X, Y)

    cv = cvpartition(Y, 'Holdout', 0.2);

    Xtrain = X(training(cv), :);
    Ytrain = Y(training(cv));

    Xtest = X(test(cv), :);
    Ytest = Y(test(cv));

    % Eğer modeli yeniden eğitmek istemiyorsan:
    pred = predict(model, Xtest);

    accuracy = sum(pred == Ytest) / numel(Ytest);

    % Confusion Matrix
    figure;
    confusionchart(Ytest, pred);

    % ROC
    try
        [scores, scores2] = resubPredict(model);
    catch
    end
end

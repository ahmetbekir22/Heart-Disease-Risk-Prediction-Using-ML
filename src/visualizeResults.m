function visualizeResults(model, X, Y)

    % ==== Train/Test Split ====
    cv = cvpartition(Y, 'Holdout', 0.2);
    testX = X(test(cv), :);
    testY = Y(test(cv));

    preds = predict(model, testX);

    % ==== Confusion Matrix ====
    figure;
    confusionchart(testY, preds);
    title("Confusion Matrix (Multi-Class)");

    % ==== 1) Class Distribution ====
    figure;
    histogram(Y);
    title("Class Distribution");
    xlabel("Class (0–4)");
    ylabel("Count");

    % ==== 2) Age Distribution ====
    if ismember("age", X.Properties.VariableNames)
        figure;
        histogram(X.age, 20);
        title("Age Distribution");
        xlabel("Age");
        ylabel("Frequency");
    end

    % ==== 3) Correlation Matrix ====
    numericVars = X(:, varfun(@isnumeric, X, 'OutputFormat','uniform'));
    corrMatrix = corr(table2array(numericVars), 'rows', 'complete');

    figure;
    heatmap(corrMatrix, ...
        'Colormap', parula, ...
        'Title', 'Correlation Matrix');

    % ==== 4) Feature Importance ====
    try
        figure;
        imp = predictorImportance(model);
        bar(imp);
        title('Feature Importance');
        xticklabels(numericVars.Properties.VariableNames);
        xtickangle(45);
        ylabel('Importance');
    catch
        disp("Feature importance not supported for this model.");
    end

end

function results = compareModels(X, Y)

    rng(1); % reproducible

    % Initialize results table
    results = table("Model", 0.0, 'VariableNames', ["Model", "Accuracy"]);
    results(1,:) = [];

    fprintf("\n===============================================\n");
    fprintf("  MODEL KARŞILAŞTIRMA (5-FOLD CROSS VALIDATION)\n");
    fprintf("===============================================\n\n");

    % ------------------ 1) Ensemble ------------------
    M1 = fitcensemble(X, Y, 'Method', 'Bag', 'KFold', 5);
    acc1 = 1 - kfoldLoss(M1);
    results(end+1,:) = {"Ensemble (Bagging)", acc1};

    fprintf("1) Ensemble (Bagging)\n");
    fprintf("   Accuracy = %.2f%%\n\n", acc1 * 100);

    % ------------------ 2) Decision Tree ------------------
    M2 = fitctree(X, Y, 'KFold', 5);
    acc2 = 1 - kfoldLoss(M2);
    results(end+1,:) = {"Decision Tree", acc2};

    fprintf("2) Decision Tree\n");
    fprintf("   Accuracy = %.2f%%\n\n", acc2 * 100);

    % ------------------ 3) SVM (ECOC / RBF) ------------------
    t = templateSVM('KernelFunction', 'rbf');
    M3 = fitcecoc(X, Y, 'Learners', t, 'KFold', 5);
    acc3 = 1 - kfoldLoss(M3);
    results(end+1,:) = {"SVM (ECOC RBF)", acc3};

    fprintf("3) SVM (ECOC / RBF Kernel)\n");
    fprintf("   Accuracy = %.2f%%\n\n", acc3 * 100);

    % ------------------ 4) Naive Bayes ------------------
    M4 = fitcnb(X, Y, 'KFold', 5);
    acc4 = 1 - kfoldLoss(M4);
    results(end+1,:) = {"Naive Bayes", acc4};

    fprintf("4) Naive Bayes\n");
    fprintf("   Accuracy = %.2f%%\n\n", acc4 * 100);

    % ------------------ Accuracy Comparison Chart ------------------
    figure;
    bar(results.Accuracy * 100);
    set(gca, 'XTickLabel', results.Model, 'XTick', 1:height(results));
    xtickangle(45);
    ylabel("Accuracy (%)");
    title("Model Accuracy Comparison (5-Fold CV)");

    % ------------------ Best Model ------------------
    [~, idx] = max(results.Accuracy);

    fprintf("===============================================\n");
    fprintf("  BEST MODEL: %s (%.2f%%)\n", results.Model(idx), results.Accuracy(idx) * 100);
    fprintf("===============================================\n\n");

end

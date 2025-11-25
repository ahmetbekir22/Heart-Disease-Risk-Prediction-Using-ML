function cvConfusionResults(results, Y)

fprintf("\n========== CONFUSION MATRICES (5-FOLD CV PREDICTIONS) ==========\n\n");

modelsList = fieldnames(results);

for i = 1:length(modelsList)
    name = modelsList{i};
    cvM = results.(name).cvModel;

    % CV tahmini al
    pred = kfoldPredict(cvM);

    % Confusion matrix
    C = confusionmat(Y, pred);

    TN = C(1,1);
    FP = C(1,2);
    FN = C(2,1);
    TP = C(2,2);

    acc = (TP + TN) / sum(C(:)) * 100;
    
    % Precision, Recall, F1-Score hesapla
    precision = TP / (TP + FP) * 100;
    recall = TP / (TP + FN) * 100;
    f1_score = 2 * (precision * recall) / (precision + recall);

    fprintf("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n");
    fprintf("Model: %s\n", name);
    fprintf("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n");
    
    % Confusion Matrix görselleştirme
    fprintf("  Confusion Matrix:\n");
    fprintf("  ┌─────────────────────┬──────────────┬──────────────┐\n");
    fprintf("  │                     │   Predicted  │   Predicted  │\n");
    fprintf("  │                     │   Negative   │   Positive   │\n");
    fprintf("  ├─────────────────────┼──────────────┼──────────────┤\n");
    fprintf("  │  Actual Negative    │     %4d     │     %4d     │\n", TN, FP);
    fprintf("  │  Actual Positive    │     %4d     │     %4d     │\n", FN, TP);
    fprintf("  └─────────────────────┴──────────────┴──────────────┘\n\n");
    
    % Metrikleri göster
    fprintf("  Performance Metrics:\n");
    fprintf("  ├─ Accuracy       : %.2f%%\n", acc);
    fprintf("  ├─ Precision      : %.2f%%\n", precision);
    fprintf("  ├─ Recall         : %.2f%%\n", recall);
    fprintf("  ├─ F1-Score       : %.2f%%\n", f1_score);
    fprintf("  ├─ True Positive  : %d\n", TP);
    fprintf("  ├─ True Negative  : %d\n", TN);
    fprintf("  ├─ False Positive : %d\n", FP);
    fprintf("  └─ False Negative : %d\n\n", FN);
    
    % MATLAB'ın built-in confusion chart kullanarak görsel oluştur
    figure('Name', sprintf('Confusion Matrix - %s', name));
    confusionchart(Y, pred);
    title(sprintf('%s - Confusion Matrix (5-Fold CV)', name));
    
end

fprintf("==============================================================\n");

end
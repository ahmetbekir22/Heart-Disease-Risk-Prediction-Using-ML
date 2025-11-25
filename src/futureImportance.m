function plotFeatureImportance(results, featureNames)

fprintf("\n========== FEATURE IMPORTANCE ANALYSIS ==========\n\n");

%% 1) Decision Tree Feature Importance
if isfield(results, 'Tree')
    treeModel = results.Tree.model;
    imp_tree = predictorImportance(treeModel);
    
    figure('Name', 'Feature Importance - Decision Tree', 'Position', [100, 100, 1000, 600]);
    [sorted_imp, idx] = sort(imp_tree, 'descend');
    
    barh(sorted_imp, 'FaceColor', [0.2 0.6 0.8]);
    set(gca, 'YTick', 1:length(featureNames));
    set(gca, 'YTickLabel', featureNames(idx));
    xlabel('Importance Score', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Features', 'FontSize', 12, 'FontWeight', 'bold');
    title('Feature Importance - Decision Tree', 'FontSize', 14, 'FontWeight', 'bold');
    grid on;
    
    % En önemli 5 feature
    fprintf("Decision Tree - Top 5 Features:\n");
    for i = 1:min(5, length(featureNames))
        fprintf("  %d. %s: %.4f\n", i, featureNames{idx(i)}, sorted_imp(i));
    end
    fprintf("\n");
end


%% 2) Ensemble (Random Forest/Bagging) Feature Importance
if isfield(results, 'Ensemble')
    ensembleModel = results.Ensemble.model;
    
    % Out-of-bag feature importance
    imp_ensemble = oobPermutedPredictorImportance(ensembleModel);
    
    figure('Name', 'Feature Importance - Ensemble', 'Position', [150, 150, 1000, 600]);
    [sorted_imp_ens, idx_ens] = sort(imp_ensemble, 'descend');
    
    barh(sorted_imp_ens, 'FaceColor', [0.8 0.4 0.2]);
    set(gca, 'YTick', 1:length(featureNames));
    set(gca, 'YTickLabel', featureNames(idx_ens));
    xlabel('Out-of-Bag Importance', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Features', 'FontSize', 12, 'FontWeight', 'bold');
    title('Feature Importance - Ensemble (Bagging)', 'FontSize', 14, 'FontWeight', 'bold');
    grid on;
    
    % En önemli 5 feature
    fprintf("Ensemble - Top 5 Features:\n");
    for i = 1:min(5, length(featureNames))
        fprintf("  %d. %s: %.4f\n", i, featureNames{idx_ens(i)}, sorted_imp_ens(i));
    end
    fprintf("\n");
end


%% 3) Karşılaştırmalı Grafik (Her iki modeli yan yana)
if isfield(results, 'Tree') && isfield(results, 'Ensemble')
    figure('Name', 'Feature Importance Comparison', 'Position', [200, 200, 1200, 700]);
    
    % Normalize et (0-1 arası)
    imp_tree_norm = imp_tree / max(imp_tree);
    imp_ens_norm = imp_ensemble / max(imp_ensemble);
    
    % Ortalama importance hesapla
    avg_importance = (imp_tree_norm + imp_ens_norm) / 2;
    [sorted_avg, idx_avg] = sort(avg_importance, 'descend');
    
    % Yan yana bar plot
    comparison_data = [imp_tree_norm(idx_avg), imp_ens_norm(idx_avg)];
    
    barh(comparison_data, 'grouped');
    set(gca, 'YTick', 1:length(featureNames));
    set(gca, 'YTickLabel', featureNames(idx_avg));
    xlabel('Normalized Importance Score', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Features', 'FontSize', 12, 'FontWeight', 'bold');
    title('Feature Importance Comparison (Decision Tree vs Ensemble)', 'FontSize', 14, 'FontWeight', 'bold');
    legend({'Decision Tree', 'Ensemble'}, 'Location', 'southeast', 'FontSize', 11);
    grid on;
    
    % Top 5 Average Importance
    fprintf("Combined Average - Top 5 Features:\n");
    for i = 1:min(5, length(featureNames))
        fprintf("  %d. %s: %.4f (Tree: %.4f, Ensemble: %.4f)\n", ...
            i, featureNames{idx_avg(i)}, sorted_avg(i), ...
            imp_tree_norm(idx_avg(i)), imp_ens_norm(idx_avg(i)));
    end
end

fprintf("==================================================\n\n");

end
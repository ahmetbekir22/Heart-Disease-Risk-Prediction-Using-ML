function pcaVisualization(X, Y)

    % Only numeric columns
    numericVars = X(:, varfun(@isnumeric, X, 'OutputFormat','uniform'));
    Xmat = table2array(numericVars);

    % PCA computation
    [coeff, score, ~] = pca(Xmat);

    % Plot 1st two components
    figure;
    gscatter(score(:,1), score(:,2), Y);
    xlabel("PC1");
    ylabel("PC2");
    title("PCA Visualization (First 2 Components)");
    grid on;

end

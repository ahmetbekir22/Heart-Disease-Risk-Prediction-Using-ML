function ldaVisualization(X, Y)

    % Only numeric data for LDA
    numericVars = X(:, varfun(@isnumeric, X, 'OutputFormat','uniform'));
    Xmat = table2array(numericVars);

    % Fit LDA
    Mdl = fitcdiscr(Xmat, Y);

    % Transform data
    ldaScores = Xmat * Mdl.Coeffs(1,2).Linear;

    figure;
    gscatter(ldaScores, zeros(size(ldaScores)), Y);
    xlabel("LDA Component 1");
    title("LDA: Class Separability");
    ylim([-1 1]); % Just for cleaner visualization
    grid on;

end

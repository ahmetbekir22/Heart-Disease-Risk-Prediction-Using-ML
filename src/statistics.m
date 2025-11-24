function stats_dummy_wrapper
% This dummy function forces MATLAB to treat this as a function file.
end

function plotClassDistribution(Y)
    figure;
    histogram(Y);
    title("Class Distribution");
    xlabel("Class (0–4)");
    ylabel("Count");
end

function plotAgeDistribution(data)
    figure;
    histogram(data.age, 20);
    title("Age Distribution");
    xlabel("Age");
    ylabel("Frequency");
end

function plotGenderPie(data)
    figure;
    genders = categorical(data.sex);
    tab = countcats(genders);
    pie(tab, categories(genders));
    title("Gender Distribution");
end

function plotCorrelation(data)
    numericData = data(:, varfun(@isnumeric, data, 'OutputFormat','uniform'));
    corrMatrix = corr(table2array(numericData), 'rows', 'complete');
    figure;
    heatmap(corrMatrix, 'Colormap', parula);
    title("Correlation Matrix");
end

function plotAgeVsClass(data, Y)
    figure;
    boxplot(data.age, Y);
    xlabel('Disease Class');
    ylabel('Age');
    title('Age vs Disease Class');
end

function plotMissingData(data)
    figure;
    heatmap(ismissing(data));
    title("Missing Data Map");
end

function plotFeatureImportance(model)
    figure;
    imp = predictorImportance(model);
    bar(imp);
    title('Feature Importance');
    xlabel('Features');
    ylabel('Importance');
end

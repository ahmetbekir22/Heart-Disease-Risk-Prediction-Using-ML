function call_statistics_functions(data, Y, model)

    plotClassDistribution(Y);
    plotAgeDistribution(data);
    plotGenderPie(data);
    plotCorrelation(data);
    plotAgeVsClass(data, Y);
    plotMissingData(data);
    plotFeatureImportance(model);

end

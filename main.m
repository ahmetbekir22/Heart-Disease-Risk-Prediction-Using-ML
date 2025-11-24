clear; clc; close all;

addpath('src');

% Load data
[X, Y, data] = loadData();

% Train all models and save them
models = trainAllModels(X, Y);
save models.mat models;

% Evaluate performance of best model (SVM or Ensemble)
% (You can choose: here we use Ensemble for example)
%accuracy = evaluateModel(models.Ensemble, X, Y);

% Visualizations
visualizeResults(models.Ensemble, X, Y);

% Model Comparison
results = compareModels(X, Y);

% PCA Visualization
pcaVisualization(X, Y);

% LDA Visualization
ldaVisualization(X, Y);

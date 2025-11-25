
function results = compareModels(X, Y)

results = struct();

fprintf("\n=========== MODEL COMPARISON (5-FOLD CV) ===========\n\n");

%% 1) SVM
t = templateSVM('KernelFunction','rbf');
M1 = fitcecoc(X, Y, 'Learners', t);
cvM1 = crossval(M1);

cvAcc1 = 1 - kfoldLoss(cvM1, 'LossFun', 'ClassifError');
results.SVM.model = M1;
results.SVM.cvModel = cvM1;
results.SVM.cvAcc = cvAcc1;

fprintf("SVM: %.2f%%\n", cvAcc1*100);


%% 2) Ensemble (Bagging)
M2 = fitcensemble(X, Y, 'Method','Bag');
cvM2 = crossval(M2);

cvAcc2 = 1 - kfoldLoss(cvM2, 'LossFun', 'ClassifError');
results.Ensemble.model = M2;
results.Ensemble.cvModel = cvM2;
results.Ensemble.cvAcc = cvAcc2;

fprintf("Ensemble: %.2f%%\n", cvAcc2*100);


%% 3) Naive Bayes
M3 = fitcnb(X, Y);
cvM3 = crossval(M3);

cvAcc3 = 1 - kfoldLoss(cvM3, 'LossFun', 'ClassifError');
results.NaiveBayes.model = M3;
results.NaiveBayes.cvModel = cvM3;
results.NaiveBayes.cvAcc = cvAcc3;

fprintf("Naive Bayes: %.2f%%\n", cvAcc3*100);


%% 4) Decision Tree
M4 = fitctree(X, Y);
cvM4 = crossval(M4);

cvAcc4 = 1 - kfoldLoss(cvM4, 'LossFun', 'ClassifError');
results.Tree.model = M4;
results.Tree.cvModel = cvM4;
results.Tree.cvAcc = cvAcc4;

fprintf("Decision Tree: %.2f%%\n", cvAcc4*100);


%% Best Model
[cvAccs, idx] = max([cvAcc1 cvAcc2 cvAcc3 cvAcc4]);
names = ["SVM","Ensemble","Naive Bayes","Decision Tree"];

fprintf("\nBEST MODEL → %s (%.2f%%)\n", names(idx), cvAccs*100);
fprintf("=====================================================\n\n");

end


function CHD_GUI
    % -------------------------------
    % COMPLETE CHD PREDICTION GUI
    % -------------------------------

    fig = uifigure('Name','CHD Prediction System','Position',[350 150 700 600]);

    % -------- INPUT FIELDS --------
    uilabel(fig,'Text','Age','Position',[20 530 120 20]);
    ageField = uieditfield(fig,'numeric','Position',[150 530 120 22]);

    uilabel(fig,'Text','Sex','Position',[20 490 120 20]);
    sexDrop = uidropdown(fig,'Items',{'Male','Female'},'Position',[150 490 120 22]);

    uilabel(fig,'Text','Smoker','Position',[20 450 120 20]);
    smokerDrop = uidropdown(fig,'Items',{'No','Yes'},'Position',[150 450 120 22]);

    uilabel(fig,'Text','Cigs Per Day','Position',[20 410 120 20]);
    cigsField = uieditfield(fig,'numeric','Position',[150 410 120 22]);

    uilabel(fig,'Text','BPMeds','Position',[20 370 120 20]);
    bpmDrop = uidropdown(fig,'Items',{'No','Yes'},'Position',[150 370 120 22]);

    uilabel(fig,'Text','Stroke History','Position',[20 330 120 20]);
    strokeDrop = uidropdown(fig,'Items',{'No','Yes'},'Position',[150 330 120 22]);

    uilabel(fig,'Text','Hypertension','Position',[20 290 120 20]);
    hypDrop = uidropdown(fig,'Items',{'No','Yes'},'Position',[150 290 120 22]);

    uilabel(fig,'Text','Diabetes','Position',[20 250 120 20]);
    diabDrop = uidropdown(fig,'Items',{'No','Yes'},'Position',[150 250 120 22]);

    uilabel(fig,'Text','Total Cholesterol','Position',[20 210 120 20]);
    cholField = uieditfield(fig,'numeric','Position',[150 210 120 22]);

    uilabel(fig,'Text','Sys BP','Position',[20 170 120 20]);
    sysField = uieditfield(fig,'numeric','Position',[150 170 120 22]);

    uilabel(fig,'Text','Dia BP','Position',[20 130 120 20]);
    diaField = uieditfield(fig,'numeric','Position',[150 130 120 22]);

    uilabel(fig,'Text','BMI','Position',[20 90 120 20]);
    bmiField = uieditfield(fig,'numeric','Position',[150 90 120 22]);

    uilabel(fig,'Text','Heart Rate','Position',[20 50 120 20]);
    hrField = uieditfield(fig,'numeric','Position',[150 50 120 22]);

    uilabel(fig,'Text','Glucose','Position',[20 10 120 20]);
    glucoseField = uieditfield(fig,'numeric','Position',[150 10 120 22]);

    % -------- RESULTS TABLE --------
    uitable(fig,'ColumnName',{'Model','Prediction'},...
        'Position',[300 200 360 300],...
        'Tag','ResultsTable');

    % -------- RESULT MESSAGE LABEL --------
    resultMsg = uilabel(fig,'Text','',...
        'FontSize',14,'FontWeight','bold',...
        'Position',[300 160 360 30],...
        'FontColor',[0 0.6 1]);   % mavi ton

    % -------- PREDICT BUTTON --------
    uibutton(fig,'Text','Predict Risk','Position',[300 120 200 35], ...
        'ButtonPushedFcn', @(btn,event) onPredict());


    % -----------------------------------------------------------
    % CALLBACK FUNCTION
    % -----------------------------------------------------------
    % Clear old message
    resultMsg.Text = '';
    function onPredict()
    
        % Clear previous message when Predict is pressed
        resultMsg.Text = '';
    
        % Load models (lazy load)
        persistent models;
        if isempty(models)
            s = load("models.mat");
            models = s.models;
        end
    
        % Prepare input table
        in = table(...
            strcmp(sexDrop.Value,"Male"), ...
            ageField.Value, ...
            strcmp(smokerDrop.Value,"Yes"), ...
            cigsField.Value, ...
            strcmp(bpmDrop.Value,"Yes"), ...
            strcmp(strokeDrop.Value,"Yes"), ...
            strcmp(hypDrop.Value,"Yes"), ...
            strcmp(diabDrop.Value,"Yes"), ...
            cholField.Value, ...
            sysField.Value, ...
            diaField.Value, ...
            bmiField.Value, ...
            hrField.Value, ...
            glucoseField.Value, ...
            'VariableNames',{ ...
                'male','age','currentSmoker','cigsPerDay','BPMeds',...
                'prevalentStroke','prevalentHyp','diabetes','totChol',...
                'sysBP','diaBP','BMI','heartRate','glucose'} ...
        );
    
        % Predictions
        pSVM  = predict(models.SVM, in);
        pEn   = predict(models.Ensemble, in);
        pNB   = predict(models.NaiveBayes, in);
        pTree = predict(models.Tree, in);
    
        % Results table update (char-based)
        results = {
            'SVM',          resultText(pSVM);
            'Ensemble',     resultText(pEn);
            'Naive Bayes',  resultText(pNB);
            'Decision Tree',resultText(pTree);
        };
    
        tbl = findobj(fig,'Tag','ResultsTable');
        tbl.Data = results;
    
        % Show success message again
        resultMsg.Text = '✓ Results are calculated successfully.';
        drawnow;

    % Auto-hide message after 2 seconds
        pause(2);
        resultMsg.Text = '';
    end

    % -------------- Helper Function ----------------
    function txt = resultText(val)
        if val == 1
            txt = 'Risk exist';
        else
            txt = 'No Risk';
        end
    end

end
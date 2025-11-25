
---

# Heart Disease Risk Prediction Using Machine Learning

This project implements a complete machine learning workflow to predict 10-year coronary heart disease (CHD) risk using the Framingham Heart Study dataset. The system includes data preprocessing, cross-validated model training, performance evaluation, dimensionality-reduction visualizations (PCA/LDA), and an interactive MATLAB GUI for real-time prediction.

---

##  Project Overview

The goal of this project is to build a reliable CHD prediction system that compares multiple machine learning models and provides users with an intuitive interface for risk assessment. The system supports clinical decision-making by analyzing patient data and generating predictions using several cross-validated models.

---

##  Dataset

Framingham Heart Study Dataset

Features used include:

* Demographics (age, sex)
* Lifestyle factors (smoker status, cigarettes/day)
* Clinical measurements (cholesterol, systolic/diastolic BP, BMI, glucose, heart rate)
* Medical history (hypertension, diabetes, stroke history)

The target variable is **TenYearCHD** (0 = no risk, 1 = risk).

---

##  Data Preprocessing

* Removal of non-informative columns (e.g., *education*)
* Missing value imputation using **median strategy** for numerical variables
* Standardization for PCA
* Conversion of binary/categorical variables to numeric format
* Outlier-free and clean training table for all models

---

##  Machine Learning Models

The following machine learning algorithms were trained using **5-fold cross-validation**:

* **Support Vector Machine (SVM, RBF kernel)**
* **Ensemble Bagging Classifier**
* **Naive Bayes Classifier**
* **Decision Tree Classifier**

The models were compared using cross-validated accuracy, and *all four CV-trained models are used in the GUI for prediction*.

---

##  Model Evaluation

Evaluation metrics include:

* Cross-validated model accuracy
* Confusion matrix analysis:

  * True Positive (TP)
  * True Negative (TN)
  * False Positive (FP)
  * False Negative (FN)
* PCA visualization (first two principal components)
* LDA class-separation plot

These methods ensure a balanced and unbiased performance comparison.

---

##  MATLAB GUI

An interactive GUI was developed using MATLAB App Designer components.

### GUI Features

* User enters patient information (age, BP values, cholesterol, smoking status, etc.)
* System evaluates all four cross-validated models
* Outputs a table showing:

  * **Model Name**
  * **Risk Prediction (Risk Exist / No Risk)**
* Automatic status messages for user feedback
* Clean, simple, and practical interface

---

##  File Structure**

```
HeartDiseaseProject/
│
├── data/
│   └── framingham.csv
│
├── src/
│   ├── loadData.m
│   ├── compareModels.m
│   ├── confusionMatrixResults.m
│   ├── pcaVisualization.m
│   ├── ldaVisualization.m
│   └── visualizeResults.m
│
├── CHD_GUI.m
├── main.m
└── models.mat
```

---

##  Requirements

* MATLAB R2023+ (or R2025b used in development)
* **Statistics and Machine Learning Toolbox**

No additional toolboxes are required.

---

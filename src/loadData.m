
function [X, Y, data] = loadData()

    % Veri setini oku
    data = readtable('data/framingham.csv');

    % Target (CHD)
    Y = data.TenYearCHD;

    % Target kolonunu çıkar
    data.TenYearCHD = [];

    % education kolonunu kaldır (çok eksik)
    if ismember('education', data.Properties.VariableNames)
        data.education = [];
    end

    % ---- MEDIAN IMPUTATION ----
    % Hangi kolonlar numeric?
    numVars = varfun(@isnumeric, data, 'OutputFormat','uniform');

    for i = 1:width(data)
        if numVars(i)
            col = data.(i);
            med = median(col, 'omitnan');  % kolon medyanını hesapla
            col(ismissing(col)) = med;     % missing değerleri median ile doldur
            data.(i) = col;
        end
    end

    X = data;

end

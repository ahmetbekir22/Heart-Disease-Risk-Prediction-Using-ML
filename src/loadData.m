% function [X, Y, data] = loadData()
% 
%     data = readtable('data/framingham.csv');
% 
%     % Target (num kolonu)
%     Y = data.num;
% 
%     % num kolonunu çıkar, sadece özellikleri al
%     data.num = [];
% 
%     % Kategorik kolonları otomatik dönüştür
%     catCols = varfun(@iscellstr, data, 'OutputFormat', 'uniform') | ...
%               varfun(@islogical, data, 'OutputFormat', 'uniform');
% 
%     for i = 1:width(data)
%         if catCols(i)
%             data.(i) = categorical(data.(i));
%         end
%     end
% 
%     X = data;
% 
% end


function [X, Y, data] = loadData()

    % Veri setini oku
    data = readtable('data/framingham.csv');

    % Eksik verileri temizle
    data = rmmissing(data);

    % Target (TenYearCHD)
    Y = data.TenYearCHD;

    % Target kolonunu çıkar
    data.TenYearCHD = [];
    % Remove 'education' if present
    if ismember('education', data.Properties.VariableNames)
        data.education = [];
    end


    % Kategorik kolonları tespit et (Framingham çoğunlukla numeric)
    catCols = varfun(@iscellstr, data, 'OutputFormat','uniform') | ...
              varfun(@islogical, data, 'OutputFormat','uniform');

    % Kategorikleri dönüştür
    for i = 1:width(data)
        if catCols(i)
            data.(i) = categorical(data.(i));
        end
    end

    % Özellik matrisi
    X = data;

end

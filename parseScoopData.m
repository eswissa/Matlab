function [id_arr, hist_arr] =  parseScoopData(data)

id_arr = data(:,1);
hist_arr = data(:,2:end);
hist_arr = cell2mat(hist_arr);

end

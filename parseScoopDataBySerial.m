function [serial_arr, serial_count_arr, hist_arr] =  parseScoopDataBySerial(data)

serial_arr = data(:,1);
serial_count_arr = data(:,2);

hist_arr = data(:,3:end);
hist_arr = cell2mat(hist_arr);

end

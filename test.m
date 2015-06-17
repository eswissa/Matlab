conn = connectToScoop();
num_of_smaples = 2;

Bone_arr = {'PBSEThumbC0', 'PBSEThumbC1', 'PBSEThumbC2',...
            'PBSEIndexC0', 'PBSEIndexC1', 'PBSEIndexC2', ...
            'PBSEMiddleC0', 'PBSEMiddleC1', 'PBSEMiddleC2', ...
            'PBSERingC0', 'PBSERingC1', 'PBSERingC2', ...
            'PBSEPinkyC0', 'PBSEPinkyC1', 'PBSEPinkyC2'};
  
num_of_bones = length(Bone_arr);        
hist_arr = cell(1, num_of_bones);
normlized_curr_arr = zeros(num_of_smaples, 11);

for i=1:num_of_bones
    PBSE_query = generateQueryBySeriel(Bone_arr{i}, 'SqErr_v1',0:10, 'float', num_of_smaples);
    curs = exec(conn,PBSE_query_arr{i});
    query_result = fetch(curs);
    result_data_arr = query_result.Data;
 
    [data_serial_arr, data_serial_count_arr, data_hist_arr] = parseScoopDataBySerial(result_data_arr);
    curr_hist_arr = sqrt(data_hist_arr);

    for j=1:num_of_smaples
       normlized_curr_arr(j,:) = curr_hist_arr(j,:)/sum(curr_hist_arr(j,:));
    end
 
    normalized_arr = sum(normlized_curr_arr)/size(normlized_curr_arr,1);
    hist_arr{i} = normalized_arr;
end

for i=1:num_of_bones
    figure(1), subplot(5,3,i), histogram(hist_arr{i}, title(title_arr{i})
end

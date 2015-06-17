
function perBoneHist()

conn = connectToScoop();
num_of_smaples = 5;

Bone_arr = {'PBSEThumbC0', 'PBSEThumbC1', 'PBSEThumbC2',...
            'PBSEIndexC0', 'PBSEIndexC1', 'PBSEIndexC2', ...
            'PBSEMiddleC0', 'PBSEMiddleC1', 'PBSEMiddleC2', ...
            'PBSERingC0', 'PBSERingC1', 'PBSERingC2', ...
            'PBSEPinkyC0', 'PBSEPinkyC1', 'PBSEPinkyC2'};
        
title_arr = {'ThumbC0', 'ThumbC1', 'ThumbC2',...
             'IndexC0', 'IndexC1', 'IndexC2',...
             'MiddleC0', 'MiddleC1', 'MiddleC2', ...
             'RingC0', 'RingC1', 'RingC2', ...
             'PinkyC0', 'PinkyC1', 'PinkyC2'};


num_of_bones = length(Bone_arr);        
hist_arr = cell(1, num_of_bones);

for i=1:num_of_bones
    PBSE_query = generateQueryBySeriel(Bone_arr{i}, 'SqErr_v1',0:10, 'float', num_of_smaples);
    curs = exec(conn,PBSE_query);
    query_result = fetch(curs);
    result_data_arr = query_result.Data;
 
    [data_serial_arr, data_serial_count_arr, data_hist_arr] = parseScoopDataBySerial(result_data_arr);
    curr_hist_arr = sqrt(data_hist_arr);

    num_of_data = size(curr_hist_arr, 1);
    normlized_curr_arr = zeros(num_of_data, 11);

    for j=1:num_of_data
       normlized_curr_arr(j,:) = curr_hist_arr(j,:)/(sum(curr_hist_arr(j,:)+1));
    end
 
    normalized_arr = sum(normlized_curr_arr)/(size(normlized_curr_arr,1)+1);
    hist_arr{i} = normalized_arr;
end


for i=1:num_of_bones
    figure(1), subplot(5,3,i), bar([0.5:1:10.5], hist_arr{i}), title(title_arr{i})
    set(gca,'XTick', [1:11]);
end

end
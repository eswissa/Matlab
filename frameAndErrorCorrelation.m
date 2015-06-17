
%create a connection to the server
conn = connectToScoop();

error_rate_query = generateQueryById('HandError', 'CapsuleHandError_v1',0:30, 'int', 20);
frame_rate_query = generateQueryById('InstantFPS', 'InstantFPS_v1',0:126, 'int', 20);

%excute a query
curs_error_rate = exec(conn,error_rate_query);
curs_frame_rate = exec(conn,frame_rate_query);

%feth the data
error_rate_query_result = fetch(curs_error_rate);
frame_rate_query_result = fetch(curs_frame_rate);

%look at the data
error_rate_data = error_rate_query_result.Data;
frame_rate_data = frame_rate_query_result.Data;

%parse the data
[error_id_arr, error_hist_arr] = parseScoopDataById(error_rate_data);
[frame_id_arr, frame_hist_arr] = parseScoopDataById(frame_rate_data);

%sort error_rate data
[error_id_arr, idx] = sort(error_id_arr);
error_hist_arr = error_hist_arr(idx,:);

%sort frame_rate data
[frame_id_arr, idx] = sort(frame_id_arr);
frame_hist_arr = frame_hist_arr(idx,:);

%find keys the have both frame rate hist and error rate hist and create
%merged list
[intersect_arr, idx_frame, idx_error] = intersect(error_id_arr, frame_id_arr);
frame_hist_arr = frame_hist_arr(idx_frame,:);
error_hist_arr = error_hist_arr(idx_error, :);

%calcuate the frame rate and error rate outer product 
num_of_keys = length(intersect_arr);
sum_of_error_rate_times_frame_rate = 0;

error_rate_hist_size = size(error_hist_arr,2);
frame_rate_hist_size = size(frame_hist_arr,2);

for i=1:num_of_keys
    
    curr_frame_rate_hist = frame_hist_arr(i,:);
    curr_error_rate_hist = error_hist_arr(i,:);
    sum_of_error_rate_times_frame_rate = sum_of_error_rate_times_frame_rate + reshape(kron(curr_frame_rate_hist, curr_error_rate_hist)/sum(curr_frame_rate_hist),error_rate_hist_size, frame_rate_hist_size);
    
    sum_of_frame_rate = sum(curr_frame_rate_hist);
    sum_of_error_rate = sum(curr_error_rate_hist);
    
    sum_of_error_rate_times_frame_rate = sum_of_error_rate_times_frame_rate/sum_of_frame_rate;
end

 figure, surf(sum_of_error_rate_times_frame_rate);




function Query_str = generateQuery(group, name, bin_arr, data_type, num_of_lines)

Query_str = ['SELECT meta->', '''', 'content', '''', '->0->>', '''', 'id', '''', ','];
Query_str = sprintf('%s\n', Query_str);


for i=1:length(bin_arr)-1
    
    line_str = ['(meta->', '''', 'content', '''', '->0->', '''','histogramData', '''',  '->', '''', group, '''', '->', '''', name, '''', '->>', num2str(bin_arr(i)), ')::', data_type];
    line_str = sprintf('%s,\n', line_str);
    Query_str = [Query_str, line_str];
   
end

    line_str = ['(meta->', '''', 'content', '''', '->0->', '''','histogramData', '''',  '->', '''', group, '''', '->', '''', name, '''', '->>', num2str(bin_arr(length(bin_arr))), ')::', data_type];
    line_str = sprintf('%s\n', line_str);
    Query_str = [Query_str, line_str];    

    line_str = 'FROM reports';
    line_str = sprintf('%s\n', line_str);
    Query_str = [Query_str, line_str];
    
    line_str = ['WHERE meta @>', '''', '{"content":[{"histogramData":{ "', group, '":{ "', name, '":[]}}}]}',''''];
    line_str = sprintf('%s\n', line_str);
    Query_str = [Query_str, line_str];
    
    line_str = ['AND (meta->','''', 'content', '''', '->0->>', '''', 'anyModeWithTrackedHandsFrameCount', '''', ')::', data_type, ' <> 0']; 
    line_str = sprintf('%s\n', line_str);
    Query_str = [Query_str, line_str];
    
    line_str = 'ORDER BY id DESC';
    line_str = sprintf('%s\n', line_str);
    Query_str = [Query_str, line_str];
    
    line_str = ['LIMIT ', num2str(num_of_lines)];
    Query_str = [Query_str, line_str];
end

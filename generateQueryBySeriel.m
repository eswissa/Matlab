
function Query_str = generateQueryBySeriel(group, name, bin_arr, data_type, num_of_lines)

line_str = 'SELECT serial,';
Query_str = sprintf('%s\n', line_str);
line_str = [Query_str, 'count(*),'];
Query_str = sprintf('%s\n', line_str);

for i=1:length(bin_arr)-1
    
    line_str = ['sum((meta->', '''', 'content', '''', '->0->', '''','histogramData', '''',  '->', '''', group, '''', '->', '''', name, '''', '->>', num2str(bin_arr(i)), ')::', data_type, ')'];
    line_str = sprintf('%s,\n', line_str);
    Query_str = [Query_str, line_str];
   
end

    line_str = ['sum((meta->', '''', 'content', '''', '->0->', '''','histogramData', '''',  '->', '''', group, '''', '->', '''', name, '''', '->>', num2str(bin_arr(length(bin_arr))), ')::', data_type, ')'];
    line_str = sprintf('%s\n', line_str);
    Query_str = [Query_str, line_str];    

    line_str = 'FROM (';
    line_str = sprintf('%s\n', line_str);
    Query_str = [Query_str, line_str];
    
    line_str = 'SELECT';
    line_str = sprintf('%s\n', line_str);
    Query_str = [Query_str, line_str];
    
    line_str = 'serial,';
    line_str = sprintf('%s\n', line_str);
    Query_str = [Query_str, line_str];
    
    line_str = ['meta from reports where meta @>', '''', '{"content": [{"histogramData":{"', group, '":{"', name, '":[]}}}] }', '''',];
    line_str = sprintf('%s\n', line_str);
    Query_str = [Query_str, line_str];
    
    line_str = ['AND (meta->','''', 'content', '''', '->0->>', '''', 'anyModeWithTrackedHandsFrameCount', '''', ')::', data_type, ' <> 0']; 
    line_str = sprintf('%s\n', line_str);
    Query_str = [Query_str, line_str];
 
    line_str = ['ORDER BY id DESC LIMIT ', num2str(num_of_lines)];
    line_str = sprintf('%s\n', line_str);
    Query_str = [Query_str, line_str];
    
    line_str = ') inner_query_result';
    line_str = sprintf('%s\n', line_str);
    Query_str = [Query_str, line_str];
    
    line_str = 'GROUP BY 1';
    Query_str = [Query_str, line_str];
end



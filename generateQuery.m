function Query_str = generateQuery(group, name, bin_arr)

Query_str = 'SELECT';
Query_str = sprintf('%s\n', Query_str);
Query_str = [Query_str, 'meta->', '''', 'content', '''', '->0->>', '''', 'id', '''', ','],
Query_str = sprintf('%s\n', Query_str);

for i=1:length(bin_arr)
    
    %line_str = strcat('(meta->', '''','content','''','->0->','''','histogramData','''','->','''',group,'''','->', '''',name,'''','->>', num2str(bin_arr(i)),')::int,')
    line_str = ['(meta->', '''', 'content', '''', '->0->', '''','histogramData', '''',  '->', '''', group, '''', '->', '''', name, '''', '->>', num2str(bin_arr(i)), ')::int'];
    if(i == length(bin_arr))
        line_str = sprintf('%s\n', line_str);
    else
        line_str = sprintf('%s,\n', line_str);
    end
    
    Query_str = [Query_str, line_str];
   
end

    line_str = 'FROM reports'
    line_str = sprintf('%s\n', line_str);
    Query_str = [Query_str, line_str];
    
    line_str = ['WHERE meta @>', '''', '{"content":[{"histogramData":{ "', group, '":{ "', name, '":[]}}}]}',''''];
    line_str = sprintf('%s\n', line_str);
    Query_str = [Query_str, line_str];
    
    line_str = ['AND (meta->','''', 'content', '''', '->0->>', '''', 'anyModeWithTrackedHandsFrameCount', '''', ')::int <> 0']; 
    line_str = sprintf('%s\n', line_str);
    Query_str = [Query_str, line_str];
    
    line_str = 'ORDER BY id DESC '
    line_str = sprintf('%s\n', line_str);
    Query_str = [Query_str, line_str];
    
    line_str = 'LIMIT 15000';
    Query_str = [Query_str, line_str];
end

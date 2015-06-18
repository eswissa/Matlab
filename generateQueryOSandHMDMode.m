function Query_str = generateQueryOSandHMDMode()

Query_str = [];

line_str = ['SELECT'];
line_str = sprintf('%s\n', line_str);
Query_str = [Query_str, line_str];

line_str = ['to_char(activity_time::date, ', '''', 'IYYY_IW', '''', ') as ISO_year_week'];
line_str = sprintf('%s,\n', line_str);
Query_str = [Query_str, line_str];

line_str = ['CASE'];
line_str = sprintf('%s\n', line_str);
Query_str = [Query_str, line_str];

os_string_arr = {'mac', 'window', 'linux'};
for i=1:3
    line_str = ['WHEN (lower(os_version) LIKE ', '''', os_string_arr{i}, '%', '''', ') THEN ', '''', 'Mac', ''''];
    line_str = sprintf('%s,\n', line_str);
    Query_str = [Query_str, line_str];
end

line_str = ['ELSE ', '''', 'other', ''''];
line_str = sprintf('%s\n', line_str);
Query_str = [Query_str, line_str];

line_str = [' END AS platformn'];
line_str = sprintf('%s,\n', line_str);
Query_str = [Query_str, line_str];

line_str = ['COUNT(DISTINCT serial_number)'];
line_str = sprintf('%s\n', line_str);
Query_str = [Query_str, line_str];

line_str = ['FROM device_activity_tracking AS d'];
line_str = sprintf('%s\n', line_str);
Query_str = [Query_str, line_str];

line_str = ['WHERE event_type IN (', '''', 'changed to hmd mode', '''', ')'];
line_str = sprintf('%s,\n', line_str);
Query_str = [Query_str, line_str];

line_str = ['GROUP BY 1,2'];
line_str = sprintf('%s,\n', line_str);
Query_str = [Query_str, line_str];

line_str = ['ORDER BY 1,2;'];
Query_str = [Query_str, line_str];

end


%SELECT
%to_char(activity_time::date, 'IYYY_IW') as ISO_year_week,
%CASE
%   WHEN (lower(os_version) LIKE 'mac%') THEN 'Mac' 
%   WHEN (lower(os_version) LIKE 'windows%') THEN 'Windows' 
%   WHEN (lower(os_version) LIKE 'linux%') THEN 'Linux'
%   ELSE 'other'
% END AS platform,
%count(distinct serial_number)
%FROM device_activity_tracking AS d
%--WHERE event_type IN ('changed to hmd mode')
%GROUP BY 1,2
%ORDER BY 1,2;
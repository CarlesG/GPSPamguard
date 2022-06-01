function e = tableExists(con, tableName)

% function e = tableExists(con, tableName)
% return true if the table exists in connection con

e = 0;
try
    dbmeta = dmd(con);
    t = tables(dbmeta,'');
catch
    return
end

n = size(t,1);
for i = 1:n
     tt = t{i,1};
    if strcmp(lower(tt),lower(tableName)) == 1
        e = 1;
        return;
    end
end


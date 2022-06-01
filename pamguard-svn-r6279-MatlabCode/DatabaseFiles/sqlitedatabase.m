function con = sqlitedatabase(fn)
% function con = sqlitedatabase(fn)
% Directly open a SQLite database for use in Matlab.
% fn is an SQLite database file.
%
% to use this function you will need to first download the sqlite-jdbc
% interface version sqlite-jdbc-3.8.11.1.jar or later. This is currently
% available from https://bitbucket.org/xerial/sqlite-jdbc/downloads.
% You wil then need to add the jar file to your Matlab Java class path
% or put it in a folder somewhere in your 'normal' Matlab path and
% it will be loaded dynamically as needed.

% first thing to check is if the database file even exists.  If it doesn't,
% let the user know.
%
% Note that this is not foolproof, because Matlab searches through it's
% entire path for the file.  Unfortunately, the database functions don't.
% The database function used to establish a connection to the database
% requires a URL to the file.  If you just use a filename with no
% explicit path, Matlab may search for (and maybe even create a blank)
% database in the user's home directory.  This will happen even when the
% real database is on the Matlab path and in the current Matlab directory.
%
% So even if this check returns true, it doesn't mean that the database
% function will work properly.  But it's still a good first test.
if (~isfile(fn))
    fprintf('Warning - %s was not found.  We recommend using the FULL PATH in your filename\n',fn);
    con=0;
    return;
end

% declare the driver and protocl needed to open the database.
driver = 'org.sqlite.JDBC';
protocol = 'jdbc:sqlite:';

% these lines can be removed if the driver class is already
% added permanently to your class path.
% need to see if the class is available, in which case
% we won't need to load it.
try
    javaObjectEDT(driver)
catch
    % if an exception was thrown, try to load the library.
    % this will always happen the first time the function is called. 
    driverClassPath = 'sqlite-jdbc-3.14.2.jar';
    jarFile = which(driverClassPath);
    javaaddpath(jarFile);
end

% now open the database.
con = database('','','',driver, [protocol fn]);
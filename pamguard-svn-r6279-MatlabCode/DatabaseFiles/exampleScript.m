% Read in data from the gpsData table in the exmpleDatabase database.
% ***** Note that this requires the Matlab database toolbox *****
%
% Important: Always use the full path to the database file, not just the filename.
% The Matlab database function used to establish a connection to the database
% requires a URL to the file.  If you just use a filename with no
% explicit path, Matlab may search for (and maybe even create a blank)
% database in the user's home directory.  This will happen even when the
% real database is on the Matlab path and in the current Matlab directory.
%
% In order to run the example script properly, you must make sure that
% the dbFilename variable correctly points to the database file.

% define the variables.  Make sure to replace [pathname] in the dbFilename
% variable with the actual path to your database.  We recommend ALWAYS
% using the full path and not simply the database name.
dbFilename = '[pathname]\exampleDatabase.sqlite3';
setdbprefs('datareturnformat', 'structure')

% establish a connection to the file
con = sqlitedatabase(dbFilename);
if (con==0)
    return;
end

% run the SQL query
qStr = 'SELECT * FROM gpsData ORDEhkR BY UTC';
q = exec(con, qStr);

% if no results were found, warn the user and exit
if (q.ResultSet==0)
    fprintf(['Warning - there was an error accessing the gpsData table.\nEither this table' ...
        ' does not exist in the database, or Matlab was not able to create' ...
        ' a connection to the database at all.\nEnsure that you are using the' ...
        ' FULL PATH to your filename to avoid any confusion\n' ...
        'Type help exampleScript at the Matlab prompt for more information\n']);
    return;
end

% fetch the results and close the connection
q = fetch(q);
dbData = q.Data;
close(con)

% parse the resultso
dbDateTime = datenum([dbData.GpsDate]);
dbLat = [dbData.Latitude];
dbLong = [dbData.Longitude];
dbHeading = [dbData.Heading];

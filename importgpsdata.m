% SCRIPT FOR IMPORT DATA FROM PAMGUARD DATABASE IN SQLITE FORMAT
% Script that save in a .mat in the path that we introduce, the GPS data, with time stamps
% If there isn't a database file, pop up an error window
%	INTPUT
%	------
%		* directory: we introduce via ui the path where is the .sqlite3 file.
%	OUTPUT
%	------		 
%		* .mat file with the same name that the database file.
%       * GPSdata.csv file with two columns: Latitud and Longitud
%% GET THE DIRECTORY OF THE DATABASE FILE

pathname = uigetdir('','Choose a calibration folder containing the *.sqlite3 files...');
dbfilename = dir([pathname filesep '*.sqlite3']);
if ~isempty(dbfilename)
    disp(['Loaded directory of the file ' pathname])

    % Adding to the path the database functions implemented by PAMGUARD
    % IMPORTANT: change this line with the directory path folder where are all the database functions

    %addpath('E:\Users\cargall2\ImportGPSData\pamguard-svn-r6279-MatlabCode')
    addpath('C:\Users\MSI\GPSPamguard\pamguard-svn-r6279-MatlabCode\DatabaseFiles')
    setdbprefs('datareturnformat', 'structure') 

    % Establish a connection to the file
    con = sqlitedatabase([dbfilename.folder filesep dbfilename.name]);
   
    if con == 0
	    return;
    end

    % Run the SQL query
    qStr = 'SELECT * FROM gpsData ORDER BY UTC';
    q = exec(con, qStr');
    if(q.ResultSet==0)
	    fprintf('Error accessing the databa');
	    return;
    end
    
    % Fetch the results and close the connection
    q = fetch(q);
    dbData = q.Data;	

    % Save the GPS data in a .mat file
    save([pathname filesep dbfilename.name(1:end-8) '.mat'], 'dbData')
    disp('Save GPS data on the path directory')
    dbLat = [dbData.Latitude];
    dbLong = [dbData.Longitude];
    geoplot(dbLat, dbLong, '--')
    geobasemap topographic
    T = table(dbLat, dbLong);
    writetable(T, [pathname filesep 'GPSdata.csv'], 'Delimiter', ';');
else
    f = errordlg('File not found','File Error');
    return;
end

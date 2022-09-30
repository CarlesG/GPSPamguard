%% Script to load data from Click Events and its localizations, and represent it on a map

%% Loading the data from specific path of the database

pathname = uigetdir('','Choose a calibration folder containing the *.sqlite3 files...');
dbfilename = dir([pathname filesep '*.sqlite3']);
if ~isempty(dbfilename)
    disp(['Loaded directory of the file ' pathname])

    % Adding to the path the database functions implemented by PAMGUARD
    % IMPORTANT: change this line with the directory path folder where are all the database functions

    addpath('E:\Users\cargall2\ImportGPSData\pamguard-svn-r6279-MatlabCode\DatabaseFiles')
    %addpath('C:\Users\MSI\GPSPamguard\pamguard-svn-r6279-MatlabCode\DatabaseFiles')

    setdbprefs('datareturnformat', 'structure') 

    % Establish a connection to the file
    con = sqlitedatabase([dbfilename.folder filesep dbfilename.name]);
   
    if con == 0
	    return;
    end
    % Save the Click Detector Offline Events, for localization information
    % in a .mat file
    qStr = 'SELECT * FROM Click_Detector_OfflineEvents ORDER BY Id';
    q = exec(con, qStr');
    if(q.ResultSet==0)
	    fprintf('Error accessing the database');
	    return;
    end
    q = fetch(q);
    ClickEvent = q.Data;
    save([pathname filesep 'ClickEvent' '.mat'], 'ClickEvent');
else
    f = errordlg('File not found','File Error');
    return;
end

%% Reading the filename for the Localization events

try
    filename = [ pathname filesep 'ClickEvent' '.mat']
    disp(filename)
    load(filename)
catch
    f = errordlg('File not found');
    return
end

%% Finding and plotting Localization Events 

% Filtering events
prompt = 'Type of the event?: ';
type = input(prompt,'s');
% index = ClickEvent.Id(not(strcmpi(ClickEvent.TMModelName1,'')));
index = ClickEvent.Id(not(strcmpi(ClickEvent.TMModelName1,'')) & strcmpi(ClickEvent.eventType,type));
number_index = numel(index)
tma_lat = ClickEvent.TMLatitude1(index);
tma_lon = ClickEvent.TMLongitude1(index);
tma_time = ClickEvent.UTC(index);

% Load the GPS data from path
file_gps = dir([pathname filesep '*gps.mat']);
load([file_gps.folder filesep file_gps.name]);
transect_1 = geoplot(dbData.Latitude, dbData.Longitude,'LineWidth', 2), hold on;
geobasemap satellite
for i = 1:numel(tma_lon)
    geoplot(tma_lat(i), tma_lon(i),'Marker','x',MarkerSize = 12), hold on
end
title( [type 'localization points'])
geoplot(median(tma_lat), median(tma_lon),'Marker','o', 'Linewidth',2)
hold off

% Representation of the median localization point of the type event selected
fprintf('Median Latitude: %0.4f\n', median(tma_lat))
fprintf('Median Longitude: %0.4f\n', median(tma_lon))


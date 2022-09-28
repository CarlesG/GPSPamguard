%% Script to load data from Click Events and its localizations, and represent it on a map

% Load the data from specific path
try
    pathname = uigetdir('',  'Choose a folder containing the Click Event data...');
    filename = [pathname filesep 'ClickEvent.mat'];
    disp(filename)
    load(filename)
catch
    f = errordlg('File not found');
    return
end

load(filename)

% Finding all the events calculated with the TMA. We save the date and time, the latitude and Longitude
index = ClickEvent.Id(not(strcmpi(ClickEvent.TMModelName1,'')))
number_index = numel(index)

tma_lat = ClickEvent.TMLatitude1(index);
tma_lon = ClickEvent.TMLongitude1(index);
tma_time = ClickEvent.UTC(index);

% Load the GPS data from pathf
[file, path] = uigetfile('*.mat','Load the GPS data from .mat');
load([path file])
transect_1 = geoplot(dbData.Latitude, dbData.Longitude,'LineWidth', 2), hold on;
geobasemap satellite
for i = 1:numel(tma_lon)
    geoplot(tma_lat(i), tma_lon(i),'Marker','x',MarkerSize = 12), hold on
end
% title('Spermwhale localization points 27052022')
    geoplot(median(tma_lat), median(tma_lon),'Marker','o', 'Linewidth',2)
hold off


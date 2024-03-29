%% Script for represent the latitud and longitud of the transect points
% RESULTS
% ----------
% dbData: data structure from de GPSdata table of sqlite3 datase from 
% PAMGUARD'S database.
% Also represents the transect, with initial and final point, in two manners
%---------------------------------------------------------------------

% Load database .mat data from script importgpsdata.m
% load('F:\PROJECTE LIFE\Arxius fondeig\220526\220526.mat')
paso = 10;
aux = 1:paso:numel(dbData.Latitude);
ix = cell(length(aux)-1);
load('F:\PROJECTE LIFE\Arxius fondeig\220527\220627.mat')
step = 10;
initial = 1:step:numel(dbData.Latitude);
ix = cell(length(initial)-1);
ix{1} = 1:step;


for i = 2:length(initial)-1
    ix{i} = initial(i) + 1 : initial(i+1);
end

% Another method to do the index vectors without for loop
% index_ini = 1:step:numel(dbData.Latitude) 
% index_end = index_ini + (step - 1)

ctab = hot(length(ix));
for i = 1:length(ix)
    geoplot(dbData.Latitude(ix{i}), dbData.Longitude(ix{i}),'Color',ctab(i,:)), hold on
end

%% Another interactive map visualization
% We represent in an interactive map, the transect and the markers
% of the start and end point. Also we put the latitude and longitude gs
% coordinates.
%-------------------------------------------------------------------

% For represent the transect with Latitude and Longitude data
wmclose("all") 
w2 = webmap("World Imagery");
wmline(dbData.Latitude, dbData.Longitude,'LineWidth',1,'Color','r','FeatureName','Transect','Alpha',0.99)
zoomLevel = 9;


% For represent the starting and ending point of the transect
name_start = 'Start point';
name_end = 'End point';
wmmarker(dbData.Latitude(1),dbData.Longitude(1),'Description',[num2str(dbData.Latitude(1)),', ',num2str(dbData.Longitude(1))],'FeatureName','Start Point')
wmmarker(dbData.Latitude(end),dbData.Longitude(end),'Description',[num2str(dbData.Latitude(end)),', ',num2str(dbData.Longitude(end))],'FeatureName','End Point')
wmzoom(w2,zoomLevel)
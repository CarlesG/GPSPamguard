%% Script for represent the latitud and longitud of the transect points
% PARAMETERS
% ----------
% dbData: data structure from de GPSdata table of sqlite3 datase from 
% PAMGUARD'S database.

% Load database .mat data from script importgpsdata.m
load('F:\PROJECTE LIFE\Arxius fondeig\220527\database220627.mat')
paso = 10;
aux = 1:paso:numel(dbData.Latitude);
ix = cell(length(aux)-1);
ix{1} = 1:paso;
for i = 2:length(aux)-1
    ix{i} = aux(i) + 1 : aux(i+1);
end
ctab = hot(length(ix));
for i = 1:length(ix)
    geoplot(dbData.Latitude(ix{i}), dbData.Longitude(ix{i}),'Color',ctab(i,:)), hold on
end

%% Another interactive map visualization
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
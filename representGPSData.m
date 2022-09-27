%% Script for represent the latitud and longitud of the transect points
% RESULTS
% ----------
% dbData: data structure from de GPSdata table of sqlite3 datase from 
% PAMGUARD'S database.
% Also represents the transect, with initial and final point, in two manners
%---------------------------------------------------------------------

% Load database .mat data from script importgpsdata.m

load('G:\PROJECTE LIFE\Arxius fondeig\220527\220627.mat')
paso = 10;
aux = 1:paso:numel(dbData.Latitude);
ix = cell(length(aux)-1);
%load('F:\PROJECTE LIFE\Arxius fondeig\220527\database220627.mat')
step = 10;
initial = 1:paso:numel(dbData.Latitude);
ix = cell(length(initial)-1);
ix{1} = 1:paso;
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

%% Represent both days in the transects in the same geoplot
figure(2),clf(2)
deployment_point = [37.483616 -1.089166]; % Data needed for the deployment point of the SAMARUC system
transect_1 = geoplot(dbData1.Latitude, dbData1.Longitude,'LineWidth', 2), hold on
point_start = geoplot(dbData1.Latitude(1), dbData1.Longitude(1),'pr','MarkerSize',12,'MarkerfaceColor','#EDB120'), hold on
point_end = geoplot(dbData1.Latitude(end), dbData1.Longitude(end),'vy','MarkerSize',9,'MarkerfaceColor','#EDB120'), hold on
transect_2 = geoplot(dbData2.Latitude, dbData2.Longitude,'LineWidth', 2,'Color','#A2142F')
% dep_point = geoplot(deployment_point(1), deployment_point(2),'h','MarkerSize',10,'MarkerfaceColor',	'#77AC30')
geoplot(dbData2.Latitude(1), dbData2.Longitude(1),'pr','MarkerSize',12,'MarkerfaceColor','#EDB120'), hold on
geoplot(dbData2.Latitude(end), dbData2.Longitude(end),'vy','MarkerSize',9,'MarkerfaceColor','#EDB120'), hold on
legend([transect_1, transect_2, point_start, point_end],{'Transects 220526','Transects 220527','Start Point','End Point'})
% legend([transect_1, transect_2, point_start, point_end, dep_point],{'Transects 220526','Transects 220527','Start Point','End Point','Deployment Point'})
%geobasemap satellite
%
geobasemap satellite
% geobasemap topographic
% geobasemap streets

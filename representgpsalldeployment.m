%% Represent both days in the transects in the same geoplot
% This script is made for respresent the deployment of two days (or two
% transects), with a point of deployment.
figure

% load each day data, and save Latitude and Longitude for each one
[file1, path1] = uigetfile('*.mat','Select first day .mat gps coordinates');
load([path1 file1])
dbData1 = dbData;
[file2, path2] = uigetfile('*.mat','Select second dat .mat gps corrdinates');
load([path2 file2])
dbData2 = dbData;


deployment_point = [37.483616 -1.089166]; % Data needed for the deployment point of the SAMARUC system
transect_1 = geoplot(dbData1.Latitude, dbData1.Longitude,'LineWidth', 2), hold on;
point_start = geoplot(dbData1.Latitude(1), dbData1.Longitude(1),'pr','MarkerSize',12,'MarkerfaceColor','#EDB120'), hold on;
point_end = geoplot(dbData1.Latitude(end), dbData1.Longitude(end),'vy','MarkerSize',9,'MarkerfaceColor','#EDB120'), hold on;
transect_2 = geoplot(dbData2.Latitude, dbData2.Longitude,'LineWidth', 2,'Color','#A2142F'), hold on;
dep_point = geoplot(deployment_point(1), deployment_point(2),'h','MarkerSize',10,'MarkerfaceColor',	'#77AC30');
geoplot(dbData2.Latitude(1), dbData2.Longitude(1),'pr','MarkerSize',12,'MarkerfaceColor','#EDB120'), hold on;
geoplot(dbData2.Latitude(end), dbData2.Longitude(end),'vy'  ,'MarkerSize',9,'MarkerfaceColor','#EDB120'), hold on;
% legend([transect_1, transect_2, point_start, point_end],{'Transects 220526','Transects 220527','Start Point','End Point'})
legend([transect_1, transect_2, point_start, point_end, dep_point],{'Transects 220526','Transects 220527','Start Point','End Point','Deployment Point'});
%geobasemap satellite

geobasemap satellite
% geobasemap topographic
% geobasemap streets
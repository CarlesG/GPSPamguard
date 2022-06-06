% Script for represent the latitud and longitud of the transect points
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

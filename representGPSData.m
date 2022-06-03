% Script para representar los datos en el mapa con una línea con diferentes
% colores. Esto tendríamos que parametrizarlo un poco mejor para que sea
% más automático
load('F:\PROJECTE LIFE\Arxius fondeig\220527\database220627.mat')
paso = 10;
aux = 1:paso:numel(dbData.Latitude);
%ix = cell(length(aux)-1)
ix = cell(length(aux)-1);
ix{1} = 1:paso;
for i = 2:length(aux)-1
    %aux(i)+1;
    %aux(i+1);
    ix{i} = aux(i) + 1 : aux(i+1);
end
% ix = { 1:1001, 1002:2001, 2002:3001, 3001:4001, 4002:5001, 5002:6001, 6002:7001, 7002:8001, 8002:9001, 9002:10001, 10002:11001}
ctab = hot(length(ix));
for i = 1:length(ix)
    geoplot(dbData.Latitude(ix{i}), dbData.Longitude(ix{i}),'Color',ctab(i,:)), hold on
end

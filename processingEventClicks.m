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

% Finding all the Event calculated with the TMA.

index = ClickEvent.Id(not(strcmpi(ClickEvent.TMModelName1,'')))
number_index = numel(index)

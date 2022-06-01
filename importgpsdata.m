%% SCRIPT FOR IMPORT DATA FROM PAMGUARD DATABASE IN SQLITE FORMAT


%% GET THE DIRECTORY OF THE DATABASE FILE

PathName = uigetdir('','Choose a calibration folder containing the *.sqlite3 files...');
res = dir([PathName filesep '*.sqlite3']);
if ~isempty(res)
    disp(['Loaded directory of the file ' PathName])
    
else
    f = errordlg('File not found','File Error');
    return;
end


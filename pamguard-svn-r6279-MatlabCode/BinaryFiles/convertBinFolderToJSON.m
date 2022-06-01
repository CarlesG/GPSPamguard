function convertBinFolderToJSON()

% Converts an entire folder (and subfolders) worth of binary files to json
% files.  The events in each binary folder will be converted into a json
% format and then saved into a text file that has the same name as the
% original binary, but with '_json.txt' appended.  A json file will also be
% created with the contents of the binary file headers/footers, and saved
% with a filename the same as the original but with '_fileInfo_json.txt'
% appended.
%
% Note that this is a pretty slow process, and can take up a fair bit of
% space.  For the Click Detector binaries I tested with, the resulting json
% file are approx 20x larger than the original binary.  So make sure you've
% got plenty of space on your drive if you're doing a lot of files.
%

path = uigetdir(pwd, 'Please select the Folder containing the binary files');
searchPath = [path '\**\*.pgdf'];

% Get a directory structure of all pgdf files in that folder/subfolders
dirStruct = dir(searchPath);
numFiles = length(dirStruct);
fprintf ('%d pgdf files found\n',numFiles);
fprintf ('     working...');

numConverted = 0;

% Loop over all files using the directory structure
for i=1:length(dirStruct)
    pathAndFile = fullfile(dirStruct(i).folder,dirStruct(i).name);
    try
        
        % first create a json file containing just the information from the
        % headers and footers.  Also, to make it easier later, convert the
        % dataDate and analysisDate fields in the fileHeader to a
        % human-readable format and save as extra fields
        [~, fileInfo] = loadPamguardBinaryFile(pathAndFile);
        merged1 = fileInfo.fileHeader;
        dateSerial = merged1.dataDate;
        merged1.dataDateReadable = datestr(dateSerial,'mmmm dd yyyy HH:MM:SS.FFF');
        dateSerial = merged1.analysisDate;
        merged1.analysisDateReadable = datestr(dateSerial,'mmmm dd yyyy HH:MM:SS.FFF');
        merged2 = mergeStructs(merged1,fileInfo.moduleHeader,'moduleHeader');
        merged3 = mergeStructs(merged2,fileInfo.moduleFooter,'moduleFooter');
        merged4 = mergeStructs(merged3,fileInfo.fileFooter,'fileFooter');
        
        [filepath,name,ext] = fileparts(pathAndFile);
        outputFile = fullfile(filepath,[name '_fileInfo_json.txt']);

        merged4.filePath = filepath;
        merged4.fileName = [name '.pgdf'];
        jsonTxt = jsonencode(merged4);
        
        fileID = fopen(outputFile,'w');
        fprintf(fileID,'%s\n',jsonTxt);
        fclose(fileID);

        
        % now convert all of the events within the file
        convertBinToJSON(pathAndFile, false);
        numConverted=numConverted+1;
        fprintf('.');
        
    catch ME
        fprintf('\n%s not converted - error code %s\n',dirStruct(i).name, ME.identifier)
    end
end

fprintf ('\n%d pgdf files converted\n',numConverted) 

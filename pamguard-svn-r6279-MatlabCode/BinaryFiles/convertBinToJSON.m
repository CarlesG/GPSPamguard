function convertBinToJSON(fileName, saveFileInfo)
%
% Converts a binary file to a JSON-formatted text file.  Each object in the
% binary will become a line in the output file.  The output filename will
% be the same as the input, with '_json.txt' appended to the end
%
% Input Arguments:
%   fileName - the full path/name of the pgdf file to convert
%   saveFileInfo (optional) - a boolean indicating whether to append the file/module
%   headers and footers to the event or not.  True indicates yes, False
%   indicates no.  Note that adding the information greatly increases the
%   size of the output.  If the full info is not appended, then the most
%   relevant info (version numbers, module type/name, etc) is still added.
%   Defaults to false.


% set the format to longG so that we don't save scientific notation
format longG

% if the user has not specified a boolean for the second argument, set it
% to false
if nargin < 2
    saveFileInfo = false;
end

% load the dataset and set up the output file
[dataSet, fileInfo] = loadPamguardBinaryFile(fileName);
numEvents = length(dataSet);
[filepath,name,ext] = fileparts(fileName);
outputFile = fullfile(filepath,[name '_json.txt']);
fileID = fopen(outputFile,'w');

% loop through the events one at a time.  
for i=1:numEvents
    event = dataSet(i);
    
    % convert the date into human-readable format
    dateSerial = event.date;
    event.dateReadable = datestr(dateSerial,'mmmm dd yyyy HH:MM:SS.FFF');
    
    if (saveFileInfo)
        % merge the other structures into this one and convert to JSON
        merged1 = mergeStructs(event,fileInfo.fileHeader,'fileHeader');
        merged2 = mergeStructs(merged1,fileInfo.moduleHeader,'moduleHeader');
        merged3 = mergeStructs(merged2,fileInfo.moduleFooter,'moduleFooter');
        merged4 = mergeStructs(merged3,fileInfo.fileFooter,'fileFooter');
        
    else
        % just save important info from the headers/footers to the event
        merged4 = event;
        merged4.filePath = filepath;
        merged4.fileName = [name '.pgdf'];
        merged4.moduleType = fileInfo.fileHeader.moduleType;
        merged4.moduleName = fileInfo.fileHeader.moduleName;
        merged4.streamName = fileInfo.fileHeader.streamName;
        merged4.moduleVersion = fileInfo.moduleHeader.version;
        merged4.pamguardVersion = fileInfo.fileHeader.version;
        merged4.fileFormat = fileInfo.fileHeader.fileFormat;
    end
    
    % convert to json and save
    jsonTxt = jsonencode(merged4);
    fprintf(fileID,'%s\n',jsonTxt);
end
fclose(fileID);



end

% April 4, 2022

clear; clc; close all;

baseDir='/glade/campaign/cesm/development/cross-wg/S2S/CESM2/CLIMOLND/';

% just choosing one day/month
% fileList = dir(fullfile(baseDir,'*','*.clm2.rh0.*-03-00000.nc')); 
fileList = dir(fullfile(baseDir,'*','*.clm2.h0.*.nc')); 

icounter=0;
for file={fileList.name}
    icounter=icounter+1;
        fileName=file{1};
        date=extractBetween(fileName,'.clm2.rh0.','.nc');
        fileNameFull=fullfile(baseDir,date,fileName);
        fileNameFull=fileNameFull{:};
        x=size(ncinfo(fileNameFull).Variables,2);
        if x>900 % becasue some files having missing vars, 
                 % only choose the files with a bunch
            display(fileName)
            snow_depth(:,:,icounter)=ncread(fileNameFull,'SNOW_DEPTH');
            tlai(:,:,icounter)=ncread(fileNameFull,'TLAI');
            tsa(:,:,icounter)=ncread(fileNameFull,'TSA');
            npp(:,:,icounter)=ncread(fileNameFull,'NPP');
            h2osoi(:,:,icounter)=ncread(fileNameFull,'H2OSOI',[1 1 1],[Inf Inf 1]);
            dateKeep(icounter)=datetime(date{:}(1:10));
        end
end


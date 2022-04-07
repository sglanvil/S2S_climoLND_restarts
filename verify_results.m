% April 4, 2022

clear; clc; close all;

baseDir='/glade/campaign/cesm/development/cross-wg/S2S/CESM2/CLIMOLND/';

% just choosing one day/month
% fileList = dir(fullfile(baseDir,'*','*.clm2.rh0.*-03-00000.nc')); 
fileList = dir(fullfile(baseDir,'*-02-01-00000','*.clm2.h0.*.nc')); 

icounter=1;
for file={fileList.name}
    fileName=file{1};
    date=extractBetween(fileName,'.clm2.h0.','.nc'); % match wildcard in "fileList"
    fileNameFull=fullfile(baseDir,date,fileName);
    fileNameFull=fileNameFull{:};
    x=size(ncinfo(fileNameFull).Variables,2);
    if x>400 % becasue some files having missing vars, 
             % only choose the files with a bunch
        display(fileName)        
        snow_depth(:,:,icounter:icounter+11)=ncread(fileNameFull,'SNOW_DEPTH');
        tlai(:,:,icounter:icounter+11)=ncread(fileNameFull,'TLAI');
        tsa(:,:,icounter:icounter+11)=ncread(fileNameFull,'TSA');
        npp(:,:,icounter:icounter+11)=ncread(fileNameFull,'NPP');
        h2osoi(:,:,icounter:icounter+11)=ncread(fileNameFull,'H2OSOI',[1 1 1 1],[Inf Inf 1 Inf]);
        t1=datetime(date{:}(1:10));
        t2=dateshift(dateshift(t1,'start','year','next'),'end','month');
        tBounds=t1:t2;
        time(icounter:icounter+11)=tBounds(day(tBounds)==15);
        icounter=icounter+12;
    end
end

printName='/glade/work/sglanvil/CCR/S2S/figures/verify_climoLND';

figure
iplot=0;
for icounter=1:12:length(time)-12
    var1=h2osoi(:,:,icounter:icounter+11);
    var2=h2osoi(:,:,icounter+12:icounter+12+11);
    varDiff=var2-var1;
    varMaxDiff=nanmax((varDiff),[],3);
    iplot=iplot+1;
        subplot(5,4,iplot)
        pcolor(varMaxDiff);
        shading flat;
        caxis([-0.1 0.1]);
end
colorbar
print(printName,'-r300','-dpng');



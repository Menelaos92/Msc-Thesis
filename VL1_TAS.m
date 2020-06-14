clear all

addpath ('C:\Users\Menelaos\Downloads\Thesis\cbrewer')

DIRin=['C:\Users\Menelaos\Downloads\Thesis\Data\']; 
DIRout=['C:\Users\Menelaos\Downloads\Thesis\Data\plots']; 
cd 'C:\Users\Menelaos\Downloads\Thesis\Data\plots\VL1_TAS'

ncid=netcdf.open([DIRin 'VL1_NorESM_2003_2020_TAS_MM.nc'],'NC_NOWRITE');
varid=netcdf.inqVarID(ncid,'tas');
tas=netcdf.getVar(ncid,varid);
netcdf.close(ncid)

ncid=netcdf.open([DIRin 'land_greenland_mask.nc'],'NC_NOWRITE');
    varid=netcdf.inqVarID(ncid,'lat');
    lat=netcdf.getVar(ncid,varid);
    varid=netcdf.inqVarID(ncid,'lon');
    lon=netcdf.getVar(ncid,varid);
    varid=netcdf.inqVarID(ncid,'var81');
    landmask=netcdf.getVar(ncid,varid);
    netcdf.close(ncid)
    
landmask(landmask >= 0.5) = 1;
landmask(landmask < 0.5) = 0;
landmask(landmask == 0) = NaN;

tas = tas.*landmask;
tas_new = squeeze(tas);

%tas_new = tas_new - 272.15;

%monthly to yearly
result = nanmean(reshape(tas_new,402,602,12,18),3);

%to transform to 3D
result = permute(result,[1,2,4,3]);

%finds the mean of each year
mean_result = nanmean(nanmean(result, 1), 2);

%makes the matrix 35x1
mean_result = permute(mean_result,[3,1,2]);

%prepares montly means
mean_month_tas = nanmean(nanmean(tas_new, 1), 2);
mean_month_tas = permute(mean_month_tas, [3,1,2]);

%creates separate means for every month
for i = 1:12:216
   j = mean_month_tas(i,1); 
   jan(i) = j;
end
jan = jan(jan ~= 0);

for i = 2:12:216
   j = mean_month_tas(i,1); 
   feb(i) = j;
end
feb = feb(feb ~= 0);

for i = 3:12:216
   j = mean_month_tas(i,1); 
   mar(i) = j;
end
mar = mar(mar ~= 0);

for i = 4:12:216
   j = mean_month_tas(i,1); 
   apr(i) = j;
end
apr = apr(apr ~= 0);

for i = 5:12:216
   j = mean_month_tas(i,1); 
   may(i) = j;
end
may = may(may ~= 0);

for i = 6:12:216
   j = mean_month_tas(i,1); 
   jun(i) = j;
end
jun = jun(jun ~= 0);

for i = 7:12:216
   j = mean_month_tas(i,1); 
   jul(i) = j;
end
jul = jul(jul ~= 0);

for i = 8:12:216
   j = mean_month_tas(i,1); 
   aug(i) = j;
end
aug = aug(aug ~= 0);

for i = 9:12:216
   j = mean_month_tas(i,1); 
   sep(i) = j;
end
sep = sep(sep ~= 0);

for i = 10:12:216
   j = mean_month_tas(i,1); 
   oct(i) = j;
end
oct = oct(oct ~= 0);

for i = 11:12:216
   j = mean_month_tas(i,1); 
   nov(i) = j;
end
nov = nov(nov ~= 0);

for i = 12:12:216
   j = mean_month_tas(i,1); 
   dec(i) = j;
end
dec = dec(dec ~= 0);

%concatenate months into one matrix
monthly_tas = [jan;feb;mar;apr;may;jun;jul;aug;sep;oct;nov;dec];
monthly_tas = monthly_tas';

ncid=netcdf.open([DIRin 'glmask_geog.nc'],'NC_NOWRITE');
    varid=netcdf.inqVarID(ncid,'lat');
    lat=netcdf.getVar(ncid,varid);
    varid=netcdf.inqVarID(ncid,'lon');
    lon=netcdf.getVar(ncid,varid);
    varid=netcdf.inqVarID(ncid,'var232');
    icemask=netcdf.getVar(ncid,varid);
    netcdf.close(ncid)

fs = 12;
xt = [-60 -40 -20 0];
yt = [50 55 60 65 70 75];


% for i= 1:18
%     year = i;
%     figure
%       hold on; box on
%       set(gca,'FontSize',fs)
%       m_proj('Lambert Conformal Conic','lon',[-65 -10],'lat',[55 85],'rec','on');
%       m_grid('fontsize',fs,'xtick',xt,'ytick',yt,'XaxisLocation','bottom','YaxisLocation','left');
%       m_contour(lon,lat,icemask,[0:1],'color','k','linewidth',1);
%       m_contourf(lon,lat,result(:,:,i),[213:1:333],'LineStyle','none')
%       %caxis([-1,1]);
%       caxis([213,333]);
%       map=cbrewer('div','RdBu',30);
%       %colormap(flipud(map)); %This one inverts the colormap scale
%       colormap(flipud(map)); %This one keeps the colormap scale as in Cbrewer
%       h=colorbar;
%       cbarrow;
%       title(['VL1 Temperature Year ' num2str(year)]); 
%       ylabel(h, {'Kelvin'},'FontSize',fs)
%       m_coast('line','color',[0.7 0.7 0.7])
%       filename = ['map_NorESM_Greenland_VL1_TAS_Year_', num2str(i)];
%       saveas(gcf,  filename, 'png');
%       %print (gcf,'-dpng','-r300',[DIRout '\map_HIRHAM_Greenland_VL1_PR.png'])
% 
% end  

winter = [dec; jan; feb;];
winter = nanmean(winter);
stdev_winter = nanstd(winter);
winter = mean(winter);

summer = [jun; jul; aug;];
summer = nanmean(summer);
stdev_summer = nanstd(summer);
summer = mean(summer);

autumn = [sep; oct; nov;];
autumn = nanmean(autumn);
stdev_autumn = nanstd(autumn);
autumn = mean(autumn);

spring = [mar; apr; may;];
spring = nanmean(spring);
stdev_spring = nanstd(spring);
spring = mean(spring);

%changing units to yearly
stdev = nanstd(mean_result);
mean_result = nanmean(mean_result);

jan = mean(jan);
feb = mean(feb);
mar = mean(mar);
apr = mean(apr);
may = mean(may);
jun = mean(jun);
jul = mean(jul);
aug = mean(aug);
sep = mean(sep);
oct = mean(oct);
nov = mean(nov);
dec = mean(dec);

all_months = [jan;feb;mar;apr;may;jun;jul;aug;sep;oct;nov;dec;];


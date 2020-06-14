clear all

addpath ('C:\Users\Menelaos\Downloads\Thesis\cbrewer')

DIRin=['C:\Users\Menelaos\Downloads\Thesis\Data\']; 
DIRout=['C:\Users\Menelaos\Downloads\Thesis\Data\plots']; 
cd 'C:\Users\Menelaos\Downloads\Thesis\Data\plots\VL1_dlwrad'


ncid=netcdf.open([DIRin 'VL1_NorESM_2003_2020_DLWRAD_MM.nc'],'NC_NOWRITE');
varid=netcdf.inqVarID(ncid,'dlwrad');
dlwrad=netcdf.getVar(ncid,varid);
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

dlwrad_new = squeeze(dlwrad);
dlwrad_new = dlwrad_new.*landmask;

%monthly to yearly
result = nanmean(reshape(dlwrad_new,402,602,12,18),3);

%to transform to 3D
result = permute(result,[1,2,4,3]);

%finds the mean of each year
mean_result = nanmean(nanmean(result, 1), 2);

%makes the matrix 35x1
mean_result = permute(mean_result,[3,1,2]);

%prepares montly means
mean_month_dlwrad = nanmean(nanmean(dlwrad_new, 1), 2);
mean_month_dlwrad = permute(mean_month_dlwrad, [3,1,2]);

%creates separate means for every month
jan = []; 
for i = 1:12:216
   j = dlwrad_new(:,:,i); 
   jan = cat(3, jan, j);
end
feb = [];
for i = 2:12:216
   j = dlwrad_new(:,:,i);
   feb = cat(3, feb, j);
end
mar = [];
for i = 3:12:216
   j = dlwrad_new(:,:,i); 
   mar = cat(3, mar, j);
end
apr = [];
for i = 4:12:216
   j = dlwrad_new(:,:,i); 
   apr = cat(3, apr, j);
end
may = [];
for i = 5:12:216
   j = dlwrad_new(:,:,i); 
   may = cat(3, may, j);
end
jun = [];
for i = 6:12:216
   j = dlwrad_new(:,:,i); 
   jun = cat(3, jun, j);
end
jul = [];
for i = 7:12:216
   j = dlwrad_new(:,:,i);
   jul = cat(3, jul, j);
end
aug = [];
for i = 8:12:216
   j = dlwrad_new(:,:,i);
   aug = cat(3, aug, j);
end
sep = [];
for i = 9:12:216
   j = dlwrad_new(:,:,i); 
   sep= cat(3, sep, j);
end
oct = [];
for i = 10:12:216
   j = dlwrad_new(:,:,i); 
   oct = cat(3, oct, j);
end
nov = [];
for i = 11:12:216
   j = dlwrad_new(:,:,i); 
   nov = cat(3, nov, j);
end
dec = [];
for i = 12:12:216
   j = dlwrad_new(:,:,i); 
   dec = cat(3, dec, j);
end

%concatenate months into one matrix
% winter = cat(3, dec, jan, feb);
% summer = cat(3, jun, jul, aug);

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

%Winter or summer

% for i= 1:18
%     year = i;
%     figure
%       hold on; box on
%       set(gca,'FontSize',fs)
%       m_proj('Lambert Conformal Conic','lon',[-65 -10],'lat',[55 85],'rec','on');
%       m_grid('fontsize',fs,'xtick',xt,'ytick',yt,'XaxisLocation','bottom','YaxisLocation','left');
%       m_contour(lon,lat,icemask,[0:1],'color','k','linewidth',1);
%       m_contourf(lon,lat,summer(:,:,i),[0:5:250],'LineStyle','none')
%       %caxis([-1,1]);
%       caxis([0,250]);
%       map=cbrewer('seq','Blues',30);
%       %colormap(flipud(map)); %This one inverts the colormap scale
%       colormap(map) %This one keeps the colormap scale as in Cbrewer
%       h=colorbar;
%       cbarrow;
%       title(['VL1 dlwrad Year ' num2str(year)]); 
%       ylabel(h, {'[W m-2]'},'FontSize',fs)
%       m_coast('line','color',[0.7 0.7 0.7])
%       filename = ['map_NorESM_Greenland_VL1_dlwrad_Year_', num2str(i)];
%       saveas(gcf,  filename, 'png');
%       %print (gcf,'-dpng','-r300',[DIRout '\map_HIRHAM_Greenland_VL1_PR.png'])
% 
% end  

clear jan feb mar apr may jun jul aug sep oct nov dec;
%creates separate means for every month
for i = 1:12:216
   j = mean_month_dlwrad(i,1); 
   jan(i) = j;
end
jan = jan(jan ~= 0);

for i = 2:12:216
   j = mean_month_dlwrad(i,1); 
   feb(i) = j;
end
feb = feb(feb ~= 0);

for i = 3:12:216
   j = mean_month_dlwrad(i,1); 
   mar(i) = j;
end
mar = mar(mar ~= 0);

for i = 4:12:216
   j = mean_month_dlwrad(i,1); 
   apr(i) = j;
end
apr = apr(apr ~= 0);

for i = 5:12:216
   j = mean_month_dlwrad(i,1); 
   may(i) = j;
end
may = may(may ~= 0);

for i = 6:12:216
   j = mean_month_dlwrad(i,1); 
   jun(i) = j;
end
jun = jun(jun ~= 0);

for i = 7:12:216
   j = mean_month_dlwrad(i,1); 
   jul(i) = j;
end
jul = jul(jul ~= 0);

for i = 8:12:216
   j = mean_month_dlwrad(i,1); 
   aug(i) = j;
end
aug = aug(aug ~= 0);

for i = 9:12:216
   j = mean_month_dlwrad(i,1); 
   sep(i) = j;
end
sep = sep(sep ~= 0);

for i = 10:12:216
   j = mean_month_dlwrad(i,1); 
   oct(i) = j;
end
oct = oct(oct ~= 0);

for i = 11:12:216
   j = mean_month_dlwrad(i,1); 
   nov(i) = j;
end
nov = nov(nov ~= 0);

for i = 12:12:216
   j = mean_month_dlwrad(i,1); 
   dec(i) = j;
end
dec = dec(dec ~= 0);

summer_dlwrad = [jun; jul; aug;]';
summer_dlwrad = nanmean(summer_dlwrad, 2);
summer_dlwrad_std = nanstd(summer_dlwrad)';
summer_dlwrad = nanmean(summer_dlwrad);
summer_dlwrad = summer_dlwrad';

winter_dlwrad = [dec; jan; feb;];
winter_dlwrad = nanmean(winter_dlwrad, 2);
winter_dlwrad_std = nanstd(winter_dlwrad);
winter_dlwrad = nanmean(winter_dlwrad);
winter_dlwrad = winter_dlwrad';

spring_dlwrad = [mar; apr; may];
spring_dlwrad = nanmean(spring_dlwrad, 2);
spring_dlwrad_std = nanstd(spring_dlwrad);
spring_dlwrad = nanmean(spring_dlwrad);
spring_dlwrad = spring_dlwrad';

autumn_dlwrad = [sep; oct; nov];
autumn_dlwrad = nanmean(autumn_dlwrad, 2);
autumn_dlwrad_std = nanstd(autumn_dlwrad);
autumn_dlwrad = nanmean(autumn_dlwrad);
autumn_dlwrad = autumn_dlwrad';

all_seasons = [winter_dlwrad spring_dlwrad summer_dlwrad autumn_dlwrad]';
all_seasons = nanmean(all_seasons, 2);
all_seasons_std = [winter_dlwrad_std spring_dlwrad_std summer_dlwrad_std autumn_dlwrad_std]';
% all_seasons_std = nanmean(all_seasons_std, 2);

monthly_dlwrad = [jan;feb;mar;apr;may;jun;jul;aug;sep;oct;nov;dec];
all_months_dlwrad_std = nanstd(monthly_dlwrad,[],2);

jan = nanmean(jan);
feb = nanmean(feb);
mar = nanmean(mar);
apr = nanmean(apr);
may = nanmean(may);
jun = nanmean(jun);
jul = nanmean(jul);
aug = nanmean(aug);
sep = nanmean(sep);
oct = nanmean(oct);
nov = nanmean(nov);
dec = nanmean(dec);

%concatenate months into one matrix
all_months_dlwrad = [jan;feb;mar;apr;may;jun;jul;aug;sep;oct;nov;dec];


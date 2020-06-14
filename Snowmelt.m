clear all

addpath ('C:\Users\Menelaos\Downloads\Thesis\cbrewer')

DIRin=['C:\Users\Menelaos\Downloads\Thesis\Data\']; 
DIRout=['C:\Users\Menelaos\Downloads\Thesis\Data\plots']; 
cd 'C:\Users\Menelaos\Downloads\Thesis\Data\plots\VL1_SNMELT'

ncid=netcdf.open([DIRin 'VL1_NorESM_2003_2020_SNMELT_MM.nc'],'NC_NOWRITE');
varid=netcdf.inqVarID(ncid,'snmelt');
snmelt=netcdf.getVar(ncid,varid);
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

snmelt = snmelt.*landmask;

snmelt_VL1_new = squeeze(snmelt);

%monthly to yearly
result = nanmean(reshape(snmelt_VL1_new,402,602,12,18),3);

%to transform to 3D
result = permute(result,[1,2,4,3]);

%finds the mean of each year
mean_result = nanmean(nanmean(result, 1), 2);

%makes the matrix 35x1
mean_result = permute(mean_result,[3,1,2]);

%prepares montly means
mean_month_snmelt = nanmean(nanmean(snmelt_VL1_new, 1), 2);
mean_month_snmelt = permute(mean_month_snmelt, [3,1,2]);
mean_month_snmelt = mean_month_snmelt.*30;

%creates separate means for every month
for i = 1:12:216
   j = mean_month_snmelt(i,1); 
   jan(i) = j;
end
jan = jan(jan ~= 0);

for i = 2:12:216
   j = mean_month_snmelt(i,1); 
   feb(i) = j;
end
feb = feb(feb ~= 0);

for i = 3:12:216
   j = mean_month_snmelt(i,1); 
   mar(i) = j;
end
mar = mar(mar ~= 0);

for i = 4:12:216
   j = mean_month_snmelt(i,1); 
   apr(i) = j;
end
apr = apr(apr ~= 0);

for i = 5:12:216
   j = mean_month_snmelt(i,1); 
   may(i) = j;
end
may = may(may ~= 0);

for i = 6:12:216
   j = mean_month_snmelt(i,1); 
   jun(i) = j;
end
jun = jun(jun ~= 0);

for i = 7:12:216
   j = mean_month_snmelt(i,1); 
   jul(i) = j;
end
jul = jul(jul ~= 0);

for i = 8:12:216
   j = mean_month_snmelt(i,1); 
   aug(i) = j;
end
aug = aug(aug ~= 0);

for i = 9:12:216
   j = mean_month_snmelt(i,1); 
   sep(i) = j;
end
sep = sep(sep ~= 0);

for i = 10:12:216
   j = mean_month_snmelt(i,1); 
   oct(i) = j;
end
oct = oct(oct ~= 0);

for i = 11:12:216
   j = mean_month_snmelt(i,1); 
   nov(i) = j;
end
nov = nov(nov ~= 0);

for i = 12:12:216
   j = mean_month_snmelt(i,1); 
   dec(i) = j;
end
dec = dec(dec ~= 0);

%concatenate months into one matrix
monthly_snmelt = [jan;feb;mar;apr;may;jun;jul;aug;sep;oct;nov;dec];
monthly_snmelt = monthly_snmelt';

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

result = result*365;

% for i= 1:18
%     year = i;
%     figure
%       hold on; box on
%       set(gca,'FontSize',fs)
%       m_proj('Lambert Conformal Conic','lon',[-65 -10],'lat',[55 85],'rec','on');
%       m_grid('fontsize',fs,'xtick',xt,'ytick',yt,'XaxisLocation','bottom','YaxisLocation','left');
%       m_contour(lon,lat,icemask,[0:1],'color','k','linewidth',1);
%       m_contourf(lon,lat,result(:,:,i),[1:100:3000],'LineStyle','none')
%       %caxis([-1,1]);
%       caxis([1,3000]);
%       map=cbrewer('seq','Reds',20);
%       %colormap(flipud(map)); %This one inverts the colormap scale
%       colormap(map) %This one keeps the colormap scale as in Cbrewer
%       h=colorbar;
%       cbarrow;
%       title(['VL1 SNMELT Year ' num2str(year)]); 
%       ylabel(h, {'[mm/year]'},'FontSize',fs)
%       m_coast('line','color',[0.7 0.7 0.7])
%       filename = ['map_NorESM_Greenland_VL1_SNMELT_Year ', num2str(i)];
%       saveas(gcf,  filename, 'png');
%       %print (gcf,'-dpng','-r300',[DIRout '\map_HIRHAM_Greenland_VL1_PR.png'])
% 
% end  
% 
% winter = [dec; jan; feb;];
% winter = mean(winter);
% winter = winter';
% 
% summer = [jun;jul;aug;];
% summer = mean(summer);
% summer = summer';
% 
% %changing units to yearly
% mean_result = mean_result.*365;
% stdev = nanstd(mean_result);
% mean_result = nanmean(mean_result);

%%%%%%%%%%%%%%%%%%%% GIGATONNE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nlat = 402; nlon = 602;
Agrid = NaN*zeros(nlat,nlon);
Awidth = NaN*zeros(nlat,nlon);
Aheight = NaN*zeros(nlat,nlon);
Re = 6371; % Earth's mean radius
for ilat = 1:nlat
    for ilon = 1:nlon
        if ilat == 1
            Lat_N = (lat(ilat+1,ilon)+lat(ilat,ilon))/2;
            Lat_S = lat(ilat,ilon)-(Lat_N-lat(ilat,ilon));
            Lon_N = (lon(ilat+1,ilon)+lon(ilat,ilon))/2;
            Lon_S = lon(ilat,ilon)-(Lon_N-lon(ilat,ilon));
        elseif ilat == nlat
            Lat_S = (lat(ilat,ilon)+lat(ilat-1,ilon))/2;
            Lat_N = lat(ilat,ilon)+(lat(ilat,ilon)-Lat_S);
            Lon_S = (lon(ilat,ilon)+lon(ilat-1,ilon))/2;
            Lon_N = lon(ilat,ilon)+(lon(ilat,ilon)-Lon_S);
        else
            Lat_N = (lat(ilat+1,ilon)+lat(ilat,ilon))/2;
            Lat_S = (lat(ilat,ilon)+lat(ilat-1,ilon))/2;
            Lon_N = (lon(ilat+1,ilon)+lon(ilat,ilon))/2;
            Lon_S = (lon(ilat,ilon)+lon(ilat-1,ilon))/2;
        end
        if ilon == 1
            Lon_E = (lon(ilat,ilon+1)+lon(ilat,ilon))/2;
            Lon_W = lon(ilat,ilon)-(Lon_E-lon(ilat,ilon));
            Lat_E = (lat(ilat,ilon+1)+lat(ilat,ilon))/2;
            Lat_W = lat(ilat,ilon)-(Lat_E-lat(ilat,ilon));
        elseif ilon == nlon
            Lon_W = (lon(ilat,ilon)+lon(ilat,ilon-1))/2;
            Lon_E = lon(ilat,ilon)+(lon(ilat,ilon)-Lon_W);
            Lat_W = (lat(ilat,ilon)+lat(ilat,ilon-1))/2;
            Lat_E = lat(ilat,ilon)+(lat(ilat,ilon)-Lat_W);
        else
            Lon_E = (lon(ilat,ilon+1)+lon(ilat,ilon))/2;
            Lon_W = (lon(ilat,ilon)+lon(ilat,ilon-1))/2;
            Lat_E = (lat(ilat,ilon+1)+lat(ilat,ilon))/2;
            Lat_W = (lat(ilat,ilon)+lat(ilat,ilon-1))/2;
        end
        Lat_delta = Lat_N - Lat_S;
        Lon_delta = Lon_N - Lon_S;
        a = (sin(.5*Lat_delta*pi/180))^2 + ...
            cos(Lat_N*pi/180)*cos(Lat_S*pi/180)* ...
            (sin(.5*Lon_delta*pi/180))^2;
        c = 2*atan2(sqrt(a),sqrt(1-a));
        Lat_dist = Re*c;
        
        Lat_delta = Lat_E - Lat_W;
        Lon_delta = Lon_E - Lon_W;
        a = (sin(.5*Lat_delta*pi/180))^2 + ...
            cos(Lat_E*pi/180)*cos(Lat_W*pi/180)* ...
            (sin(.5*Lon_delta*pi/180))^2;
        c = 2*atan2(sqrt(a),sqrt(1-a));
        Lon_dist = Re*c;
        Agrid(ilat,ilon) = Lat_dist*Lon_dist;
        Awidth(ilat,ilon) = Lon_dist;
        Aheight(ilat,ilon) = Lat_dist;
    end
end

Agrid = Agrid.*landmask;
result=result./1000000;
prSumY = NaN*zeros(18,1);
for Year = 1:18
    prSum = reshape(squeeze(result(:,:,Year)),nlat*nlon,1).*reshape(Agrid,nlat*nlon,1);
    prSumY(Year) = sum(prSum(isfinite(prSum)));
end

pr_std = nanstd(prSumY);
prSumY = nanmean(prSumY);

%%%%%%%%%%%%%%%%%%%%%Seasons%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear jan feb mar apr may jun jul aug sep oct nov dec;

jan = []; 
for i = 1:12:216
   j = snmelt_VL1_new(:,:,i); 
   jan = cat(3, jan, j);
end
feb = [];
for i = 2:12:216
   j = snmelt_VL1_new(:,:,i);
   feb = cat(3, feb, j);
end
mar = [];
for i = 3:12:216
   j = snmelt_VL1_new(:,:,i); 
   mar = cat(3, mar, j);
end
apr= [];
for i = 4:12:216
   j = snmelt_VL1_new(:,:,i); 
   apr = cat(3, apr, j);
end
may = [];
for i = 5:12:216
   j = snmelt_VL1_new(:,:,i); 
   may = cat(3, may, j);
end
jun = [];
for i = 6:12:216
   j = snmelt_VL1_new(:,:,i); 
   jun = cat(3, jun, j);
end
jul = [];
for i = 7:12:216
   j = snmelt_VL1_new(:,:,i);
   jul = cat(3, jul, j);
end
aug = [];
for i = 8:12:216
   j = snmelt_VL1_new(:,:,i);
   aug = cat(3, aug, j);
end
sep = [];
for i = 9:12:216
   j = snmelt_VL1_new(:,:,i); 
   sep= cat(3, sep, j);
end
oct = [];
for i = 10:12:216
   j = snmelt_VL1_new(:,:,i); 
   oct = cat(3, oct, j);
end
nov = [];
for i = 11:12:216
   j = snmelt_VL1_new(:,:,i); 
   nov = cat(3, nov, j);
end
dec = [];
for i = 12:12:216
   j = snmelt_VL1_new(:,:,i); 
   dec = cat(3, dec, j);
end

 
jan=jan.*30;
jan=jan./1000000;
snmelt_sum_jan_years = NaN*zeros(18,1);
for Year = 1:18
    snmelt_sum_jan = reshape(squeeze(jan(:,:,Year)),nlat*nlon,1).*reshape(Agrid,nlat*nlon,1);
    snmelt_sum_jan_years(Year) = sum(snmelt_sum_jan(isfinite(snmelt_sum_jan)));
end
jan_std = nanstd(snmelt_sum_jan_years);
jan_snmelt_mean = nanmean(snmelt_sum_jan_years);

feb=feb.*30;
feb=feb./1000000;
snmelt_sum_feb_years = NaN*zeros(18,1);
for Year = 1:18
    snmelt_sum_feb = reshape(squeeze(feb(:,:,Year)),nlat*nlon,1).*reshape(Agrid,nlat*nlon,1);
    snmelt_sum_feb_years(Year) = sum(snmelt_sum_feb(isfinite(snmelt_sum_feb)));
end
feb_std = nanstd(snmelt_sum_feb_years);
feb_snmelt_mean = nanmean(snmelt_sum_feb_years);

mar=mar.*30;
mar=mar./1000000;
snmelt_sum_mar_years = NaN*zeros(18,1);
for Year = 1:18
    snmelt_sum_mar = reshape(squeeze(mar(:,:,Year)),nlat*nlon,1).*reshape(Agrid,nlat*nlon,1);
    snmelt_sum_mar_years(Year) = sum(snmelt_sum_mar(isfinite(snmelt_sum_mar)));
end
mar_std = nanstd(snmelt_sum_mar_years);
mar_snmelt_mean = nanmean(snmelt_sum_mar_years);

apr=apr.*30;
apr=apr./1000000;
snmelt_sum_apr_years = NaN*zeros(18,1);
for Year = 1:18
    snmelt_sum_apr = reshape(squeeze(apr(:,:,Year)),nlat*nlon,1).*reshape(Agrid,nlat*nlon,1);
    snmelt_sum_apr_years(Year) = sum(snmelt_sum_apr(isfinite(snmelt_sum_apr)));
end
apr_std = nanstd(snmelt_sum_apr_years);
apr_snmelt_mean = nanmean(snmelt_sum_apr_years);

may=may.*30;
may=may./1000000;
snmelt_sum_may_years = NaN*zeros(18,1);
for Year = 1:18
    snmelt_sum_may = reshape(squeeze(may(:,:,Year)),nlat*nlon,1).*reshape(Agrid,nlat*nlon,1);
    snmelt_sum_may_years(Year) = sum(snmelt_sum_may(isfinite(snmelt_sum_may)));
end
may_std = nanstd(snmelt_sum_may_years);
may_snmelt_mean = nanmean(snmelt_sum_may_years);

jun=jun.*30;
jun=jun./1000000;
snmelt_sum_jun_years = NaN*zeros(18,1);
for Year = 1:18
    snmelt_sum_jun = reshape(squeeze(jun(:,:,Year)),nlat*nlon,1).*reshape(Agrid,nlat*nlon,1);
    snmelt_sum_jun_years(Year) = sum(snmelt_sum_jun(isfinite(snmelt_sum_jun)));
end
jun_std = nanstd(snmelt_sum_jun_years);
jun_snmelt_mean = nanmean(snmelt_sum_jun_years);

jul=jul.*30;
jul=jul./1000000;
snmelt_sum_jul_years = NaN*zeros(18,1);
for Year = 1:18
    snmelt_sum_jul = reshape(squeeze(jul(:,:,Year)),nlat*nlon,1).*reshape(Agrid,nlat*nlon,1);
    snmelt_sum_jul_years(Year) = sum(snmelt_sum_jul(isfinite(snmelt_sum_jul)));
end
jul_std = nanstd(snmelt_sum_jul_years);
jul_snmelt_mean = nanmean(snmelt_sum_jul_years);

aug=aug.*30;
aug=aug./1000000;
snmelt_sum_aug_years = NaN*zeros(18,1);
for Year = 1:18
    snmelt_sum_aug = reshape(squeeze(aug(:,:,Year)),nlat*nlon,1).*reshape(Agrid,nlat*nlon,1);
    snmelt_sum_aug_years(Year) = sum(snmelt_sum_aug(isfinite(snmelt_sum_aug)));
end
aug_std = nanstd(snmelt_sum_aug_years);
aug_snmelt_mean = nanmean(snmelt_sum_aug_years);

sep=sep.*30;
sep=sep./1000000;
snmelt_sum_sep_years = NaN*zeros(18,1);
for Year = 1:18
    snmelt_sum_sep = reshape(squeeze(sep(:,:,Year)),nlat*nlon,1).*reshape(Agrid,nlat*nlon,1);
    snmelt_sum_sep_years(Year) = sum(snmelt_sum_sep(isfinite(snmelt_sum_sep)));
end
sep_std = nanstd(snmelt_sum_sep_years);
sep_snmelt_mean = nanmean(snmelt_sum_sep_years);

oct=oct.*30;
oct=oct./1000000;
snmelt_sum_oct_years = NaN*zeros(18,1);
for Year = 1:18
    snmelt_sum_oct = reshape(squeeze(oct(:,:,Year)),nlat*nlon,1).*reshape(Agrid,nlat*nlon,1);
    snmelt_sum_oct_years(Year) = sum(snmelt_sum_oct(isfinite(snmelt_sum_oct)));
end
oct_std = nanstd(snmelt_sum_oct_years);
oct_snmelt_mean = nanmean(snmelt_sum_oct_years);

nov=nov.*30;
nov=nov./1000000;
snmelt_sum_nov_years = NaN*zeros(18,1);
for Year = 1:18
    snmelt_sum_nov = reshape(squeeze(nov(:,:,Year)),nlat*nlon,1).*reshape(Agrid,nlat*nlon,1);
    snmelt_sum_nov_years(Year) = sum(snmelt_sum_nov(isfinite(snmelt_sum_nov)));
end
nov_std = nanstd(snmelt_sum_nov_years);
nov_snmelt_mean = nanmean(snmelt_sum_nov_years);

dec=dec.*30;
dec=dec./1000000;
snmelt_sum_dec_years = NaN*zeros(18,1);
for Year = 1:18
    snmelt_sum_dec = reshape(squeeze(dec(:,:,Year)),nlat*nlon,1).*reshape(Agrid,nlat*nlon,1);
    snmelt_sum_dec_years(Year) = sum(snmelt_sum_dec(isfinite(snmelt_sum_dec)));
end
dec_std = nanstd(snmelt_sum_dec_years);
dec_snmelt_mean = nanmean(snmelt_sum_dec_years);


winter = [snmelt_sum_dec_years snmelt_sum_jan_years snmelt_sum_feb_years];
winter = nanmean(winter,2);
winter_std = nanstd(winter);
winter_mean = nanmean(winter);

spring = [snmelt_sum_mar_years snmelt_sum_apr_years snmelt_sum_may_years];
spring = nanmean(spring,2);
spring_std = nanstd(spring);
spring_mean = nanmean(spring);

summer = [snmelt_sum_jun_years snmelt_sum_jul_years snmelt_sum_aug_years];
summer = nanmean(summer,2);
summer_std = nanstd(summer);
summer_mean = nanmean(summer);

autumn = [snmelt_sum_sep_years snmelt_sum_oct_years snmelt_sum_nov_years];
autumn = nanmean(autumn,2);
autumn_std = nanstd(autumn);
autumn_mean = nanmean(autumn);

monthly_means_gt = [jan_snmelt_mean feb_snmelt_mean mar_snmelt_mean apr_snmelt_mean may_snmelt_mean jun_snmelt_mean jul_snmelt_mean aug_snmelt_mean sep_snmelt_mean oct_snmelt_mean nov_snmelt_mean dec_snmelt_mean]';
monthly_means_std = [jan_std feb_std mar_std apr_std may_std jun_std jul_std aug_std sep_std oct_std nov_std dec_std]';

%%%per season%%%
seasonal_means_gt = [winter_mean spring_mean summer_mean autumn_mean]'.*3;
seasonal_std = [winter_std spring_std summer_std autumn_std]'.*3;



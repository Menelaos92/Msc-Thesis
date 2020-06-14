clear all

addpath ('C:\Users\Menelaos\Downloads\Thesis\cbrewer')

DIRin=['C:\Users\Menelaos\Downloads\Thesis\Data\']; 
DIRout=['C:\Users\Menelaos\Downloads\Thesis\Data\plots\Anomaly_plots']; 

cd 'C:\Users\Menelaos\Downloads\Thesis\Data\plots\Anomaly_plots'

ncid=netcdf.open([DIRin 'VL4_NorESM_2002_2040_pr_MM.nc'],'NC_NOWRITE');
varid=netcdf.inqVarID(ncid,'pr');
pr_VL4=netcdf.getVar(ncid,varid);
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

pr_VL4_new = squeeze(pr_VL4);
pr_VL4_new = pr_VL4_new.*landmask;

%monthly to yearly
result_VL4 = nanmean(reshape(pr_VL4_new,402,602,12,21),3);

%to transform to 3D
result_VL4 = permute(result_VL4,[1,2,4,3]);

%finds the mean of each year
mean_result_VL4 = nanmean(nanmean(result_VL4, 1), 2);

%makes the matrix 35x1
mean_result_VL4 = permute(mean_result_VL4,[3,1,2]);

%pr_pr_VL4epares montly means
mean_month_pr_VL4 = nanmean(nanmean(pr_VL4_new, 1), 2);
mean_month_pr_VL4 = permute(mean_month_pr_VL4, [3,1,2]);

%creates separate means for every month
jan = []; 
for i = 1:12:240
   j = pr_VL4_new(:,:,i); 
   jan = cat(3, jan, j);
end
feb = [];
for i = 2:12:240
   j = pr_VL4_new(:,:,i);
   feb = cat(3, feb, j);
end
mar = [];
for i = 3:12:240
   j = pr_VL4_new(:,:,i); 
   mar = cat(3, mar, j);
end
apr= [];
for i = 4:12:240
   j = pr_VL4_new(:,:,i); 
   apr = cat(3, apr, j);
end
may = [];
for i = 5:12:240
   j = pr_VL4_new(:,:,i); 
   may = cat(3, may, j);
end
jun = [];
for i = 6:12:240
   j = pr_VL4_new(:,:,i); 
   jun = cat(3, jun, j);
end
jul = [];
for i = 7:12:240
   j = pr_VL4_new(:,:,i);
   jul = cat(3, jul, j);
end
aug = [];
for i = 8:12:240
   j = pr_VL4_new(:,:,i);
   aug = cat(3, aug, j);
end
sep = [];
for i = 9:12:240
   j = pr_VL4_new(:,:,i); 
   sep= cat(3, sep, j);
end
oct = [];
for i = 10:12:240
   j = pr_VL4_new(:,:,i); 
   oct = cat(3, oct, j);
end
nov = [];
for i = 11:12:240
   j = pr_VL4_new(:,:,i); 
   nov = cat(3, nov, j);
end
dec = [];
for i = 12:12:240
   j = pr_VL4_new(:,:,i); 
   dec = cat(3, dec, j);
end

ncid=netcdf.open([DIRin 'VL1_NorESM_2003_2020_PR_MM.nc'],'NC_NOWRITE');
varid=netcdf.inqVarID(ncid,'pr');
pr_VL1=netcdf.getVar(ncid,varid);
netcdf.close(ncid)

pr_VL1_new = squeeze(pr_VL1);
pr_VL1_new = pr_VL1_new.*landmask;

%monthly to yearly
result_VL1 = nanmean(reshape(pr_VL1_new,402,602,12,18),3);

%to transform to 3D
result_VL1 = permute(result_VL1,[1,2,4,3]);

%finds the mean of each year
mean_result_VL1 = nanmean(nanmean(result_VL1, 1), 2);

%makes the matrix 35x1
mean_result_VL1 = permute(mean_result_VL1,[3,1,2]);

%prepares montly means
mean_month_pr_VL1 = nanmean(nanmean(pr_VL1_new, 1), 2);
mean_month_pr_VL1 = permute(mean_month_pr_VL1, [3,1,2]);

%creates separate means for every month
jan2 = []; 
for i = 1:12:216
   j = pr_VL1_new(:,:,i); 
   jan2 = cat(3, jan2, j);
end
feb2 = [];
for i = 2:12:216
   j = pr_VL1_new(:,:,i);
   feb2 = cat(3, feb2, j);
end
mar2 = [];
for i = 3:12:216
   j = pr_VL1_new(:,:,i); 
   mar2 = cat(3, mar2, j);
end
apr2 = [];
for i = 4:12:216
   j = pr_VL1_new(:,:,i); 
   apr2 = cat(3, apr2, j);
end
may2 = [];
for i = 5:12:216
   j = pr_VL1_new(:,:,i); 
   may2 = cat(3, may2, j);
end
jun2 = [];
for i = 6:12:216
   j = pr_VL1_new(:,:,i); 
   jun2 = cat(3, jun2, j);
end
jul2 = [];
for i = 7:12:216
   j = pr_VL1_new(:,:,i);
   jul2 = cat(3, jul2, j);
end
aug2 = [];
for i = 8:12:216
   j = pr_VL1_new(:,:,i);
   aug2 = cat(3, aug2, j);
end
sep2 = [];
for i = 9:12:216
   j = pr_VL1_new(:,:,i); 
   sep2= cat(3, sep2, j);
end
oct2 = [];
for i = 10:12:216
   j = pr_VL1_new(:,:,i); 
   oct2 = cat(3, oct2, j);
end
nov2 = [];
for i = 11:12:216
   j = pr_VL1_new(:,:,i); 
   nov2 = cat(3, nov2, j);
end
dec2 = [];
for i = 12:12:216
   j = pr_VL1_new(:,:,i); 
   dec2 = cat(3, dec2, j);
end

pr_VL4_first_20 = pr_VL4_new(:,:,1:240).*365;
pr_VL4_first_20_mean = nanmean(pr_VL4_first_20,3);
pr_VL1_first_8 = pr_VL1_new(:,:,1:216).*365;
pr_VL1_first_8_mean = nanmean(pr_VL1_first_8,3);
pr_anomaly = pr_VL4_first_20_mean - pr_VL1_first_8_mean;

mean_annual = nanmean(nanmean(pr_anomaly));
mean_annual = round(mean_annual);
mean_annual = string(mean_annual);

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

%result = result*365;

%for i= 1:10
   % year = i;
    figure
      hold on; box on
      set(gca,'FontSize',fs)
      m_proj('Lambert Conformal Conic','lon',[-65 -10],'lat',[55 85],'rec','on');
      m_grid('fontsize',fs,'xtick',xt,'ytick',yt,'XaxisLocation','bottom','YaxisLocation','left');
      m_contour(lon,lat,icemask,[0:1],'color','k','linewidth',1);
      m_contourf(lon,lat,pr_anomaly,[-1000:10:1000],'LineStyle','none')
      annotation('textbox', [0.45, 0.15, 0.2, 0.2], 'String', {'mean = ' +  mean_annual + ' [kg/m^{2}]'}, 'FitBoxToText', 'on');
      %caxis([-1,1]);
      caxis([-600,600]);
      map=cbrewer('div','RdBu',30);
      %colormap(flipud(map)); %This one inverts the colormap scale
      colormap(map) %This one keeps the colormap scale as in Cbrewer
      h=colorbar;
      cbarrow;
      title(['PI - 130ka Annual PR Anomaly']); 
      ylabel(h, {'[kg/m^{2}]'},'FontSize',fs)
      m_coast('line','color',[0.7 0.7 0.7])
      filename = ['map_NorESM_Greenland_VL4_VL1_PR_anomaly'];
      saveas(gcf,  filename, 'png');

%end  

winter_pr_VL1 = cat(3, dec2, jan2, feb2).*90;
winter_pr_VL1 = nanmean(winter_pr_VL1, 3);

winter_pr_VL4 = cat(3, dec, jan, feb).*90;
winter_pr_VL4 = nanmean(winter_pr_VL4, 3);

winter_pr_anomaly = winter_pr_VL4 - winter_pr_VL1;

mean_winter = nanmean(nanmean(winter_pr_anomaly));
mean_winter = round(mean_winter);
mean_winter = string(mean_winter);

 figure
      hold on; box on
      set(gca,'FontSize',fs)
      m_proj('Lambert Conformal Conic','lon',[-65 -10],'lat',[55 85],'rec','on');
      m_grid('fontsize',fs,'xtick',xt,'ytick',yt,'XaxisLocation','bottom','YaxisLocation','left');
      m_contour(lon,lat,icemask,[0:1],'color','k','linewidth',1);
      m_contourf(lon,lat,winter_pr_anomaly,[-150:10:150],'LineStyle','none')
      annotation('textbox', [0.45, 0.15, 0.2, 0.2], 'String', {'mean = ' +  mean_winter + ' [kg/m^{2}]'}, 'FitBoxToText', 'on');
      %caxis([-1,1]);
      caxis([-150,150]);
      map=cbrewer('div','RdBu',30);
      colormap(map) %This one keeps the colormap scale as in Cbrewer
      h=colorbar;
      cbarrow;
      title(['PI - 130ka Winter PR Anomaly']); 
      ylabel(h, {'[kg/m^{2}]'},'FontSize',fs)
      m_coast('line','color',[0.7 0.7 0.7])
      filename = ['map_NorESM_Greenland_VL4_VL1_Winter_PR_anomaly'];
      saveas(gcf,  filename, 'png');

      
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
summer_pr_VL1 = cat(3, jun2, jul2, aug2).*90;
summer_pr_VL1 = nanmean(summer_pr_VL1, 3);

summer_pr_VL4 = cat(3, jun, jul, aug).*90;
summer_pr_VL4 = nanmean(summer_pr_VL4, 3);

summer_pr_anomaly = summer_pr_VL4 - summer_pr_VL1;

mean_summer = nanmean(nanmean(summer_pr_anomaly));
mean_summer = round(mean_summer);
mean_summer = string(mean_summer);

figure
      hold on; box on
      set(gca,'FontSize',fs)
      m_proj('Lambert Conformal Conic','lon',[-65 -10],'lat',[55 85],'rec','on');
      m_grid('fontsize',fs,'xtick',xt,'ytick',yt,'XaxisLocation','bottom','YaxisLocation','left');
      m_contour(lon,lat,icemask,[0:1],'color','k','linewidth',1);
      m_contourf(lon,lat,summer_pr_anomaly,[-450:10:450],'LineStyle','none')
      annotation('textbox', [0.45, 0.15, 0.2, 0.2], 'String', {'mean = ' +  mean_summer + ' [kg/m^{2}]'}, 'FitBoxToText', 'on');
      %caxis([-1,1]);
      caxis([-150,150]);
      map=cbrewer('div','RdBu',30);
      colormap(map) %This one keeps the colormap scale as in Cbrewer
      h=colorbar;
      cbarrow;
      title(['PI - 130ka Summer PR Anomaly']); 
      ylabel(h, {'[kg/m^{2}]'},'FontSize',fs)
      m_coast('line','color',[0.7 0.7 0.7])
      filename = ['map_NorESM_Greenland_VL4_VL1_Summer_PR_anomaly'];
      saveas(gcf,  filename, 'png');
      
      
      %%KAI TIS ALLES EPOXES
      
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
autumn_pr_VL1 = cat(3, sep2, oct2, nov2).*90;
autumn_pr_VL1 = nanmean(autumn_pr_VL1, 3);

autumn_pr_VL4 = cat(3, sep, oct, nov).*90;
autumn_pr_VL4 = nanmean(autumn_pr_VL4, 3);

autumn_pr_anomaly = autumn_pr_VL4 - autumn_pr_VL1;

mean_autumn = nanmean(nanmean(autumn_pr_anomaly));
mean_autumn = round(mean_autumn);
mean_autumn = string(mean_autumn);

figure
      hold on; box on
      set(gca,'FontSize',fs)
      m_proj('Lambert Conformal Conic','lon',[-65 -10],'lat',[55 85],'rec','on');
      m_grid('fontsize',fs,'xtick',xt,'ytick',yt,'XaxisLocation','bottom','YaxisLocation','left');
      m_contour(lon,lat,icemask,[0:1],'color','k','linewidth',1);
      m_contourf(lon,lat,autumn_pr_anomaly,[-150:10:150],'LineStyle','none')
      annotation('textbox', [0.45, 0.15, 0.2, 0.2], 'String', {'mean = ' +  mean_autumn + ' [kg/m^{2}]'}, 'FitBoxToText', 'on');
      %caxis([-1,1]);
      caxis([-150,150]);
      map=cbrewer('div','RdBu',30);
      colormap(map) %This one keeps the colormap scale as in Cbrewer
      h=colorbar;
      cbarrow;
      title(['PI - 130ka Autumn PR Anomaly']); 
      ylabel(h, {'[kg/m^{2}]'},'FontSize',fs)
      m_coast('line','color',[0.7 0.7 0.7])
      filename = ['map_NorESM_Greenland_VL4_VL1_Autumn_PR_anomaly'];
      saveas(gcf,  filename, 'png');
      
      
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
spring_pr_VL1 = cat(3, mar2, apr2, may2).*90;
spring_pr_VL1 = nanmean(spring_pr_VL1, 3);

spring_pr_VL4 = cat(3, mar, apr, may).*90;
spring_pr_VL4 = nanmean(spring_pr_VL4, 3);

spring_pr_anomaly = spring_pr_VL4 - spring_pr_VL1;

mean_spring = nanmean(nanmean(spring_pr_anomaly));
mean_spring = round(mean_spring);
mean_spring = string(mean_spring);

figure
      hold on; box on
      set(gca,'FontSize',fs)
      m_proj('Lambert Conformal Conic','lon',[-65 -10],'lat',[55 85],'rec','on');
      m_grid('fontsize',fs,'xtick',xt,'ytick',yt,'XaxisLocation','bottom','YaxisLocation','left');
      m_contour(lon,lat,icemask,[0:1],'color','k','linewidth',1);
      m_contourf(lon,lat,spring_pr_anomaly,[-150:10:150],'LineStyle','none')
      annotation('textbox', [0.45, 0.15, 0.2, 0.2], 'String', {'mean = ' +  mean_spring + ' [kg/m^{2}]'}, 'FitBoxToText', 'on');
      caxis([-150,150]);
      map=cbrewer('div','RdBu',30);
      colormap(map) %This one keeps the colormap scale as in Cbrewer
      h=colorbar;
      cbarrow;
      title(['PI - 130ka Spring PR Anomaly']); 
      ylabel(h, {'[kg/m^{2}]'},'FontSize',fs)
      m_coast('line','color',[0.7 0.7 0.7])
      filename = ['map_NorESM_Greenland_VL4_VL1_Spring_PR_anomaly'];
      saveas(gcf,  filename, 'png');

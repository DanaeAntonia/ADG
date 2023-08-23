%% 1:cargar archivo
load('DINEOF2018.mat');
%% hay que modificar las latudes y longitudes?
%si hay que modificar 
%para latitudes tomar la primer FILA, ya que se repiten los datos por
%columnas 
%en las longitudes debemos tomar la primera COLUMNA, hya que se repiten las
%filas.
lat=latJF(1,:);
lon=lonJF(:,1);

%% realice una correlacion para la primera latitud y la primera longitud para todos los tiempos(365 dias)
rho=corr(sst2018JF(:,1,1),chla2018JF(:,1,1),'row','complete'); %primera lon y primera lat
figure()
plot(squeeze(sst2018JF(:,1,1)),squeeze(chla2018JF(:,1,1)),'*')
grid on

%% realice correlacion punto a punto del campo sst y chla para todos los tiempos 
for i=1:340; %lat
   for j=1:551; %lon  
    rhop(i,j)=corr(sst2018JF(:,i,j),chla2018JF(:,i,j),'rows','complete');
   end 
end

figure()
pcolor(latJF,lonJF,rhop')
shading interp %suaviza el mapa
colorbar
title('Correlaciones entre clorofila y tempertura JF,2018')
xlabel('Longitudes')
ylabel('Latitudes')

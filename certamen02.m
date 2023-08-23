%% Certamen 02 18/07/2022
%% PARTE 1
load('Parte1.mat');
%% 1.1 CORELLACION SIMPLE
%% A) calculamos correlacion entre concepcion(Tm_C)y santiago(Tm_S)-->(C_s)
C_s=corr(Tm_C', Tm_S','rows','complete');
%para saber la significancia estadistica usamos t student, y la funcion
%creada tstudent, al nivel de confianza 95%
[rho,n,t,alpha]=tstudent(Tm_C',Tm_S',95);
%obtenemos que nuestro t y comparando con el de la tabala notamos que la
%correlacion es significativa
%% B)extraer tendencia y repetir calculo
C_st=corr(detrend(Tm_C'), detrend(Tm_S'),'rows','complete');
%para saber la significancia estadistica usamos t student, y la funcion
%creada tstudent, al nivel de confianza 95%
[rho,n,t,alpha]=tstudent(detrend(Tm_C'),detrend(Tm_S'),95);
%obtenemos que nuestro t y comparando con el de la tabala notamos que la
%correlacion es significativa

%% C) Genere un filtro pasa bajo, con un tipo que usted estime conveniente
% justifique el uso de la ventana, usaremos una venta gaussiana
%
%% Serie Tm_C
[G90_C,G90_AC]=gaussFILTRO(90,Tm_C);%90 dias %G90--->filtro pasa bajo 90 dias
[G1A_C,G1A_AC]=gaussFILTRO(548,Tm_C);%1 año %G1A--->filtro pasa bajo 1año
[G1D_C,G1D_AC]=gaussFILTRO(3650,Tm_C);% 1 decada--->filtro pasa bajo 1decada
%% Serie Tm_S 
[G90_S,G90_AS]=gaussFILTRO(90,Tm_S);%90 dias
[G1A_S,G1A_AS]=gaussFILTRO(548,Tm_S);%1 año y medio
[G1D_S,G1D_AS]=gaussFILTRO(3650,Tm_S);% 1 decada
%% Repetir el cálculo de la correlación entre concepción y Santiago, para los 3 casos 
%(C_90D, C_1A, C_1DEC). (10%) 
C_90D=corr(G90_C', G90_S','rows','complete'); %CORRELACION 90 DIAS
C_1A=corr(G1A_C', G1A_S','rows','complete'); %CORRELACION 1AÑO y MEDIO aprox
C_1DEC=corr(G1D_C', G1D_S','rows','complete'); %CORRELACION 1 DECADA
%% GRAFICAMOS EN UN SUBPLOT SERIES ORIGINALES Y SUS FILTROS
figure()
subplot 211
plot(fecha,Tm_C,'.k');%original
hold on
plot(fecha,G90_C,'m');%seria filtrada con 90 dias
plot(fecha,G1A_C,'g','linewidth',4);%serie filtrada con 1 año y medio
plot(fecha,G1D_C,'r','linewidth',2);%serie filtrada con 1 decada
legend('original','90 dias','1 año y medio',' 1 decada')
datetick
axis tight
title('Temperatura media(Tm_C) medida dariamente Carriel Sur (1/1/1966 al 3/07/2022)')
xlabel('Años')
ylabel('Temperatura [ºC]')
set(gcf,'color','w')
subplot 212
plot(fecha,Tm_S,'.k');%original
hold on
plot(fecha,G90_S,'m');%seria filtrada con 90 dias
plot(fecha,G1A_S,'g','linewidth',4);%serie filtrada con 1 año y medio
plot(fecha,G1D_S,'r','linewidth',2);%serie filtrada con 1 decada
legend('original','90 dias','1 año y medio',' 1 decada')
datetick
title('Temperatura media(Tm_S) medida dariamente estacion Quinta normal (1/1/1966 al 3/07/2022)')
xlabel('Años')
ylabel('Temperatura [ºC]')
axis tight
set(gcf,'color','w')
%% Correlacion con desfase
%% correlacion con desfase para serie original
[rho_Tm_C , lag_Tm_C]=xcorr(Tm_C',Tm_S',1095,'coeff'); %como la serie esta en dias 3años serias 365*3=1095
%graficamos desfase vs correlacion
figure()
plot(lag_Tm_C,rho_Tm_C,'b','linewidth',2)
title('Desfase(+-3años)(+-1095dias) vs Correlacion, para series de temperatura media, ')
xlabel('Desfase(dias)')
ylabel('Correlacion')
set(gcf,'color','w')
%% la serie filtradas a década (Figura 3). (10%) %la serie sigue estando en dias pero filtrada a decadas
[rho_G1D,lag_G1D]=xcorr(G1D_C',G1D_S',1095,'coeff'); 
figure()
plot(lag_G1D, rho_G1D,'b','linewidth',2)
title('Desfase(+-3años)(+-1095dias) vs Correlacion, para series de temperatura media filtras a decada')
xlabel('Desfase(dias)')
ylabel('Correlacion')
set(gcf,'color','w')
%% las series filtradas a 1.5 años sin tendencia lineal (Figura 4) 
[rho_G1A,lag_G1A]=xcorr(detrend(G1A_C'),detrend(G1A_S'),1095,'coeff'); 
figure()
plot(lag_G1A, rho_G1A,'b','linewidth',2)
title('Desfase(+-3años)(+-1095dias) vs Correlacion, para series de temperatura media filtras a 1,5 años')
xlabel('Desfase (dias)')
ylabel('Correlacion')
set(gcf,'color','w')
%% Identificar el valor máximo de correlación y su respectivo desfase para los 
%%3 casos (A, B y C) descritos (Tabla 2). (15%) 
%para saber mis valores maximos usaremos dos funciones creadas
%anteriormente
%CASO A
C_maxA=MAXc(Tm_C',Tm_S');%0.98
d_maxA=MAXd(Tm_C',Tm_S');%0
%Caso B
C_maxB=MAXc(G1D_C',G1D_S');%0.99
d_maxB=MAXd(G1D_C',G1D_S');%0
%Caso C
C_maxC=MAXc(detrend(G1A_C'),detrend(G1A_S'));%0.90
d_maxC=MAXd(detrend(G1A_C'),detrend(G1A_S'));%0
%% PARTE 2
load('parte2.mat');
%% 1.1A) -A- Encuentre estos valores y reemplazar por NaN, mostrar en una tabla aquel 
%año y mes donde estos se encuentran (Tabla 3, poner en primera y segunda columna). 
N34(find(N34==-9999))=NaN;
[i,j] = find(isnan(N34));%Localizamos las posiciones de los nan
P=[i,j]; %año-->filas-->i , meses-->columnas
%tabla
%   año(fila)  mes(columna)
%     N34(22)     6+1
%     N34(56)     7+1
%     N34(10)     8+1
%% interpolamos matriz, con pesos de 0.2,0.8
N34_interp=inter2D(N34(:,2:end),0.2,0.8); %interpolamos sin la columna de fechas
NI=[N34(:,1), N34_interp]; %matriz interpolada
%% Filtrar en 2D la base de datos N34 interpolada (es decir resultante de la 
%pregunta anterior), con un filtro paso bajo de ancho 7. (10%) 
%filtramos con una ventana gaussiana 
[G7,G7_A]=gaussFILTRO(7,NI); %filtro pasa bajo y pasa alto ventana ancho 7
%% - D- Graficar la matriz interpolada y la matriz filtrada
figure()
plot(NI(:,1),NI,'k')%matriz interpolada
hold on
plot(NI(:,1),G7(:,2:end),'r')%matriz filtrada
title('Matriz interpolada y matrioz filtrada')
%% 2 matriz precipitacion
%A- Obtenga el mapa de correlación para cada punto de grilla, entre esta 
%matriz (pp_a) y la serie de datos resultante del filtro pasa bajo 2D del 
%ítem anterior (pregunta Y_1C). (Figura 6). (10%) 
%% Notamos quela serie filtrada y pp_a no tienen las mismas dimensiones por lo tanto debemos 
 %reshape para dejarla en las mismas dimensiones ademas notamos que la columna de fe
 %fechas no nos sirve por lo tanto no la usaremos
 G7_nd= reshape(G7(:,2:end),792,1); %ahora tienen las mismas dimensiones
 % calculamos correlacion punto a punto
  for x=1:length(lon) % longitud 
           for y=1:length(lat) % latitud
           correlacion(x,y)=corr(squeeze(pp_a(x,y,:)),G7_nd);%obtenemos la correlacion punto a punto de pp_a y N34    
           end
     end
% graficamos
figure
pcolor(lon,lat,correlacion') % transpuesta de la correlación
shading interp % suabiza el mapa
hold on
borders('countries','k','linewidth',.5,'center',180)
colormap('redbluecmap')
colorbar
xlabel('Longitudes')
ylabel('Latitudes')
title('Correlacion entre precipitacion y indice del niño filtrado cada 7 años')
set(gcf,'color','w')

%% B- Repetir el mismo proceso que en el ítem anterior, pero ahora 
%previamente filtrar la serie resultante de la matriz N34 solo interpolada 
%(resultante de la pregunta Y_1B) por un filtro de 7 años. (Figura 
%7).(10%) 
%debemos pasar NI a dos columnas, utilizamos funcion
NI2=colum2(NI);
%le aplicamos un filtro para 7 años a NI2
[G72,G7_A]=gaussFILTRO(7,NI2);
%ahora aplicamos correlacion punto a punto, sin tomar las fechas de G72
 for x=1:length(lon) % longitud 
           for y=1:length(lat) % latitud
           correlacion(x,y)=corr(squeeze(pp_a(x,y,:)),G72(:,2));%obtenemos la correlacion punto a punto de pp_a y N34    
           end
 end

%hacemos mapa
figure
pcolor(lon,lat,correlacion') % transpuesta de la correlación
shading interp % suabiza el mapa
hold on
borders('countries','k','linewidth',.5,'center',180)
colormap('redbluecmap')
colorbar
xlabel('Longitudes')
ylabel('Latitudes')
title('Correlacion entre precipitacion y indice del niño filtrado cada 7 años')
set(gcf,'color','w')
%% C- Repetir el mismo proceso que en el ítem anterior, pero ahora 
%previamente filtrar la serie resultante de la matriz N34 solo interpolada 
%(resultante de la pregunta Y_1B) por un filtro pasa banda de 7 a 15 años. 
%(Figura 8) (5%)
%calculamos bajos de 7 y 15
[G7,G7_A7]=gaussFILTRO(7,NI);%7
[G15,G7_A15]=gaussFILTRO(7,NI);%15 
G_PB=G7-G15; %como no esta en las mismas dimensiones que pp_a usamos nuevamente reashape
 GPB_nd= reshape(G_PB(:,2:end),792,1); %ahora tienen las mismas dimensiones
 % calculamos correlacion punto a punto
  for x=1:length(lon) % longitud 
           for y=1:length(lat) % latitud
           correlacion(x,y)=corr(squeeze(pp_a(x,y,:)),GPB_nd);%obtenemos la correlacion punto a punto de pp_a y N34    
           end
     end
% graficamos
figure
pcolor(lon,lat,correlacion') % transpuesta de la correlación
shading interp % suabiza el mapa
hold on
borders('countries','k','linewidth',.5,'center',180)
colormap('redbluecmap')
colorbar
xlabel('Longitudes')
ylabel('Latitudes')
title('Correlacion entre precipitacion y indice del niño filtrado cada 7 años')
set(gcf,'color','w')



















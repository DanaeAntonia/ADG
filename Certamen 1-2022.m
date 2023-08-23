%1.a
%recuperamos basa de datos.
A=readmatrix('SUR.dat');

%1.b
A(1:4,:)=[]; %eliminamos los datos de las primeras 4 felias ya que eran NaN's
%no podemos eliminar 2022 ya que no hay
%eliminamos 2021
A(end,:)=[];

%1.c
%encontramos los datos que contienen -999.9 con find, y reemplazamos por
%NaN
A(find(A==-999.9))= NaN;
%encontramos posiciones de los NaN's
[fila,columna]= find(isnan(A));
posiciones=[fila, columna];
years=A(posiciones(:,1));

%1.d
%para pasar de varias columnas a dos columnas utilizamos la funcion creeada
%colum2.m
B=colum2(A);

%1.e
%hacemos un bonito plot
%hacemos un plot simple plot(x,y)
figure()
plot(B(:,1),B(:,2))
axis tight
title('Extensión de nieve en el hemisferio SUR')
ylabel('Extensión [10^6 km2]')
xlabel('años')
grid on
set(gcf,'color','w')


%ITEM2 interpolacion
%lo primero sera sacarle los NaN's a nuestra Matriz B 
%usaremos nuestra funcion sinNaN
BB=sinNaN(B);
[fila,columna]= find(isnan(B));
posiciones=[fila, columna];
yearsB=B(posiciones(:,1));
%1.a
%ahora nuestros datos interpolados los guardaremos en C
C=interp1(BB(:,1),BB(:,2),B(:,1),'spline'); %Donde BB matriz sin NaN y B matriz con NaN
datosC=C(posiciones(:,1))

%1.b
figure()
subplot 211
plot(B(:,1),C,'r')
hold on
plot(B(:,1),B(:,2),'k')
axis tight
title('Extensión de nieve en el hemisferio SUR')
ylabel('Extensión [10^6 km2]')
xlabel('años')
grid on
set(gcf,'color','w')

subplot 212
plot(B(:,1),C,'+r','LineWidth',5)
axis tight
%arreglar es de 83 a 85
xlim([1982.95833333333  1984.95833333333])
title('Extensión de nieve en el hemisferio SUR, ZOOM a la interpolacion')
ylabel('Extensión [10^6 km2]')
xlabel('años')
grid on
set(gcf,'color','w')

%ESTADISTICOS
%3.a
meC=mean(C);%calculamos la media
B(:,3)=meC
stdC=std(C);%calculamos desviacion estandar


%3.b
%calulamos la media movil,con una funcion creada Mm
MmvC=Mm(C,61); %ventana de 61
%calculamos la desviacion estandar movil, con funcion creada STDm
StdmC=STDm(C,61); %ventana de 61
%para graficar y que la perdida de datos este al final, creeo un vector de
%fechas, al cual le quitare 61-1 filas al final.
F=B(:,1);
F(433:end,:)=[]; %vector de fechas para que la perdida de datos sea al final
%realizamos figura:
figure()
plot(B(:,1),C,'k')%datos originales
hold on
plot(F,MmvC,'b','LineWidth',2)%media movil
plot(B(:,1),B(:,3),'r','LineWidth',1)%media
plot(F,MmvC - StdmC, 'm','LineWidth',2)%-stdmov
plot(F,MmvC + StdmC, 'g','LineWidth',2)%+stdmov
legend('Datos','MeMov','Me','-STDmov','+STDmov')
title('Extensión de nieve en el hemisferio SUR')
ylabel('Extensión [10^6 km2]')
xlabel('años')
grid on
set(gcf,'color','w')
axis tight

%Medidas de dispersion
%4.a
%calculamos la mediana a C:
med_C=median(C);

q1_C=quantile(C,0.25);%cuartil 1
q3_C=quantile(C,0.75);%cuartil 3
%calculamos la trimediana
tm_C= (q1_C+2*med_C+q3_C)/4 ;
%rango intercuartilico
iqr_C=iqr(C);

%4.b
figure()
boxplot(C,'label',{'Serie interpolada C'})
grid minor 
set(gcf,'color','w')

%4.c
AA=sinNaN(A);
figure()
boxplot(AA(1:10:end,2:end))%toma cada dies filas hasta el final, es decir cada 10 año
grid minor 
set(gcf,'color','w')

figure()
subplot 211
boxplot(C,'label',{'Serie interpolada C'})
grid minor 
set(gcf,'color','w')

subplot 212
boxplot(AA(1:10:end,2:end))%toma cada dies filas hasta el final, es decir cada 10 año
grid minor 
set(gcf,'color','w')
title('Boxplot años')
%5.a
P1=nanmean(A(13,:));
p2=nanmean(A(:,7));
%ahora con funcion interp2D_cuadrada
I=interp2D_cuadrada(A,P1,p2);


%regresion
P1=polyfit(B(:,1),C,50);
P=polyval(P1,B(:,1));

P2=polyfit(B(:,1),C,1);
P1=polyval(P2,B(:,1));
figure()
plot(B(:,1),C)
hold on
plot(B(:,1),P,'g')
plot(B(:,1),P1,'g')


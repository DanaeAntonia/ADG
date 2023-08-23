%31/05/22
%Practica Correlacion

%0
%vector x del 1 al 100 con paso 0.1
X=[1:0.1:100];
%vector y doble de X mas 35
Y=2.*X+35;
%ajustar una exponencial
Y2=exp(X/100)+exp(X/10);

%Graficar
figure()
subplot 211
plot(X,Y, 'o')
title('X respecto a Y')
xlabel('X')
ylabel('Y')
%COMO SE VE LA NUEBE DE PUNTOS
%como una recta
%se relacionan linealmente
subplot 212
plot(X,Y2,'o')
title('X respecto a Y2')
xlabel('X')
ylabel('Y2')
%COMO SE VE LA NUEBE DE PUNTOS
%como una exponencial
%se relacionan exponencialmente

%1
%calculamos Spearman y Person para X,Y

%PERSON 
%corr es para filas, nuestro X e Y tiene 1 fila y columnas, por lo tanto
%debemos trasponerlos
y=Y';
y2=Y2';
x=X';
rho=corr(x,y,'type','Pearson');
rho2=corr(x,y2,'type','Pearson');

%SPEARMAN
Srho=corr(x,y,'type','Spearman');
Srho2=corr(x,y2,'type','Spearman');
%
%
%2
%Reemplazar en y, y2 la posicion 50 el valor -9999
Y(50)=-9999;
Y2(50)=-9999;
%
%Y hacemos calculamos correlaciones.
y=Y';
y2=Y2';
x=X';
rho=corr(x,y,'type','Pearson');
rho2=corr(x,y2,'type','Pearson');

%SPEARMAN
Srho=corr(x,y,'type','Spearman');
Srho2=corr(x,y2,'type','Spearman');

%Spearmen no es sensible a valores extremos 
%Pearson es vulnerablr a valores extremos
%
%
%3
load('pp_1921_2010.mat')
%A-->Plotear en una misma figura en distintos graficos precipitacion c/r
%tiempo
figure()
subplot 311
plot(an,p_CCP)
title('Concepcion')
ylabel('Precipitacion[mm]')
xlabel('años')
%
subplot 312
plot(an,p_CH)
title('Chillan')
ylabel('Precipitacion[mm]')
xlabel('años')
%
subplot 313
plot(an,p_SCL)
title('Santiago')
ylabel('Precipitacion[mm]')
xlabel('años')
%
%B--> Genere diagramas dispersion para SCL-CCP, SCL-CH, CH-CCP
figure()
subplot 311
scatter(p_SCL,p_CCP,'filled')
title('SCL-CCP')
ylabel('CCP')
xlabel('SCL')
axis square
%
subplot 312
scatter(p_SCL,p_CH,'filled')
title('SCL-CH')
ylabel('CH')
xlabel('SCL')
axis square
%
subplot 313
scatter(p_CH,p_CCP,'filled')
title('CH-CCP')
ylabel('CCP')
xlabel('CH')
axis square
%








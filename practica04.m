%generar graficos para regresion linean y cubica para los datos
%originlaes(matriz B)
%polyfit no acepta valores nan, por lo tanto debemos sacacarselos, para
%esto usamos la funcion sinNaN
BB=sinNaN(B);
P1= polyfit(BB(:,1),BB(:,2),1); %regresion lineal, grado 1
P2= polyfit(BB(:,1),BB(:,2),2); %regresion cuadratica, grado 2
P3= polyfit(BB(:,1),BB(:,2),3); %regresion cubica, grado 3
%Ahora para evualuar el polinomio utilizamos polyval
PV1 = polyval(P1,BB(:,1)); %grado 1
PV2 = polyval(P2,BB(:,1)); %cuadratica
PV3 = polyval(P3,BB(:,1)); %cubico

%graficamos 
figure()
subplot 311
plot(B(:,1),B(:,2),'o') %datos originales
hold on
plot(BB(:,1),PV1,'r','LineWidth',2)%ajuste polinomio de grado 1
title('datos originales y regresion lineal')
ylabel('Masa [Gt]')
xlabel('Años')
legend('Datos','regresion lineal')
grid on

subplot 312
plot(B(:,1),B(:,2),'o') %datos originales
hold on
plot(BB(:,1),PV2,'r','LineWidth',2)%ajuste polinomio de grado 1
title('datos originales y regresion cuadratica')
ylabel('Masa [Gt]')
xlabel('Años')
legend('Datos','regresion cuadratica')
grid on

subplot 313
plot(B(:,1),B(:,2),'o') %datos originales
hold on
plot(BB(:,1),PV3,'r','LineWidth',2)%ajuste polinomio de grado 1
title('datos originales y regresion cubica')
ylabel('Masa [Gt]')
xlabel('Años')
legend('Datos','regresion cubica')
grid on

%Ahora interpolamos
%usamops interp1(X,V,xq)
% x,v, fechas y datos  sin nan
%xq fechas con nan
I=interp1(BB(:,1),BB(:,2),B(:,1));

figure()
subplot 221
plot(B(:,1),B(:,2),'o') %datos originales con NaN
title('Datos originales, con NaN')
ylabel('Masa [Gt]')
xlabel('Años')
grid on

subplot 222
plot(B(:,1),I,'o','Color','r') %datos interpolados
title('Datos interpolados')
ylabel('Masa [Gt]')
xlabel('Años')
grid on

subplot(2,2,[3,4])
plot(B(:,1),B(:,2),'o','Color','b')
hold on
plot(B(:,1),I,'--r') %datos interpolados
title('Datos interpolados')
ylabel('Masa [Gt]')
xlabel('Años')
grid on
legend('Datos originales','Interpolacion')
set(gcf,'color','w') %para poner el fondo blancoo

%interpolecion spline
%usamops interp1(X,V,xq,'spline')
% x,v, fechas y datos  sin nan
%xq fechas con nan
Is=interp1(BB(:,1),BB(:,2),B(:,1),'spline');

figure()
subplot 221
plot(B(:,1),B(:,2),'o') %datos originales con NaN
title('Datos originales, con NaN')
ylabel('Masa [Gt]')
xlabel('Años')
grid on

subplot 222
plot(B(:,1),Is,'o','Color','k') %datos interpolados
title('Datos interpolados con metodo spline')
ylabel('Masa [Gt]')
xlabel('Años')
grid on

subplot(2,2,[3,4])
plot(B(:,1),B(:,2),'o','Color','b')
hold on
plot(B(:,1),Is,'--k') %datos interpolados
title('Datos')
ylabel('Masa [Gt]')
xlabel('Años')
grid on
legend('Datos originales','Interpolacion spline')
set(gcf,'color','w') %para poner el fondo blancoo

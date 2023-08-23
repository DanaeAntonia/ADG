%practica 3
%RECUPERAMOS A Y B
B(:,3)=detrend(B(:,2),'omitnan'); %en la tercera columna de bB guardamos los datos sin tendencia
%generamos un histograma para la serie con y sin tendencia
%con frencuencia y frecuencia porcentual(relativa)
figure()
subplot 221
histogram(B(:,2),'FaceColor','m')
title('Datos con tendencia')
xlabel('años')
ylabel('frecuencia')

subplot 222
histogram(B(:,3),'FaceColor','b')
title('Datos sin tendencia')
xlabel('años')
ylabel('frecuencia')

subplot 223
histogram(B(:,2),'Normalization','probability','FaceColor','m')
title('Datos con tendencia')
xlabel('años')
ylabel('frecuencia porcentual')

subplot 224
histogram(B(:,3),'Normalization','probability','FaceColor','b')
title('Datos sin tendencia')
xlabel('años')
ylabel('frecuencia porcentual')

%4,generar el mismo grafico anterior pero esta vez damos un ancho a las
%alas barritas, esto se hace con la siguiente formula.
h1 = 2.59*iqr(B(:,2))/(216)^(1/3);%datos con tendencia
h2 = 2.59*iqr(B(:,3))/(216)^(1/3); %datos sin tendencia
%Hacemos los mismos graficos anteriores pero esta vez con el ancho de las
%barritas.
figure()
subplot 221
histogram(B(:,2),'BinWidth',h1,'FaceColor','m')
title('Datos con tendencia')
xlabel('años')
ylabel('frecuencia')

subplot 222
histogram(B(:,3),'BinWidth',h2,'FaceColor','b')
title('Datos sin tendencia')
xlabel('años')
ylabel('frecuencia')

subplot 223
histogram(B(:,2),'BinWidth',h1,'Normalization','probability','FaceColor','m')
title('Datos con tendencia')
xlabel('años')
ylabel('frecuencia porcentual')

subplot 224
histogram(B(:,3),'BinWidth',h2,'Normalization','probability','FaceColor','b')
title('Datos sin tendencia')
xlabel('años')
ylabel('frecuencia porcentual')
%para la matriz A hacer 12 histogramas, uno para cada mes
figure()
for i=2:13 %meses
    n= i-1 ;
    subplot (3, 4, n)
    histogram(A(:,i))
    xlabel('datos [Gt]')
    ylabel('Frecuencia')
end

%CALCULE la media, mediana, trimean, cuartiles, rango intercuartil y desviación estándar para ambas 
%series (segunda y tercera columna de B).

C(:,1)=B(:,2); %CON TENDENCIA
S(:,1)=B(:,3);%SIN TENDENCIA
%calculamos media
C(:,2)= nanmean(C(:,1));
S(:,2)= nanmean(S(:,1));
%calculamos mediana
C(:,3)= nanmedian(C(:,1));
S(:,3)= nanmedian(S(:,1));
%utilizamos trimean
C(:,4)= trimmean(C(:,1),10);
S(:,4)= trimmean(S(:,1),10);
%Cuartiles
C(:,5)=quantile(C(:,1),0.25); % primer cuartil
% segundo cuartil = mediana
C(:,6)=quantile(C(:,1),0.75); % tercer cuartil
S(:,5)=quantile(S(:,1),0.25); % primer cuartil
% segundo cuartil = mediana
S(:,6)=quantile(S(:,1),0.75); % tercer cuartil

%Rango intercuartil
C(:,7)=iqr(C(:,1)); 
S(:,7)=iqr(S(:,1)); 

%Desviacion estandar
C(:,8)=nanstd(C(:,1));
S(:,8)= nanstd(C(:,1));

%Calcular el skewness de ambas series, interpretar.
sesgoC=skewness(B(:,2)); %sesgo datos con tendencia
sesgoS=skewness(B(:,3));%sesgo datos sin tendencia

%Generar un boxplot para la serie con tendencia y sin tendencia, sobreponer la media, trimean y 
%mediana para cada serie. (figura 4, usar subplot)

figure()
subplot 211
boxplot(B(:,2))
hold on 
plot(S(1,2),'*k','LineWidth',4) %MEDIA
plot(S(1,4),'*b','LineWidth',4)%trimean
plot(S(1,3),'*r','LineWidth',4)%mediana
legend('media','trimean','mediana')
title('Boxplot datos con tendencia y sus estadisticos')

subplot 212
boxplot(B(:,3))
hold on
plot(C(1,2),'k','LineWidth',4) %MEDIA
plot(C(1,4),'b','LineWidth',4)%trimean
plot(C(1,3),'r','LineWidth',4)%mediana
legend('media','trimean','mediana')
title('Boxplot datos sin tendencia')


%A partir de la matriz A, generar, en una misma figura, un boxplot para cada mes (figura 5), ¿Qué se 
%ve
figure()
            boxplot(A(1:10:end,:))),'labels',{'Enero','Febrero','Marzo','Abril'...
      ,'Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'})
hold on 
plot(1:12,c_a,'-ok')
grid minor


boxplot(A(:,2:end))

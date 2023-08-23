A = load('igreenland_mass.dat.txt');
A(find(A==-999.9))= NaN; %reemplazamos los errores -999,9 por NaN

%pasamos fechas a año.fraccion de año, para esto debemos utilizar una
%formula  
% pasamos los datos a dos columnas
n=0 %contador
for i=1:length(A(:,1)) %cantidad de filas, cantidad de años
    for j=2:length(A(1,:)) %cantidad de columnas, cantidad de meses
        n=1+n
     B(n,1)=A(1,1)+(1/12/2)+(n-1)./12
     B(n,2)= A(i,j)
    end
end
%clonamos la matriz B tal que
%Borramos los NaN a B y almacenamos en C
C=B(~isnan(sum(B,2)),:);
%Comparamos graficos con nan y sin nan
figure()
subplot 211
plot(B(:,1),B(:,2),'r','LineWidth',2)
title('mediciones de masa de Groenlandia','LineWidth',3)
xlabel('años','LineWidth',2)
ylabel('masa [Gt]')
grid on %para poner grilla
legend('masa Groenlandia')

subplot 212
plot(C(:,1),C(:,2),'r','LineWidth',2)
title('mediciones de masa de Groenlandia','LineWidth',3)
xlabel('años','LineWidth',2)
ylabel('masa [Gt]')
grid on %para poner grilla
legend('masa Groenlandia')

%intentamos quitarle la tendencia a los datos para esto
%usamos detrend
BB=detrend(B); %cuando intentamos quitarle la tendencia a datos con nan
%no funciona el detrend es por eso que debemos
%quitarle la tendencia a C, que no tiene 
CC=detrend(C(:,2));
%Ahora plteamos
figure()
subplot 211
plot(BB(:,1),BB(:,2),'r','LineWidth',2)
title('mediciones de masa de Groenlandia','LineWidth',3)
xlabel('años','LineWidth',2)
ylabel('masa [Gt]')
grid on %para poner grilla
legend('masa Groenlandia')

subplot 212
plot(C(:,1),CC(:,1),'r','LineWidth',2)
title('mediciones de masa de Groenlandia, Sin tendencia','LineWidth',3)
xlabel('años','LineWidth',2)
ylabel('masa [Gt]')
grid on %para poner grilla
legend('masa Groenlandia')
 
mmvB =movmean(B(:,2),12,'omitnan');
stdmvB=movstd(B(:,2),12,'omitnan');
mmvCC =movmean(CC(:,1),12,'omitnan');
stdmvCC=movstd(CC(:,1),12,'omitnan');
B(:,3)= mmvB; %asi podemos graficar la media
B(:,4)= stdmvB;
C(:,3)=mmvCC;
C(:,4)=stdmvCC;
figure()
subplot 211
plot(B(:,1),B(:,2),'r','LineWidth',2)
hold on
plot(B(:,1),B(:,3),'g','LineWidth',1)
plot(B(:,1),B(:,3)+ B(:,4),'--b','LineWidth',1)
plot(B(:,1),B(:,3)- B(:,4) ,'--k','LineWidth',1)
title('mediciones de masa de Groenlandia','LineWidth',3)
xlabel('años','LineWidth',2)
ylabel('masa [Gt]')
grid on %para poner grilla
legend('masa Groenlandia','media','std+','std-')

subplot 212
plot(C(:,1),CC(:,1),'r','LineWidth',2)
hold on
plot(C(:,1),C(:,3),'g','LineWidth',1)
plot(C(:,1),C(:,3)+ C(:,4),'--b','LineWidth',1)
plot(C(:,1),C(:,3)- C(:,4) ,'--k','LineWidth',1)
title('mediciones de masa de Groenlandia','LineWidth',3)
xlabel('años','LineWidth',2)
ylabel('masa [Gt]')
grid on %para poner grilla
legend('masa Groenlandia','media','std+','std-')
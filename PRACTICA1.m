A = load('igreenland_mass.dat.txt'); %cargamos los datos
%A(1,:)=[]; %esto es para eliminar la primera fila
A(find(A==-999.9))= NaN; %reemplazamos los errores -999,9 por NaN
N=isnan(A); %posiciones de los nan

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
%Ahora graficamos B.
figure()
plot(B(:,1),B(:,2),'r','LineWidth',2)
title('mediciones de masa de Groenlandia','LineWidth',3)
xlabel('años','LineWidth',2)
ylabel('masa [Gt]')
grid on %para poner grilla
legend('masa Groenlandia')


%crear funciones para calcular, media, desviacion estandar y varianza. 
%luego compare con funciones de matlab.
%MIS FUNCIONES
m=MEAN(B(:,2));
s=STD(B(:,2));
VAR(B(:,2));

%funciones Matalb
nanmean(B(:,2))
nanstd(B(:,2))
nanvar(B(:,2))
%concluimos que las funciones si funcionan ajajsj
%ploteamos los estadisiticos
%como estos estadisticos no son moviles necesitamso hacer un vector de 240
%que tenga solo valor de media, std
entonces:
B(:,3)= m; %asi podemos graficar la media
B(:,4)= s; 
%ahora plotemos
figure()
plot(B(:,1),B(:,2),'r','LineWidth',2)
hold on
plot(B(:,1),B(:,3),'g','LineWidth',3)
plot(B(:,1),B(:,4)+ m,'b','LineWidth',3)
plot(B(:,1),B(:,3)- B(:,4) ,'k','LineWidth',3)
title('mediciones de masa de Groenlandia','LineWidth',3)
xlabel('años','LineWidth',2)
ylabel('masa [Gt]')
grid on %para poner grilla
legend('masa Groenlandia','media','std+','std-')

%ahora los estadisticos moviles
mmv =movmean(B(:,2),12,'omitnan');
stdmv=movstd(B(:,2),12,'omitnan');

B(:,5)= mmv; %asi podemos graficar la media
B(:,6)= stdmv;
figure()
plot(B(:,1),B(:,2),'r','LineWidth',2)
hold on
plot(B(:,1),B(:,5),'g','LineWidth',1)
plot(B(:,1),B(:,6)+ B(:,5),'--b','LineWidth',1)
plot(B(:,1),B(:,5)- B(:,6) ,'--k','LineWidth',1)
title('mediciones de masa de Groenlandia','LineWidth',3)
xlabel('años','LineWidth',2)
ylabel('masa [Gt]')
grid on %para poner grilla
legend('masa Groenlandia','media','std+','std-')

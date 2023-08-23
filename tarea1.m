%1: fechas y valores NaN
%Se creará una nueva base de datos de dos columnas, fechas y datos, se llamará A (¿qué original ha?
A =readmatrix("ANCUD.txt"); %leemos los datos como una matriz, los valores 
                            %con ***** los transforma a NaN
A(1:8,:)=[];%aqui eliminamos las filas que contienen los datos de 1999... ya que no los ulitizaremos 
            % y asi se nos facilitan algunas cosas

            
% recupere la información de fechas de la primera columna

B=A(:,1); %en el vector culumna B, solo almancenamos las fechas

%transformamos las fechas a año.fracciondeaño, trabajamos con B
% debemos quitar los meses y dejar solo los años

%utilizamos un ciclo for, donde transformamos la fecha a un str, para
%trabajrlo de esta forma, luego tomamos solo los digitos de la posicion 1 a
%la 4, de esta forma dejamos fuera los meses, y lo que nos resulta de esto
%lo transformamos nuevamente a numeros y los almacenamos en B.

for i=1:252 %aqui toamos el numero de filas de B, ej: i=1, tomamos la fila uno
     j=num2str(B(i));%aqui B(i) es una fecha y la transformamos en str, ej: j=num2str(B(1))='200001'
     B(i)=str2num(j(1:4));%aqui almacenamos en B solo los primeros 4 digitos de 'j', ej: B(1)= str2num('2000')=2000
end    

%ahora que solo tenemos los años podemos transformar las fechas a años.fraccion de año
n=0 ;
for i=1:length(B); 
        n=n+1
        B(n)= B(1)+(1/12/2)+(n-1)./12 ;%transformamos la fecha, con año.fraccion de año 
end  

A(:,1)=B; %reemplazamos la columna de fechas originales por la obtenida anteriormente



%2: Media y desviacion estandar.

%media, utilizamos la funcion nanmean.
media=nanmean(A(:,2));

%desviaciones estandar, utilizaremos la funcion nanstd.
desv_a= nanstd(A(:,2)); %primera desviacion estandar
desv_b= 2*desv_a; %segunda desviacion estandar
desv_c= 3*desv_a; %tercera desviacion estandar

%como la desviacion es con respecto a la media debemos restar y sumarle las
%diferentes desviaciones a la media, asi se representa mejor en el grafico
%que debemos hacer.

%suma y resta para la primera desviacion
suma_a= media + desv_a;
resta_a= media -desv_a;

%suma y resta para la segunda desviacion
suma_b= media + desv_b;
resta_b= media -desv_b;

%suma y resta para la tercera desviacion
suma_c= media + desv_c;
resta_c= media -desv_c;

%ahora para poder graficar debemos hacer un vector de 252 filas que
%contengan el valor de los estadisticos, para esto hacemos un ciclo for
for i=1:252
    me(i,1)=media;
    sum_a(i,1)=suma_a;
    res_a(i,1)= resta_a;
    sum_b(i,1)=suma_b;
    res_b(i,1)= resta_b;
    sum_c(i,1)=suma_c;
    res_c(i,1)= resta_c;
end  
P=[sum_a , res_a]; %primera desviacion respecto de la media
S=[sum_b , res_b];%segunda desviacion respecto de la media
T=[sum_c , res_c];%tercera desviacion respecto de la media

%ahora graficamos
figure()
plot(B,A(:,2),"k","LineWidth",3)%graficamos los datos originales
                                %B nos indica en el eje x, fechas 
                                %A(:,2) nos indica el eje y, datos
hold on %con este comando podemos hacer las demas graficas en una misma figura
plot(B,me,"r","LineWidth",2) %graficamos la media
plot(B,P,"g","LineWidth",2)%graficamos primera desviacion, con color y grosor requerido
plot(B,S,"--g","LineWidth",2)%graficamos segunda desviacion, con color y grosor requerido
plot(B,T,"-.g","LineWidth",2)%graficamos tercera desviacion, con color y grosor requerido
xlabel('Años') %nombre al eje x
xlim([2.000041666666667e+03  2.021000000000000e+03 ]) %limites del eje x
ylabel('Datos') %nombre al eje y
title('Datos y estadísticos del nivel del mar frente a Ancud') %titulo del grafico
legend('Datos','Media','1ª std','2ª std','3ª std') %leyenda
%------------------------------------------------------------------------------------------
%3: media y desviacion estandar movil
AA=A(~isnan(sum(A,2)),:); %Con esto limpio un poco mis datos quitando los valores NaN
% Calcular una media móvil de ;ventana de 13 y 25 meses.
mediamov_a=movmean(AA(:,2),13,'Endpoints','discard'); %Con 'endpoints' y 'discard' logro que al ocupar la
                                                      %funcion movmean se
                                                      %pierdan los datos
                                                      %requeridos
mediamov_fecha=movmean(AA(:,1),13,'Endpoints','discard');%calculo la mm a las fechas, asi puedo localizar las fechas a la mitad de la ventana
%repito lo anterior, pera esta vez con una ventana de 25
mediamov_b=movmean(AA(:,2),25,'Endpoints','discard');
mediamov_fechb=movmean(AA(:,1),25,'Endpoints','discard');

%Calcular una desviación estándar móvil de 25 meses
stdmovil=movstd(AA(:,2),25, 'Endpoints','discard'); %calculo la desviacion estandar movil
% como sabemos la desviacion estandar es con respecto a la media por lo
% tanto debemos, restar y sumar la stdm a la mm
restamovil= mediamov_b - stdmovil ;
sumamovil=mediamov_b + stdmovil ;

P_mov=[sumamovil , restamovil]; %primera std movil respecto de la media

%A
%ahora graficamos, localizando la fecha a la mitad de la ventana.
figure()
plot(AA(:,1),AA(:,2),"k","LineWidth",3)

hold on
plot(mediamov_fecha,mediamov_a,"r","LineWidth",2)
plot(mediamov_fechb,mediamov_b,"g","LineWidth",2)
plot(mediamov_fechb,P_mov,"-.g","LineWidth",2)
xlabel('Años')
xlim([2.000041666666667e+03  2.021000000000000e+03 ]) %limites del eje x
ylabel('Datos')
title('Datos y estadísticos del nivel del mar frente a Ancud')
legend('Datos','Mediamov,13','Mediamov,25','stdmovil,25')

%-----------------------------------------------------------------------------------
%B
%ahora debemos hacer un grafico donde  la fecha de estar localizada al
%final de la ventana, para lograr esto debemos acortar el vector de tiempo
%al inicio, es decir sacarle al vector de tiempo los datos del inicio.

L=AA(:,1); 
L(1:12,:)=[] %aqui acorto el vector tiempo al inicio, le quito 12 fechas, que 
% son la cantidad de datos que pierdo cuando calculo la mm con ventana de 13 a AA
O=AA(:,1);
O(1:24,:)=[]  %aqui acorto el vector tiempo al inicio, le quito 24 fechas, que 
% son la cantidad de datos que pierdo cuando calculo la mm y stdm con ventana de 25 a AA

%ahora graficamos, localizando la fecha al final de la ventana.
figure()
plot(AA(:,1),AA(:,2),"k","LineWidth",3)

hold on
plot(L,mediamov_a,"r","LineWidth",2)
plot(O,mediamov_b,"g","LineWidth",2)
plot(O,P_mov,"-.g","LineWidth",2)
xlabel('Años')
xlim([2.000041666666667e+03  2.021000000000000e+03 ]) %limites del eje x
ylabel('Datos')
title('Datos y estadísticos del nivel del mar frente a Ancud')
legend('Datos','Mediamov,13','Mediamov,25','stdmovil,25')
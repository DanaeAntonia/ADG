A=readmatrix('iN_ice_extent.dat.txt');
A(1,:)=[]; 
A(end,:)=[];
%encontramos los datos que contienen -999.9 con find, y reemplazamos por
%NaN
A(find(A==-999.9))= NaN;
AA=sinNaN(A);
%
%
figure()
plot(AA(:,1),AA(:,3),'r')
hold on
plot(AA(:,1),AA(:,6),'g')
%
%%correlacon
rho=corr(A(:,3),A(:,6),'row','complete');
%calculamos S-->distancia
N=length(A(:,6));
S= sqrt((1-rho^2)/(N-2));
%
%Calculamos t
t=rho/S ;

%ahora sin pendiendte, es decir sin tendencia
BB=detrend(A);
%%correlacon
rho_B=corr(BB(:,3),BB(:,6),'row','complete');
%calculamos S-->distancia
N=length(BB(:,6));
S_B= sqrt((1-rho_B^2)/(N-2));
%
%Calculamos t
t_B=rho_B/S_B ;
%
%cortamos a la mitad el vector
AA=A(1:21,:);
rho_AA=corr(AA(:,3),AA(:,6),'row','complete');
%calculamos S-->distancia
N_AA=length(AA(:,6));
S_AA= sqrt((1-rho_AA^2)/(N_AA-2));
%
%Calculamos t
t_AA=rho_AA/S_AA ;

%ahora sin pendiendte, es decir sin tendencia
Bb=detrend(AA);
%%correlacon
rho_Bb=corr(Bb(:,3),Bb(:,6),'row','complete');
%calculamos S-->distancia
N_Bb=length(Bb(:,6));
S_Bb= sqrt((1-rho_Bb^2)/(N_Bb-2));
%
%Calculamos t
t_Bb=rho_Bb/S_Bb ;
%
%
%
R=RelE(A(:,3),A(:,6));
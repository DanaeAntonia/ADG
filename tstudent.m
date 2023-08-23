%funcion para calcular t
%out-->rho-->correlacion
%n->grados de libertad
%t-->t que miraremos en la taba de t-studentes
%si la correlacion es negativa las dos variables estan asociadas en sentido
%inverso
%NC--->nivel de confianza
function [rho,n,t,alpha]=tstudent(S1,S2,NC)
rho=corr(S1,S2,'rows','complete');%por si tenemos NaN
nn=length(S1);
n=nn-2;%grados de libertad
s=sqrt((1-(rho)^2)/(n));%distancia
t=abs(rho/s); 
alpha=(100-NC)/(100*2);
end

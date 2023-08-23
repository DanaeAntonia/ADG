%Esta funcion sirve para calcular "a lo antiguo"
%S-->distancia
%rho-->correlacion
%t-->parametro para mirar en la tabla
%se usa: RelE(x,y), donde x,y--> son vectores
function [rho,S,t]= RelE(x,y)
rho=corr(x,y,'row','complete')
N=length(x);
S=sqrt((1-rho^2)/(N-2))
t=rho/S 
end


%necesito hacer otra esta esta mala!!

function y = mediamovil(x,m)
%x es vector con datos
%m es el parametro
x(isnan(x))= 0; %transformo nan a 0
x(x==0)=[]; %elimino los ceros
a=2/(m+1);%calculo alfa
n=length(x);
sum=0;
%formula para calcular media movil exponencial.
for  i=[1:1:n]
for k=[0:1:n]
b = i-k;
   if b>0
     sum= sum + a*(1-a).^k *x(b);
     y(i)=sum;
   end 
end
end
end
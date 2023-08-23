%% Ejercicio 1
A=load('iglobal_copernicus_sla_a.txt'); %nivel del mar global
X=A(:,2);
for t=2:343;
    B(t)=X(t)-X(t-1);
end
b=B'; %diferenciacion
%
%Realizamos un plot
figure()
plot(A(:,1),X,'r') %original
hold on
plot(A(:,1),b,'b') %diferenciacion
legend('serie original','serie diferenciada','Location','northwest')
xlabel('Años');
ylabel('Nivel del mar [m]')
grid on
set(gcf,'color','w')
title('Diferenciación Y(t)=X(t)-X(t-1)') 
%
%% Ejercicio 2
%utilizamos la funcion filtro.m creada.
alpha=[0.1,0.2,0.5,0.7,0.9];
for a=1:5;
    Y(:,a)=filtro(X,alpha(a)); %obtenemos una matriz que en cada fila tenemos los
                                %datos filtrados para cada alpha
end
Y1=filtro(X,0.1)
%ahora creamos nuestro subplot
figure()
subplot 231
plot(A(:,1),X,'r') %original
hold on
plot(A(:,1),Y(:,1),'b') %filtro,a=0.1
legend('Serie original','Serie filtrada','Location','northwest')
xlabel('Años');
ylabel('Nivel del mar [m]')
title('Filtro Y(t)=\alpha x(t)+(1-\alpha) Y(t-1) con \alpha =0.1')
grid on
%
subplot 232
plot(A(:,1),X,'r') %original
hold on
plot(A(:,1),Y(:,2),'b') %filtro,a=0.2
legend('Serie original','Serie filtrada','Location','northwest')
xlabel('Años');
ylabel('Nivel del mar [m]')
title('Filtro Y(t)=\alpha x(t)+(1-\alpha) Y(t-1) con \alpha =0.2')
grid on
%
subplot 233
plot(A(:,1),X,'r') %original
hold on
plot(A(:,1),Y(:,3),'b') %filtro,a=0.5
legend('Serie original','Serie filtrada','Location','northwest')
xlabel('Años');
ylabel('Nivel del mar [m]')
title('Filtro Y(t)=\alpha x(t)+(1-\alpha) Y(t-1) con \alpha =0.5')
grid on
%
subplot 234
plot(A(:,1),X,'r') %original
hold on
plot(A(:,1),Y(:,4),'b') %filtro,a=0.7
legend('Serie original','Serie filtrada','Location','northwest')
xlabel('Años');
ylabel('Nivel del mar [m]')
title('Filtro Y(t)=\alpha x(t)+(1-\alpha) Y(t-1) con \alpha =0.7')
grid on
%
subplot 235
plot(A(:,1),X,'r') %original
hold on
plot(A(:,1),Y(:,5),'b') %filtro,a=0.9
legend('Serie original','Serie filtrada','Location','northwest')
xlabel('Años');
ylabel('Nivel del mar [m]')
title('Filtro Y(t)=\alpha x(t)+(1-\alpha) Y(t-1) con \alpha =0.9')
grid on
set(gcf,'color','w')

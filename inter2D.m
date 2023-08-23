%%FUNCION PARA sinNaN mediante metodo 1 de interpolacion
%funcion para interpolar 2D por metodo de filas y columnas 
%p1-->peso filas-->uno lo asigna
%p2-->peso columnas--->uno lo asigna
function matriz_interp=inter2D(matriz,p1,p2)
[i,j] = find(isnan(matriz));%Localizamos las posiciones de los nan
P=[i,j];%posiciones de los NaN's
%antes de hacer el ciclo for duplicaremos nuestra matriz original para no
%perder esos datos
matriz_interp=matriz;
for i=1:length(P(:,1))
  matriz_interp(P(i),P(i,2))=p1*mean(matriz_interp(P(i),:),'omitnan')+p2*mean(matriz_interp(:,P(i,2)),'omitnan'); 
end

end

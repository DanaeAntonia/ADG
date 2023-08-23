%funcion para hacer un filtro para ventana rectangular 
%rectangular(ventana,datos)
function [R,rwn]= rectangular(ventana,datos)
rw=rectwin(ventana);
 rwn=rw/sum(rw); %vector de pesos
 %teniendo entonces rwn-->que sera mi b y x-->datos2 , y tomamos a=1
 %utilizamos funcion filtfilt
 R=filtfilt(rwn,1,datos);
end

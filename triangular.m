%funcion para calcular ventana triangular y crear filtro con filtfilt
%triangular(ventana,datos)
function T=triangular(ventana,datos)
tw=triang(ventana);
 twn=tw/sum(tw); %vector de pesos(normalizamos vector)
 %teniendo entonces rwn-->que sera mi b y x-->datos2 , y tomamos a=1
 %utilizamos funcion filtfilt
 T=filtfilt(twn,1,datos);
end
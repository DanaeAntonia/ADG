%funcion para calcular ventana gaussiana y crear filtro con filtfilt
%gauss(ventana,datos)
function [G_B,G_A]= gaussFILTRO(ventana,datos)
gw=gausswin(ventana);
 gwn=gw/sum(gw); %vector de pesos(normalizamos vector)
 %teniendo entonces rwn-->que sera mi b y x-->datos2 , y tomamos a=1
 %utilizamos funcion filtfilt
 G_B=filtfilt(gwn,1,datos);
 G_A=datos-G_B;
end
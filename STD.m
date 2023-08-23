function std = STD(datos)
datos(isnan(datos))= 0; %transformo nan a 0
datos(datos==0)=[]; %elimino los ceros
M=mean(datos);
std= (sum((datos - M).^2)/length(datos))^(1/2)
end
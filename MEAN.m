function media= MEAN(datos)
datos(isnan(datos))= 0; %transformo nan a 0
datos(datos==0)=[]; %elimino los ceros
media= sum(datos)/length(datos)
end    
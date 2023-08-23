function interpolada = interp2D_cuadrada(matriz,p1,p2) %Programa que funciona para matriz cuadrada y nan en el medio...
[i,j] = find(isnan(matriz)); %Localizamos las posiciones de los nan
m_aux = matriz; %Necesitamos una variable auxiliar para hacer modificaciones a la matriz sin perder la matriz original
[f,~] = size(m_aux); %Conseguimos las filas
promedios = []; %Un arreglo que tendra los promedios de las distintas cajas
n = 0;
for k = 1 : round(f/2) - 1 %De 1 hasta el tamaño máx de los cuadrados 5 filas --> solo 2 cuadrados
    aux = m_aux(i-k:i+k,j-k:j+k); %Conseguimos los valores antes de hacerlos NaN
    m_aux(i-1:i+1,j-1:j+1) = NaN; %Hacemos el primer cuadrado a promediar NaN   
    promedios = [promedios mean(aux(:),'omitnan')]; %lo promediamos y almacenamos en la posicion k
    n = n+1;
end
matriz(i,j) = promedios(1)*p1 + promedios(2)*p2;
interpolada = matriz;
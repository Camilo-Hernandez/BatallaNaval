function graf = generarGrafica(Mapa, Area, mostrar_barcos)
    %% Esta funcion genera las graficas basadas en matrices con
    % valores nulos y no nulos
    % Es decir, graf es la representacion grafica de los tableros
    % Recibe la matriz cuadrada, su dimension y un booleano que dice si se
    % muestran o no los barcos (elementos no nulos)
    %% Generacion del mapa
    figure('Name',['Batalla Naval: ',inputname(1)],'NumberTitle','off'); grid on; hold on;
    graf = gca;     % Crear la variable 'ax' con todas las propiedades de los ejes
    title(['Batalla Naval: ',inputname(1)],'Color','b','FontSize',17)  % Titulo color azul, tamano 17
    %% Estética del mapa
    graf.Color = [0.0745 0.6235 1.0000];  % Backgroud del mapa (Azul del agua)
    graf.GridColor ='w';                  % Color del Grid (líneas de cuadricula)
    graf.GridAlpha = 0.9;                 % Grosor del Grid (0.9 puntos)
    %% Configuracion de los ejes X e Y
    % Se pone el eje X en la parte de arriba y el eje Y positivo hacia abajo
    set(graf,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
    % Poner limites de 1 a 'Area' y quitar las marcas numericas predeterminadas en las lineas
    set(graf,'ylim',[1 Area+1],'ytick',1:Area+1, 'yticklabels',[])
    set(graf,'xlim',[1 Area+1],'xtick',1:Area+1, 'xticklabels',[])
    
    %% Texto de filas y columnas
    % Funcion 'text' recibe los primeros 3 valores obligatorios
    %          text(vector de las posiciones X,
    %               vector de las posiciones Y,
    %               texto deseado,
    %               'Nombre de atributo adicional',
    %               Valor del atributo adicional anterior)
    % Se usa 'text' para poner los numeros a la izquierda y las letras debajo
    % con tamano 17 centradas en los cuadros
    % Se usa la funcion 'char' para convertir un arreglo de enteros a
    % caracteres segun el cod ASCII, y 'upper' para ponerlos en mayusculas.
    text(0.6*ones(Area,1), 1.5:1:Area+1, num2str((1:Area)'), ...
         'horizontalalign','center', 'FontSize',17)
    text(1.5:1:Area+1, (Area+1.4)*ones(1,Area), upper(char(97:97+Area-1)'), ...
         'horizontalalign','center', 'FontSize',17)
    %% Exponer los barcos en el mapa de oceano
    if mostrar_barcos
        % Obtener las posiciones de los barcos
        [X,Y] = find(Mapa);
        X=X';Y=Y';
        Y(2,:) = Y(1,:)+1;
        Y(3,:) = Y(1,:)+1;
        Y(4,:) = Y(1,:);
        X(2,:) = X(1,:);
        X(3,:) = X(1,:)+1;
        X(4,:) = X(1,:)+1;
        patch(Y, X,[1 0.4118 0.1608])
    end
end
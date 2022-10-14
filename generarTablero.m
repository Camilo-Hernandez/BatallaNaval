function tablero = generarTablero(Area,eleccion)
    %% Esta funcion genera una matriz con los barcos puestos de forma aleatoria
    % 'eleccion' es el vector que dice cuales barcos usar
    % Por tanto, length(eleccion) dice cuantos barcos usar
    eleccion=sort(eleccion); % TODO mantener únicos
    longitudes = eleccion;
    orientaciones = randi(2,[1 length(eleccion)]);
    %% Ciclo de creacion
    while true
        reiniciar = 0;                  % Bandera que indica si se reinicia el proceso de creacion
        tablero = zeros(Area);          % Generacion de la matriz
        inicios = randi(Area,[length(eleccion) 2]);  % Matriz 1x2xcantidad de barcos con los nodos iniciales de los 3 barcos
        finales = zeros([length(eleccion) 2]);         % Matriz 1x2xcantidad de barcos que contendrá los 3 nodos finales
        %% Ciclo que calcula la matriz de nodos finales
        for i=1:length(longitudes)
            % Si la orientación es vertical
            if orientaciones(i)==1
                % Suma la longitud a la coordenada de la fila en 'inicios',
                % mantiene la columna intacta
                finales(i,1)=inicios(i,1)+longitudes(i)-1;
                finales(i,2)=inicios(i,2);
            % Si la orientación es horizontal
            else
                % Suma la longitud a la coordenada de la columna en 'inicios'
                % mantiene la fila intacta
                finales(i,1)=inicios(i,1);
                finales(i,2)=inicios(i,2)+longitudes(i)-1;
            end
        end
        %% Condición que verifica si se salen la matriz.
        % Si cualquier barco lo hace, reinicia el ciclo while con el
        % continue
        if any(any(finales>Area))
            continue
        end
        %% Ciclo que llena la matriz siempre y cuando no se solapen barcos
        % Si se solapan, se reinicia el ciclo while usando la bandera
        % "reiniciar"
        for barco=1:length(longitudes)    % Recorrer la cantidad de barcos
            if ~any( tablero(inicios(barco,1):finales(barco,1),inicios(barco,2):finales(barco,2)) )
                tablero(inicios(barco,1):finales(barco,1),inicios(barco,2):finales(barco,2))=eleccion(barco);
            else
                reiniciar = 1;
                break   % Se debe salir del ciclo for primero para reiniciar el while
            end
        end
        %% Condicion que verifica si se sale del ciclo while usando la
        % bandera "reiniciar".
        if ~reiniciar, break, end
    end
end
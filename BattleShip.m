%% Juego: Batalla Naval
%{
    Descripcion del juego:
    El jugador y la maquina compiten por aniquilar los 3 barcos del otro.
    En pantalla se mostrarán la representación gráfica de 
    los 2 tableros que utiliza el jugador, que son el tablero de tiro
    y el tablero de oceano.
    Los "tableros" son en realidad 2 matrices de iguales dimensiones que
    contienen numeros enteros: 0 si no hay barco en esa posición,
    o 3, 4 y 5 si hay segun la longitud.
    Los 3 barcos se posicionan aleatoriamente sobre los mapas de ambos
    competidores de manera vertical u horizontal y no se solapan.
    Por turnos, el usuario ingresa por teclado las coordenadas de a donde
    quiere atacar a la maquina y sus ataques se muestran en su tablero de tiro,
    mientras que los ataques de la maquina son aleatorios y se muestran en el
    mapa del oceano del jugador.
    Se dibuja un cuadro Naranja y una X si acierta.
    O un cuadro Cian si falla.
%}
clc; clearvars; close all;
%% 1. Inicio y escogencia del tamaño de las matrices.
disp ('Bienvenido a Batalla Naval')
fprintf (['Elija la dificultad: \n'...
        '1. Facil (matriz 8x8) \n'...
        '2. Media (matriz 9x9) \n'...
        '3. Dificil (matriz 10x10) \n']);
dificultad = input('');
Area = 7 + dificultad; % Area es el largo y ancho de la matriz y representa la dificultad
fprintf(['\nElija los barcos que desea. Presione cualquier otro numero para terminar la eleccion. \n'...
    '3. Lancha (3) \n4. Acorazado (4) \n5. Porta-Aviones (5)\n'])
for i=1:3
    e = input('','s');
    if length(e)>1 || all(double(e)-48 ~= [3 4 5]); break; end
    eleccion(i) = double(e)-48;
end
%% 2. Generación aleatoria de los 2 mapas de juego
% Se usa una función porque se repite código
MapaOceano = generarTablero(Area,eleccion);
MapaTiro = generarTablero(Area,eleccion);
% El tablero de tiro del jugador es el mismo mapa de océano de la máquina pero con
% los barcos ocultos, y viceversa.

%% 3. Generacion del Mapa gráfico (Axes o plot)
GrafTiro = generarGrafica(MapaTiro,Area,false);
GrafOceano = generarGrafica(MapaOceano,Area,true);

%% 4. Desarrollo del juego: disparos por turnos entre el jugador y la máquina
fprintf (['\nAzul oscuro: agua no seleccionada \n'...
        'Azul claro: golpe fallido \n'...
        'Naranja: ataque exitoso. \n'...
        '\nFilas: entre 1 y ', num2str(Area), '\n'...
         'Columnas: entre A y ', upper(char(Area+96)), '\n'...
         '\n¡DISPARA! \n']);

DisparosU = 0; % Contador de disparos totales del usuario
AciertosU = 0; % Contador de aciertos del usuario
DisparosM = 0; % Contador de disparos totales de la maquina
AciertosM = 0; % Contador de aciertos de la maquina
% Ciclo while del desarrollo:
% Se ejecuta mientras cualquier elemento del MapaOceano sea ~=0
% O sea, mientras aun hayan barcos por aniquilar
% Funcion 'any' devuelve 1 si algun elemento del vector cumple la condicion, 0 si no.
while any(any(MapaTiro ~= 0)) && any(any(MapaOceano ~= 0))
    % Turno del usuario
    UserX = input('Fila: ');
    UserY = double(lower(input('Col: ','s'))-96);
    % Comprobacion del disparo
    if abs(UserX)>Area || abs(UserY)>Area
        disp('Fuera del mapa.')
        continue
    end
    DisparosU = DisparosU + 1;
    [MapaTiro,AciertosU] = dibujarDisparos(GrafTiro,MapaTiro,UserX,UserY,AciertosU);

    % Turno de la maquina con tiros aleatorios
    MachineX = randi(Area);
    MachineY = randi(Area);
    DisparosM = DisparosM + 1;
    [MapaOceano,AciertosM] = dibujarDisparos(GrafOceano,MapaOceano,MachineX,MachineY,AciertosM);
    
    continuar = lower(input('Continue? S/N ','s'));
    if lower(continuar)=='n'; break; end
end
%% 5. Terminación del juego: mostrar un mensaje de felicitaciones + cantidad de Disparos
PuntuacionU = 100*AciertosU/DisparosU;
PuntuacionM = 100*AciertosM/DisparosM;
if PuntuacionU>PuntuacionM
    Ganador = 'Usted';
else
    Ganador = 'la Maquina';
end

% En pantalla
disp('\n\n¡Felicitaciones!.')
disp(['Tus disparos: ',num2str(DisparosU)])
disp(['Tus aciertos: ',num2str(AciertosU)])
disp(['Disparos de la maquina: ',num2str(DisparosM)])
disp(['Aciertos de la maquina: ',num2str(AciertosM)])
disp(['El ganador es: ',Ganador])
disp('Juego terminado')

% En Mensaje emergente:
% 2 lineas de String puestas como elementos de una celda
% Titulo 'Juego terminado'. Simbolo de informacion 'help'
msgbox({'¡Felicidades! Completaste el mapa',...
    ['Tus disparos: ',num2str(DisparosU)],...
    ['Tus aciertos: ',num2str(AciertosU)],...
    ['Disparos de la maquina: ',num2str(DisparosM)],...
    ['Aciertos de la maquina: ',num2str(AciertosM)],...
    ['El ganador es: ',Ganador]},...
    'Juego terminado','help')

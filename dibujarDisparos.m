function [mapa,aciertos] = dibujarDisparos(graf,mapa,x,y,aciertos)
    % Dibuja los shots hechos por el usuario y la maquina
    % Con cyan los tiros fallidos y naranja los tiros acertados.
    % Ademas, a los acertados, les traza una X.
    if mapa(x,y) == 0     % Falla: dibuja cuadro cian en el mapa
        patch(graf,[y y+1 y+1 y], [x x x+1 x+1],'c')
    else    % Acierta: dibuja cuadro naranja en el mapa
        patch(graf,[y y+1 y+1 y], [x x x+1 x+1],[1 0.4118 0.1608])
        plot(graf,[y  y+1], [x  x+1], ':b', 'Linewidth',1.5)
        plot(graf,[y  y+1], [x+1  x], ':b', 'Linewidth',1.5)
        mapa(x,y) = 0;    % Elemento = 0
        aciertos = aciertos+1;
    end
end
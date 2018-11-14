% Inicialmente determina-se o valor mnimo lido para cada variavel e subtrai-se esse
% valor dos dados correspondentes. Desse modo, os valores de cada variavel
% que estavam contidos no intervalo [valormin, valormax] passam a estar contidos no intervalo
% [0, valormax - valormin].
%  Em seguida, divide-se o valor dos dados pela faixa de variac~ao correspondente, ou
% seja, divide-se cada valor por (valormax - valormin). Assim, os valores de todas as
% variaveis ficam contidos no intervalo [0, 1].
function [] = dadoNormalizado(rawData)
clc;close all;

size_o = size(rawData,1);
minimo = min(rawData);
maximo = max(rawData);

for i = 1:size_o;
     aux(i,1) = rawData(i)-minimo(1,1);
     aux(i,2)=  rawData(i,2)-minimo(1,2);
end

for j = 1:size_o
    rawDataKN(j,1) = aux(j)/(maximo(1,1)-minimo(1,1)) ;
    rawDataKN(j,2)=  aux(j,2)/(maximo(1,2)-minimo(1,2));
end

figure;
plot(rawData(:,1), rawData(:,2), 'r.' );
figure;
plot(rawDataKN(:,1), rawDataKN(:,2), 'b.' );

save ('rawDataKN.mat','rawDataKN');
end
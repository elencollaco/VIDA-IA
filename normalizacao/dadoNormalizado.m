% Inicialmente determina-se o valor mnimo lido para cada variavel e subtrai-se esse
% valor dos dados correspondentes. Desse modo, os valores de cada variavel
% que estavam contidos no intervalo [valormin, valormax] passam a estar contidos no intervalo
% [0, valormax - valormin].
%  Em seguida, divide-se o valor dos dados pela faixa de variac~ao correspondente, ou
% seja, divide-se cada valor por (valormax - valormin). Assim, os valores de todas as
% variaveis ficam contidos no intervalo [0, 1].

clear all;clc;close all;
load iris.mat;

size_o = size(iris,1);
minimo = min(iris);
maximo = max(iris);

for i = 1:size_o;
     aux(i,1) = iris(i)-minimo(1,1);
     aux(i,2)=  iris(i,2)-minimo(1,2);
end

for j = 1:size_o
    irisKN(j,1) = aux(j)/(maximo(1,1)-minimo(1,1)) ;
    irisKN(j,2)=  aux(j,2)/(maximo(1,2)-minimo(1,2));
end

figure;
plot(iris(:,1), iris(:,2), 'r.' );
figure;
plot(irisKN(:,1), irisKN(:,2), 'b.' );

save ('irisKN.mat','irisKN');

%Opção analisar pontos finais (x,y,z e rotações ou tempo)

AbrirTrajsPadronizadas;
PontosFinais = extraiPontosFinais(dados);
%xyF = dadoNormalizado(PontosFinais(:, 2:3));
xyF = PontosFinais(:, 3:4);

%Opção analisar informações da punção(punçãoX, punçãoY, punçãoZ, angulo,
%tempo)

%AbrirPuncsPadronizadas;
%DadosPunc = extraiInfoPunc(dados1, 4, 5);
%DadosPunc(:, 2) = DadosPunc(:, 2) + 1;
%xyF = log(DadosPunc);

%DadosPunc = extraiInfoPunc(dadosProf, 4, 5);
%teste = dadoNormalizado(DadosPunc);


xybarra = mean(xyF);

S = cov(xyF);
Sinv = inv(S);

t2 = mahal(xyF, xyF);

figure;
scatter(t2, t2);
title('Distâncias de Mahalanobis');
figure;
%plot(t2);
%title('Teste de confiança');

% Calcula os numeros importantes para o T2
n = size(xyF, 1);        %numero de amostras
p = size(xyF, 2);        %numero de variáveis independentes

% Plota a elipse de intervalo de confiança  alpha
elipse = elipseConf(n, p, xybarra, S, 0.95);
plot(elipse(1, :), elipse(2, :), 'r');
malTeste = zeros(size(elipse, 2), 1);
for i=1: size(elipse, 2)
    malTeste(i) = sqrt((elipse(:, i) - xybarra')'*Sinv*(elipse(:, i) - xybarra'));
end
hold on;

elipse = elipseConf(n, p, xybarra, S, 0.9);
plot(elipse(1, :), elipse(2, :), 'g');
hold on;

elipse = elipseConf(n, p, xybarra, S, 0.99);
plot(elipse(1, :), elipse(2, :), 'k');
hold on;
scatter(xyF(:, 1), xyF(:, 2), 'm');
legend('95% conf', '90% conf', '99% conf', 'Pontos XY Profs', 'Pontos XY Aluno');
hold off;



function y = extraiPontosFinais(trajs)
    y = zeros(size(trajs, 2), size(trajs(1).dados, 2));
    for i = 1:size(trajs, 2)
        y(i, :) = trajs(i).dados(end, :);
    end
end

function elipse = elipseConf(n, p, xbar, sigmachapeu, conf) 
    theta = linspace(0, 2*pi, 100);

    elipse = zeros(2, 100);
    for i = 1:100
        elipse(:,i) = xbar' + sqrt((p*(n-1)/(n-p))*(1+1/n)*finv(conf, p, n-p))*chol(sigmachapeu)'*[cos(theta(i)); sin(theta(i))];
    end
end

function xy = extraiInfoPunc(dados, a, b)
    xy = zeros(size(dados, 2), 2);
    for i = 1: size(dados, 2)
        xy(i, 1) = dados(i).dados(a);
        xy(i, 2) = dados(i).dados(b);
    end
end
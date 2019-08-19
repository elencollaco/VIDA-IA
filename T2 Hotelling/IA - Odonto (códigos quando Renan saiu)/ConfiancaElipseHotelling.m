%estrutura de dados usada ==
%cada usuário tem
%usuario.dados = sua trajetória organizada em colunas na sequência 
%t, X(t), Y(t), Z(t), RotX(t), RotY(t), RotZ(t)
%posições em metros e rotações em graus
%usuario.nome com o código do usuario naquele experimento (não utilizado
%nesse código do T2Hotelling)


%PontosFinais = extraiPontosFinais(dados);
%x = PontosFinais(2:3, :);  %Por enquanto testando apenas com os Pontos X e Y
x = [-.9 .2; 2.4 .7; -1.4 1; 2.9 -.5; 2 -1];

% Calcula os numeros importantes para o T2
n = size(x, 1);        %numero de amostras
p = size(x, 2);        %numero de variáveis independentes


% Calcula a média observada(será o centro da elipse)
xbar = mean(x);


% Calcula a matriz de covariância observada (sigma)
sigma = cov(x);

% Plota a elipse de intervalo de confiança  alpha
alpha = 0.95;
theta = linspace(0, 2*pi, 100);

elipse = zeros(2, 100);
for i = 1:100
    elipse(:,i) = xbar' + sqrt((p*(n-1)/(n-p))*(1+1/n)*finv(alpha, p, n-p))*chol(sigma)*[cos(theta(i)); sin(theta(i))];
end
plot(elipse(1, :), elipse(2, :));
hold;
plot(x(:, 1), x(:, 2), 'x');




function y = extraiPontosFinais(trajs)
    y = zeros(size(trajs, 2), size(trajs(1).dados, 2));
    for i = 1:size(trajs, 2)
        y(i, :) = trajs(i).dados(end, :);
    end
end


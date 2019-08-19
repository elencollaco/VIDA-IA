%estrutura de dados usada ==
%cada usu�rio tem
%usuario.dados = sua trajet�ria organizada em colunas na sequ�ncia 
%t, X(t), Y(t), Z(t), RotX(t), RotY(t), RotZ(t)
%posi��es em metros e rota��es em graus
%usuario.nome com o c�digo do usuario naquele experimento (n�o utilizado
%nesse c�digo do T2Hotelling)


%PontosFinais = extraiPontosFinais(dados);
%x = PontosFinais(2:3, :);  %Por enquanto testando apenas com os Pontos X e Y
x = [-.9 .2; 2.4 .7; -1.4 1; 2.9 -.5; 2 -1];

% Calcula os numeros importantes para o T2
n = size(x, 1);        %numero de amostras
p = size(x, 2);        %numero de vari�veis independentes


% Calcula a m�dia observada(ser� o centro da elipse)
xbar = mean(x);


% Calcula a matriz de covari�ncia observada (sigma)
sigma = cov(x);

% Plota a elipse de intervalo de confian�a  alpha
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


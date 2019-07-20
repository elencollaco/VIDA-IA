%Script que aprende o padr�o de um grupo de refer�ncia e assim categoriza os outros por
%meio da dist�ncia de Mahalanobis entre o grupo refer�ncia ("especialista") 
%e o testado

%Experimento Bauru foi categorizado em 3: Especialistas (Aluno/professor
%formado que passou pela disciplina de anesteseologia), N�o Especialistas
%(fora da �rea de odonto) e Alunos 1�ano

%Experimento SP foi categorizado em 5: 4(), 5(), 6(), 7(), 8()
%Para ver como est�o organizados � so abrir as tabelas participantesSP e 
%participantesBauru depois de rodar o c�digo


pastadados = 'C:\Users\samsung\Desktop\IA - Odonto\Dados\'; %� preciso atualizar a pasta em que os dados estao
load(strcat(pastadados, 'participantesSP.mat'));
load(strcat(pastadados, 'participantesBauru.mat'));


grupoRef = 'Specialist';
linhasRef = (participantesBauru.Amostra == grupoRef) & (participantesBauru.NotaDistancia > 6);
dadosRef = participantesBauru{linhasRef, 6:7};


% Calcula os numeros importantes para o T2
medias = mean(dadosRef);
S = cov(dadosRef);
Sinv = inv(S);
n = size(dadosRef, 1);        %numero de amostras
p = size(dadosRef, 2);        %numero de vari�veis independentes

confs = [0.5 0.7 0.9];  %3 limiares escolhidos testando

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
cmap = colormap(hsv(length(confs)));
%Loop desenha as regi�es de confian�a (elipses)
for i = 1:length(confs)
    elipse = elipseConf(n, p, medias, S, confs(i));
    plot(elipse(1, :), elipse(2, :), 'Color', cmap(i, :));
    hold on;
end
plot(dadosRef(:,1), dadosRef(:,2), 'x');
xlabel('X [mm]');
ylabel('Z [mm]');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dadosTestados = participantesSP{:, 2:3};
cores = zeros(size(dadosTestados, 1), 3);

%Printa os dados testados (a partir do padr�o da distribui��o dos dadosRef)
for i = 1:size(dadosTestados, 1)
    dist = mahal(dadosTestados(i, :), dadosRef); 
    if (dist < (p*(n-1)/(n-p))*(1+1/n)*finv(confs(1), p, n-p)) %Essa � a dist�ncia m�xima de mahalanobis (elipse) que confs(1) imp�e
        cores(i, :) = cmap(1, :);
    elseif(dist < (p*(n-1)/(n-p))*(1+1/n)*finv(confs(2), p, n-p))
        cores(i, :) = cmap(2, :);
    elseif(dist < (p*(n-1)/(n-p))*(1+1/n)*finv(confs(3), p, n-p))
        cores(i, :) = cmap(3, :);
    else
        cores(i, :) = [0 0 0];
    end
end

scatter(dadosTestados(:,1), dadosTestados(:,2), 60, cores);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fun��o que cria as elipses a partir das informa��es importantes da
%distribui��o
function elipse = elipseConf(n, p, xbar, sigmachapeu, conf) 
    theta = linspace(0, 2*pi, 100);

    elipse = zeros(2, 100);
    for i = 1:100
        elipse(:,i) = xbar' + sqrt((p*(n-1)/(n-p))*(1+1/n)*finv(conf, p, n-p))*chol(sigmachapeu)'*[cos(theta(i)); sin(theta(i))];
    end
end
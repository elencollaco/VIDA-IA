%Script que aprende o padrão de um grupo de referência e assim categoriza os outros por
%meio da distância de Mahalanobis entre o grupo referência ("especialista") 
%e o testado

%Experimento Bauru foi categorizado em 3: Especialistas (Aluno/professor
%formado que passou pela disciplina de anesteseologia), Não Especialistas
%(fora da área de odonto) e Alunos 1ºano

%Experimento SP foi categorizado em 5: 4(), 5(), 6(), 7(), 8()
%Para ver como estão organizados é so abrir as tabelas participantesSP e 
%participantesBauru depois de rodar o código


pastadados = 'C:\Users\samsung\Desktop\IA - Odonto\Dados\'; %É preciso atualizar a pasta em que os dados estao
load(strcat(pastadados, 'participantesSP.mat'));
load(strcat(pastadados, 'participantesBauruProfs.mat'));


notasRef = (participantesBauru{:, 8} + participantesBauru{:, 9})/2; 
linhasRef = (notasRef > 3);
dadosRef = participantesBauru{linhasRef, 5:6};
dadosRef(size(dadosRef, 1) + 1, :) = [0 0];


% Calcula os numeros importantes para o T2
medias = mean(dadosRef);
S = cov(dadosRef);
Sinv = inv(S);
n = size(dadosRef, 1);        %numero de amostras
p = size(dadosRef, 2);        %numero de variáveis independentes

confs = [0.5 0.7 0.9];  %3 limiares escolhidos testando


%Printa os dados aprendidos de Bauru segundo a referência da Cidinha
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
cmap = colormap(hsv(length(confs)));
%Loop desenha as regiões de confiança (elipses)
for i = 1:length(confs)
    elipse = elipseConf(n, p, medias, S, confs(i));
    plot(elipse(1, :), elipse(2, :), 'Color', cmap(i, :));
    hold on;
end
plot(dadosRef(:,1), dadosRef(:,2), 'x');
xlabel('X [mm]');
ylabel('Z [mm]');
title('Nota dos Profs 4-3:Vermelho 3-2:Verde 2-1:Azul 1:Preto'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dadosTestados = participantesBauru{:, 5:6};
cores = zeros(size(dadosTestados, 1), 3);

%Printa os dados testados (a partir do padrão da distribuição dos dadosRef)
for i = 1:size(dadosTestados, 1)
    dist = mahal(dadosTestados(i, :), dadosRef); 
    if (notasRef(i) > 3) %Essa é a distância máxima de mahalanobis (elipse) que confs(1) impõe
        cores(i, :) = cmap(1, :);
    elseif(notasRef(i) > 2)
        cores(i, :) = cmap(2, :);
    elseif(notasRef(i) > 1)
        cores(i, :) = cmap(3, :);
    else
        cores(i, :) = [0 0 0];
    end
end

scatter(dadosTestados(:,1), dadosTestados(:,2), 60, cores);
scatter(medias(1), medias(2), 'x');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Printa os dados de SP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
cmap = colormap(hsv(length(confs)));
%Loop desenha as regiões de confiança (elipses)
for i = 1:length(confs)
    elipse = elipseConf(n, p, medias, S, confs(i));
    plot(elipse(1, :), elipse(2, :), 'Color', cmap(i, :));
    hold on;
end
%plot(dadosRef(:,1), dadosRef(:,2), 'x');
xlabel('X [mm]');
ylabel('Z [mm]');
title('Condição 4:Vermelho 6:Verde 7:Azul 8:Preto'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dadosTestados = participantesSP{:, 2:3};
cores = zeros(size(dadosTestados, 1), 3);
cmap = colormap(hsv(4));
%Printa os dados testados (colorindo de acordo com a condição que eles pertenciam)
for i = 1:size(dadosTestados, 1)
    dist = mahal(dadosTestados(i, :), dadosRef); 
    if (dist < (p*(n-1)/(n-p))*(1+1/n)*finv(confs(1), p, n-p)) %
        cores(i, :) = [1 0 0];
    elseif(dist < (p*(n-1)/(n-p))*(1+1/n)*finv(confs(2), p, n-p))
        cores(i, :) = [0 1 0];
    elseif(dist < (p*(n-1)/(n-p))*(1+1/n)*finv(confs(3), p, n-p))
        cores(i, :) = [0 0 1];
    else
        cores(i, :) = [0 0 0];
    end
end

scatter(dadosTestados(:,1), dadosTestados(:,2), 60, cores);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Vê quantos recebeu tal nota em cada grupo
notasSP = zeros(4);
  
for i = 1:size(dadosTestados, 1)
    dist = mahal(dadosTestados(i, :), dadosRef); 
    j = 0;
    if (participantesSP{i, 4} == '4') %
        j = 1;
    elseif(participantesSP{i, 4} == '6')
        j = 2;
    elseif(participantesSP{i, 4} == '7')
        j = 3;
    else
        j = 4;
    end
    
    if (dist < (p*(n-1)/(n-p))*(1+1/n)*finv(confs(1), p, n-p)) %Essa é a distância máxima de mahalanobis (elipse) que confs(1) impõe
        notasSP(j, 1) = notasSP(j, 1) + 1; 
    elseif (dist < (p*(n-1)/(n-p))*(1+1/n)*finv(confs(2), p, n-p))
        notasSP(j, 2) = notasSP(j, 2) + 1; 
    elseif (dist < (p*(n-1)/(n-p))*(1+1/n)*finv(confs(3), p, n-p)) 
        notasSP(j, 3) = notasSP(j, 3) + 1; 
    else
        notasSP(j, 4) = notasSP(j, 4) + 1; 
    end
end
figure;
b1 = bar([4 3 2 1], notasSP(1, :));
title('Distribuição de Notas do grupo 4');
xlabel('Notas'); ylabel('Quantidade');

figure;
b1 = bar([4 3 2 1], notasSP(2, :));
title('Distribuição de Notas do grupo 6');
xlabel('Notas'); ylabel('Quantidade');

figure;
b1 = bar([4 3 2 1], notasSP(3, :));
title('Distribuição de Notas do grupo 7');
xlabel('Notas'); ylabel('Quantidade');

figure;
b1 = bar([4 3 2 1], notasSP(4, :));
title('Distribuição de Notas do grupo 8');
xlabel('Notas'); ylabel('Quantidade');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calcula a matriz de confusão
total_testes = 20;
tabela_roc = zeros(total_testes, 3);
dadosBauru = participantesBauru{:, 5:6}; 
total_Positivos = sum(notasRef >= 3); %retirei a Cidinha que eu tinha colocado artificialmente
total_Negativos = size(dadosBauru, 1) - total_Positivos;

for j = 1:total_testes
    %aqui codigo que ira calcular os diferentes thresholds e %armazenar na tabela_roc. 
    Falsos_Positivos = 0;
    Verdadeiros_Positivos = 0;
    
    tabela_roc(j,1)= j/total_testes;  %são os valores que representam as elipses/esferas ilustradas. Esses valores sao dados por um intervalo de confiança ou observados de forma empírica, ou seja, precisa variar o threshold e observar p cada caso.
    for i = 1:size(dadosBauru, 1)
        dist = mahal(dadosBauru(i, :), dadosRef); 
        if (dist < (p*(n-1)/(n-p))*(1+1/n)*finv(j/total_testes, p, n-p)) %Essa é a distância máxima de mahalanobis (elipse) que confs(1) impõe
            if (notasRef(i) >= 3)
                Verdadeiros_Positivos = Verdadeiros_Positivos + 1;
            else
                Falsos_Positivos = Falsos_Positivos + 1;
            end
        end
    end
    
    tabela_roc(j,2)=Falsos_Positivos/total_Negativos;   %representa o False Positive Rate(FPR)
    tabela_roc(j,3)=Verdadeiros_Positivos/total_Positivos;  %representa Sensitivity
end

%Plota a curva ROC 
figure;
Z = trapz(tabela_roc(:,2),tabela_roc(:,3));   %calcula a area sob a curva. Essa funcao aproxima a integraÃ§Ã£o de uma Ã¡rea com intervalo de dados
plot(tabela_roc(:,2), tabela_roc(:,3), 'o-r');  %plota a curva ROC de acordo com a Matriz de Confusão (Confusion Matrix).
set(gca,'XTick',[0; 1]);    %limita entre os valores 0-1
set(gca,'YTick',[0; 1]);
title(['AUC =',num2str(Z)]);hold on;   %mostra o resultado da AUC 
ylabel('Sensibilidade');
xlabel('FPR');
legend('T2 Hotelling')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Função que cria as elipses a partir das informações importantes da
%distribuição
function elipse = elipseConf(n, p, xbar, sigmachapeu, conf) 
    theta = linspace(0, 2*pi, 100);

    elipse = zeros(2, 100);
    for i = 1:100
        elipse(:,i) = xbar' + sqrt((p*(n-1)/(n-p))*(1+1/n)*finv(conf, p, n-p))*chol(sigmachapeu)'*[cos(theta(i)); sin(theta(i))];
    end
end
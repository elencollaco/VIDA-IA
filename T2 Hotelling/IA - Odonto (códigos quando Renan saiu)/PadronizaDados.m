%Função criada só para converter os dados para matlab, varia com o estilo
%da tabela do excel


participantesBauru = [AvaliaoAutomticaNovaFrmula3(:,1) AvaliaoAutomticaNovaFrmula3(:,5) AvaliaoAutomticaNovaFrmula3(:,3) AvaliaoAutomticaNovaFrmula3(:,2) AvaliaoAutomticaNovaFrmula3(:,6:10)];


save('participantesBauruProfs.mat', 'participantesBauru');



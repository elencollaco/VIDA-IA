% Plota todos os histrogramas relacionados as trajetórias, diferenciando
% entre especialistas e não especialistas


figure
% eu tive que testar assim porque na função hist não estava funcionando para mim
%squeeze(dadosesp(size(dadosesp, 1), 1, :) são os tempos finais, squeeze(dadosesp(size(dadosesp, 1), 2, :) são as posições X finais e assim vai
%nesse link tem um simples plot de 2 para MATLAB novo https://www.mathworks.com/matlabcentral/answers/318552-histogram-for-grouped-data

[nelements,xcenters] = hist(squeeze(dadosesp(size(dadosesp, 1), 1, :)));
bar(xcenters,nelements/size(dadosesp, 3),  'FaceAlpha',.5);
hold on
%[nelements,xcenters] = hist(squeeze(dadosnesp(size(dadosnesp, 1), 1, :)));
%bar(xcenters,nelements/size(dadosnesp, 3),  'FaceAlpha',.5);

title('Tempos');
legend('especialistas', 'não-especialistas');

hold off

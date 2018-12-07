% Plota todos os histrogramas relacionados as trajet�rias, diferenciando
% entre especialistas e n�o especialistas


figure

[nelements,xcenters] = hist(squeeze(dadosesp(size(dadosesp, 1), 1, :)));
bar(xcenters,nelements/size(dadosesp, 3),  'FaceAlpha',.5);
hold on
%[nelements,xcenters] = hist(squeeze(dadosnesp(size(dadosnesp, 1), 1, :)));
%bar(xcenters,nelements/size(dadosnesp, 3),  'FaceAlpha',.5);

title('Tempos');
legend('especialistas', 'n�o-especialistas');

hold off
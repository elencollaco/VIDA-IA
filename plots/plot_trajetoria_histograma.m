close all; clc;
load Trajetoriaref.mat;

%plota trajetoria
figure(1)
subplot(2,1,1)
plot(Trajetoriaref(:,1),Trajetoriaref(:,2),'k');
ylabel('Position (m)');
xlabel('Time (s)');
hold on;    grid on;
plot(Trajetoriaref(:,1),Trajetoriaref(:,3));
hold on;    grid on;
plot(Trajetoriaref(:,1),Trajetoriaref(:,4));
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
legend('Pos_{x}','Pos_{y}','Pos_{z}','Location','NorthEastOutside');
hold on;
subplot(2,1,2)
plot(Trajetoriaref(:,1),Trajetoriaref(:,5),'k');
ylabel('Rotation (deg)');
xlabel('Time (s)');
hold on;    grid on;
plot(Trajetoriaref(:,1),Trajetoriaref(:,6));
hold on;    grid on;
plot(Trajetoriaref(:,1),Trajetoriaref(:,7));
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
legend('Rot_{x}','Rot_{y}','Rot_{z}','Location','NorthEastOutside');

%plota histogramas
figure(3)
%posicao
subplot(2,3,1)
    hist(Trajetoriaref(:,2));
    ylabel('N ocorrências','interpreter','LaTex', ...
        'fontsize',12,'fontweight','b');
    xlabel('$Pos_{x}$','interpreter','LaTex', ...
        'fontsize',12,'fontweight','b');
    hold on;    
    grid on;
subplot(2,3,2)
    hist(Trajetoriaref(:,3));
    xlabel('$Pos_{y}$','interpreter','LaTex', ...
        'fontsize',12,'fontweight','b');
    hold on;    
    grid on;
subplot(2,3,3)
    hist(Trajetoriaref(:,4));
    xlabel('$Pos_{z}$','interpreter','LaTex', ...
        'fontsize',12,'fontweight','b');
    hold on;    
    grid on;
%rotacao  
subplot(2,3,4)
    hist(Trajetoriaref(:,5));
    xlabel('$Rot_{x}$','interpreter','LaTex', ...
        'fontsize',12,'fontweight','b');
    ylabel('N ocorrências','interpreter','LaTex', ...
        'fontsize',12,'fontweight','b');
    hold on;    
    grid on;
 subplot(2,3,5)
    hist(Trajetoriaref(:,6));
    xlabel('$Rot_{y}$','interpreter','LaTex', ...
        'fontsize',12,'fontweight','b');
    hold on;    
    grid on;
 subplot(2,3,6)
    hist(Trajetoriaref(:,7));
    xlabel('$Rot_{z}$','interpreter','LaTex', ...
        'fontsize',12,'fontweight','b');
    hold on;    
    grid on;

    
    % figure(1)
% plot(Trajetoriaref(:,1),Trajetoriaref(:,2),'k');
% ylabel('Position (m)');
% xlabel('Time (s)');
% hold on;    grid on;
% plot(Trajetoriaref(:,1),Trajetoriaref(:,3));
% hold on;    grid on;
% plot(Trajetoriaref(:,1),Trajetoriaref(:,4));
% set(findall(gca, 'Type', 'Line'),'LineWidth',2);
% legend('Pos_{x}','Pos_{y}','Pos_{z}');
% 
% figure(2)
% plot(Trajetoriaref(:,1),Trajetoriaref(:,5),'k');
% ylabel('Rotation (deg)');
% xlabel('Time (s)');
% hold on;    grid on;
% plot(Trajetoriaref(:,1),Trajetoriaref(:,6));
% hold on;    grid on;
% plot(Trajetoriaref(:,1),Trajetoriaref(:,7));
% set(findall(gca, 'Type', 'Line'),'LineWidth',2);
% legend('Rot_{x}','Rot_{y}','Rot_{z}');

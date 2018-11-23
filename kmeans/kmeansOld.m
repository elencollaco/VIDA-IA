%-------------------------------------------------------------------------&
%                            GRUPAMENTO K-MEANS                           &
%                                  &                                      &
%                             Vizualização                                &
%                            
%-------------------------------------------------------------------------&

close all;clear all;
load irisOriginal;
% vamos pegar sepal-length e petal-length
data=[irisOriginal(:,1),irisOriginal(:,3)];
k=3; % tres clusters
%clu[j,l] onde l eh o atributo e j eh o cluster

%sorteia centro dos clusters "dentro do grafico"
for(i=1:k)
    clu(i,1)=min(data(:,1))+rand*(max(data(:,1))-min(data(:,1)));
    clu(i,2)=min(data(:,2))+rand*(max(data(:,2))-min(data(:,2)));
end
 
% plotar dados e centros dos clusters
figure; hold on;
plot(data(:,1),data(:,2),'kx');
plot(clu(1,1),clu(1,2),'rh');plot(clu(1,1),clu(1,2),'r.');
plot(clu(2,1),clu(2,2),'bp');plot(clu(2,1),clu(2,2),'b.');
plot(clu(3,1),clu(3,2),'mv');plot(clu(3,1),clu(3,2),'m.');
xlabel('sepal-length');
ylabel('petal-length');
title('configuracao inicial');
%PARTE 2
oldb=zeros( size(data,1), k);
b=ones( size(oldb) );

while any( any( oldb~=b ) )
% associar os elementos aos clusters mais proximos
% b(i,j) onde i eh o elemento e j eh o cluster
    oldb=b;
    for i=1:size(data,1)
        dists = (data(i,1)-clu(:,1)).^2 + (data(i,2)-clu(:,2)).^2;
        b(i,:)=zeros(1,k);
        loc=find(dists==min(dists));
        b(i,loc(1))=1;
    end

% plotar dados ligados a cada cluster
pause; cla reset; hold on;
plot(data(find(b(:,1)),1),data(find(b(:,1)),2),'rh');
plot(data(find(b(:,2)),1),data(find(b(:,2)),2),'bp');
plot(data(find(b(:,3)),1),data(find(b(:,3)),2),'mv');
plot(clu(1,1),clu(1,2),'rh');plot(clu(1,1),clu(1,2),'r.');
plot(clu(2,1),clu(2,2),'bp');plot(clu(2,1),clu(2,2),'b.');
plot(clu(3,1),clu(3,2),'mv');plot(clu(3,1),clu(3,2),'m.');
xlabel('sepal-length');
ylabel('petal-length');
title('cada observacao eh associada ao centro de cluster mais proximo');
%PARTE 3
% recalcular a posicao dos clusters
% pela media dos elementos associados
clu=(b'*data) ./ (b'*ones(size(data)));

% plotar os novos clusters
pause; cla reset; hold on;
plot(data(find(b(:,1)),1),data(find(b(:,1)),2),'rh');
plot(data(find(b(:,2)),1),data(find(b(:,2)),2),'bp');
plot(data(find(b(:,3)),1),data(find(b(:,3)),2),'mv');
plot(clu(1,1),clu(1,2),'rh');plot(clu(1,1),clu(1,2),'r.');
plot(clu(2,1),clu(2,2),'bp');plot(clu(2,1),clu(2,2),'b.');
plot(clu(3,1),clu(3,2),'mv');plot(clu(3,1),clu(3,2),'m.');
xlabel('sepal-length');
ylabel('petal-length');
title('os centros sao recalculados para a media dos clusters');

end
disp('\n\nTerminou!!!!');
figure;hist(irisOriginal(:,1));
figure;hist(irisOriginal(:,3));
%PLOTA CIRCUNFERENCIAS
% figure;
% for i = 1:size(clu,1)
%     for n = 0:360
%         x = raio(i,3)*cos(n*pi/180) + clu(i,1);
%         y = raio(i,3)*sin(n*pi/180) + clu(i,2);
%         plot(x,y,'red');
%     end;
% end;

%PLOTA ELLIPSE
figure;ellipse(1,2,pi/4,1,1,'r')
hold on;ellipse(0.5,1,pi/4,1,1,'b')
hold on;ellipse(0.8,1.5,pi/4,1,1,'c')
hold on;
x=1;y=1;
    for n = 0:13
        x = x+0.1;
        y = y+0.01;
        plot(x,y,'*');
    end;
hold on;
legend('Limiar \gamma_{1}','Limiar \gamma_{2}','Limiar \gamma_{3}')
    x=x+0.03; 
    txt1 = ['\leftarrow destreza';'inadequada         '];
    text(x,y,txt1,'FontSize',13);
    txt2 = ['Região de    '; 'Alta Destreza'];
    text(0.2,1,txt2,'FontSize',15);

%estrutura de dados usada ==
%cada usuário tem
%usuario.dados = sua trajetória organizada em colunas na sequência 
%t, X(t), Y(t), Z(t), RotX(t), RotY(t), RotZ(t)
%posições em metros e rotações em graus
%usuario.nome com o código do usuario naquele experimento (não utilizado
%nesse código do T2Hotelling


PontosFinais = extraiPontosFinais(dados);
PontosX1 = PontosFinais(1:end/2,2);
PontosX2 = PontosFinais((end/2 + 1):end,2);
PontosZ1 = PontosFinais(1:end/2,4);
PontosZ2 = PontosFinais((end/2 + 1):end,4);

% convert into column vectors
if (size(PontosX1,1) == 1), PontosX1 = PontosX1';end
if (size(PontosZ1,1) == 1), PontosZ1 = PontosZ1';end

x1 = PontosX1;
y1 = PontosZ1;
[phil1, r1] = cart2pol(x1,y1);
x2 = PontosX2;
y2 = PontosZ2;
[phil2, r2] = cart2pol(x2,y2);

% calculate number of points
n1 = length(PontosX1);
n2 = length(PontosX2);



% calculate the means
m1 = mean([x1 y1]);
m2 = mean([x2 y2]);

% calculate the covariance matrix
c1 = cov([x1 y1]);
c2 = cov([x2 y2]);

% calculate pooled sum of squares
ssx = c1(1,1)*(n1-1) + c2(1,1)*(n2-1);
ssy = c1(2,2)*(n1-1) + c2(2,2)*(n2-1);

% caluclate correlation coefficent
r = (c1(1,2)*(n1-1)+c2(1,2)*(n2-1))*(ssx*ssy)^(-1/2);

% calculate t-statistic
t1 = (m1(1)-m2(1))*(((1/n1)+(1/n2))*ssx/(n1+n2-2))^(-1/2);
t2 = (m1(2)-m2(2))*(((1/n1)+(1/n2))*ssy/(n1+n2-2))^(-1/2);

% calculate T squared value
T2 = ((1-r^2)^-1)*(t1^2-2*r*t1*t2+t2^2);

% convert T2 to an F value
F = T2*(n1+n2-3)/(2*(n1+n2-2));

% calculate p-value from F distribution
% using betainc function (see. Numerical Recipies p.181)
v1 = 2;v2 = n1+n2-3;
p = betainc(v2/(v2+v1*F),v2/2,v1/2);

% plot the data
if (true)
  figure
  % draw data and 95% confidence ellipses
  rconf(phil1,r1,.95,'g');
  rconf(phil2,r2,.95,'b');
  zoom on
end







function y = extraiPontosFinais(trajs)
    y = zeros(size(trajs, 2), size(trajs(1).dados, 2));
    for i = 1:size(trajs, 2)
        y(i, :) = trajs(i).dados(end, :);
    end
end

function [pvalue, f, t2, diffbar] = hotelling(x1, x2)
    n1 = size(x1, 1);
    n2 = size(x2, 1);
    k = size(x1, 2);
    
    xbar1 = mean(x1, 1);
    xbar2 = mean(x2, 1);
    diffbar = xbar1 - xbar2;
    
    v = ((n1-1)*var(x1)+ (n2-1)*var(x2)) /(n1+n2-2);
    
    t2 = n1*n2*diffbar*solve(v)*diffbar/(n1+n2);
    f = (n1+n2-k-1)*t2/((n1+n2-2)*k);
    pvalue = 1-pf('F',f, k, n1+n2-k-1);
end

function rconf(phi,r,conf,color,plotpoints)

    % check arguments
    if (nargin == 1)
      r = nan;
      conf = .95;
      color = 'k';
      plotpoints = 1;
    elseif (nargin == 2)
      conf = .95;
      color = 'k';
      plotpoints = 1;
    elseif (nargin == 3)
      color = 'k';
      plotpoints = 1;
    elseif (nargin == 4)
      plotpoints = 1;
    elseif (nargin ~= 5)
      help rconf;
      return
    end

    if isnan(r)
      % if we have only one input argument then
      % that means we have lengthless directions
      for i = 1:length(phi)
        r(i) = 1;
        if isnan(phi(i))
          r(i) = nan;
        end
      end
    end

    % alpha should be expressed as the probability that
    % the null hypothesis is not true
    alpha = 1-conf;

    % convert into column vectors
    if (size(phi,1) == 1), phi = phi';,end
    if (size(r,1) == 1), r = r';,end

    % remove nans
    goodnums = find(~isnan(phi) & ~isnan(r));
    phi = phi(goodnums);
    r = r(goodnums);

    % calculate number of points
    n = length(phi);

    % not enough points
    if (n < 2)
      return
    end

    % calculate Hotelling's T^2
    T2 = 2*((n-1)/(n-2))*finv(1-alpha,2,n-2);

    % find the x and y's of the points
    x = r.*cos(phi);
    y = r.*sin(phi);

    % calculate the means
    m = mean([x y]);

    meanr = sqrt(m(1)^2 + m(2)^2);
    meanphi = (atan(m(2)/m(1)))*180/pi;
    % calculate the covariance matrix
    c = cov([x y]);
    cc = c(1,2)/(sqrt(c(1,1))*sqrt(c(2,2)));

    % display stats
    disp(sprintf('mean = %.4f %.4f deg stdx = %.4f stdy = %.4f',...
             meanr,meanphi,sqrt(c(1,1)),sqrt(c(2,2))));

    % plot the points
    if (plotpoints)
      plot(x,y,[color '.']); hold on
    end

    % plot mean vector
    plot(m(1),m(2),[color '+']);hold on
    % plot the standard ellipse
    drawellipse(c(2,2),-c(1,2),c(1,1),(1-cc^2)*c(1,1)*c(2,2)*(1/n)*T2,m,color,1);
    themax = max(max(abs(x)),max(abs(y)));
    axis([-themax themax -themax themax]);
    %hline(0);
    %vline(0);
    % draw circles
    %for i = 5:5:20
    %  drawellipse(1,0,1,i^2,[0 0],'k',2);
    %end
    axis square
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function to draw an ellipse 
% using ax^2 + bxy + cy^2 = r
% around center point m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function drawellipse(a,b,c,r,m,color,markersize)

    % all directions around half a circle
    dir = (0:180)*pi/180;
    % calculate the slope of the point at each direction
    slope = sin(dir)./cos(dir);
    % rewrite ellipse equation as an equation for
    % x given the slope
    x = sqrt(r./(a+2*b.*slope+c.*slope.^2));
    % get the y component
    y = [slope.*x slope.*-x];
    % x component is both the positives and the negatives
    x = [x -x];
    % plot the points, centered around the mean.
    plot(x+m(1),y+m(2),[color '-'],'MarkerSize',markersize);
end
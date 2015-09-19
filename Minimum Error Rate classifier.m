clear;
x1 = -7:.2:7; x2 = -7:.2:7;
[X1,X2] = meshgrid(x1,x2);
mu1 = [0 0];
Sigma1 = [.25 .3;.3 1];
F1 = mvnpdf([X1(:) X2(:)],mu1,Sigma1);
F1 = reshape(F1,length(x2),length(x1));

meshc(X1,X2,F1);
axis([-7 7 -7 7 -1.0 .6])
xlabel('x1'); ylabel('x2'); zlabel('Probability Density');
hold on;
mu2 = [2 2];
Sigma2 = [.5 .0; 0 .5];
F2 = mvnpdf([X1(:) X2(:)],mu2,Sigma2);
F2 = reshape(F2,length(x2),length(x1));

meshc(X1,X2,F2);
axis([-7 7 -7 7 -1.0 .6])
xlabel('x1'); ylabel('x2'); zlabel('Probability Density');
caxis([min(F2(:))-.5*range(F2(:)),max(F2(:))]);
%% Write Your CODE here
p = [1 1;1 -1;4 5;-2 2.5;0 2;2 -3];

for i=1:1:6
    x = [p(i,1) p(i,2)];
    
    %start calculating P(w1|x) from here
    c1 = 1/((2*3.14)*det(Sigma1)^(0.5));
    t1 = x- mu1;
    t1 = t1';
    t1 = inv(Sigma1)*t1;
    t1 = (x-mu1)*t1;
    c1 = c1 * exp(t1);
    c1 = c1*.5;
    %end calculating P(w1|x) here
    
    
    %start calculating P(w2|x) from here
    c2 = 1/((2*3.14)*det(Sigma2)^(0.5));
    t2 = x- mu2;
    t2 = t2';
    t2 = inv(Sigma2)*t2;
    t2 = (x-mu2)*t2;
    c2 = c2 * exp(t2);
    c2 = c2*.5;
    %end calculating P(w2|x) here
    
    
    %if c1 > c2 then x belong to class 1 otherwist lass
    if c1 > c2
        plot3(p(i,1), p(i,2),-1.0,'rx');
        hold on;
    else
        plot3(p(i,1), p(i,2),-1.0,'bx');
        hold on;
    end
end
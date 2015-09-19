clear all;
fileId = fopen('points_class1.txt','r');
formatSpec = '%d %d';
sizeA = [2 Inf];
w1 = fscanf(fileId,formatSpec,sizeA);
w1 = w1';

fileId = fopen('points_class2.txt','r');
formatSpec = '%d %d';
sizeA = [2 Inf];
w2 = fscanf(fileId,formatSpec,sizeA);
w2 = w2';

plot(w1(:,1),w1(:,2),'ro');
hold on;
plot(w2(:,1),w2(:,2),'bo');
hold on;
y = zeros(0,0);
szA = size(w1);
szB = size(w2);

for i=1:1:szA
    x1 = w1(i,1);
    x2 = w1(i,2);
    y = [y;x1*x1 x2*x2 x1*x2 x1 x2 1];%the values of Φ­Function are built
end

for i=1:1:szB
    x1 = w2(i,1);
    x2 = w2(i,2);
    t = [x1*x1 x2*x2 x1*x2 x1 x2 1]; %the values of Φ­Function are built
    t = -t; %normalized by reflecting
    y = [y;t];
end

sz = size(y);
alpha=0.1;

%one at a time start
w = zeros(1,6);
flag = 1;
cnt1 = 0;
while flag==1
    cnt1 = cnt1+1;
    flag = 0;
    for j=1:1:sz
        x = y(j,:);
        z = x*w'; %calculate discriminant value
        if z<=0 
            flag = 1; %if any point is misclassified another iteration over all point will needed
            d(1,:) = alpha*x;
            w = w + d; %update weight vector when a point find misclassified
        end
    end
end


syms x1 x2;	
s=sym(w(1)*x1*x1+w(2)*x2*x2+w(3)*x1*x2+w(4)*x1+w(5)*x2+w(6));
s1=solve(s,x2);
low = min(w1,w2);
high = max(w1,w2);
xvals1=[low:0.1:high];
xvals2(1,:)=subs(s1(1),x1,xvals1);
plot(xvals1,xvals2(1,:),'b');
hold on;
%one at a time end

%many at e time start

w = zeros(1,6);
flag = 1;
cnt2 = 0;
while flag==1
    cnt2 = cnt2+1;
    flag = 0;
    tmp = zeros(0,0);
    for j=1:1:sz
        x = y(j,:);
        z = x*w' ; %calculate discriminant value
        if z<=0
            flag = 1;  %if any point is misclassified another iteration over all point will needed
            tmp = [tmp j]; % array of misclassified points
        end
    end
    tsz = size(tmp);
    for j=1:1:tsz
        k = tmp(j);
        x = y(k,:);
        d(1,:) = alpha*x;
        w = w + d; %update weight vector after calculating all points discriminant values 
    end
end


syms x1 x2;	
s=sym(w(1)*x1*x1+w(2)*x2*x2+w(3)*x1*x2+w(4)*x1+w(5)*x2+w(6));
s2=solve(s,x2);
low = min(w1,w2);
high = max(w1,w2);
xvals1=[low:0.1:high];
xvals2(1,:)=subs(s2(1),x1,xvals1);
plot(xvals1,xvals2(1,:),'k');
hold on;
%many at e time end
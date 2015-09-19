clear;
%point take form file
fileId = fopen('points.txt','r');
formatSpec = '%d %d';
sizeA = [2 Inf];
x = fscanf(fileId,formatSpec,sizeA);
x = x';

sz = size(x);

m1 = x(1,:); %mean for cluster 1
m2 = x(5,:); %mean for cluster 2
m3 = x(9,:); %mean for cluster 3

cnt = 0;
region = zeros(sz,1); %point region numnber
while 1==1
    cnt = cnt+1;
    %previous means
    p1 = m1; 
    p2 = m2;
    p3 = m3;
    
    %points sum for each region
    c1 = zeros(1,2);
    c2 = zeros(1,2);
    c3 = zeros(1,2);
    
    %number of point in each region
    cnt1 = 0;
    cnt2 = 0;
    cnt3 = 0;
    
    region = zeros(10,1);
    for i=1:1:sz
        tmp = (m1(1,1) - x(i,1))*(m1(1,1) - x(i,1)) + (m1(1,2) - x(i,2))*(m1(1,2) - x(i,2)); %distence from cluster  mean to point
        M = tmp;
        id = 1;
        
        tmp = (m2(1,1) - x(i,1))*(m2(1,1) - x(i,1)) + (m2(1,2) - x(i,2))*(m2(1,2) - x(i,2)); %distence from cluster  mean to point
        if M > tmp
            M = tmp;
            id = 2;
        end
        
        tmp = (m3(1,1) - x(i,1))*(m3(1,1) - x(i,1)) + (m3(1,2) - x(i,2))*(m3(1,2) - x(i,2)); %distence from cluster  mean to point
        if M > tmp
            M = tmp;
            id = 3;
        end
        
        region(i,1) = id; %region id for point i
        
        %update region
        if id == 1
            c1 = c1 + x(i,:);
            cnt1 = cnt1 + 1;
        elseif id == 2
            c2 = c2 + x(i,:);
            cnt2 = cnt2 + 1;
        else
            c3 = c3 + x(i,:);
            cnt3 = cnt3 + 1;
        end
    end
    m1 = c1 / cnt1; %current mean for cluster 1
    m2 = c2 / cnt2; %current mean for cluster 2
    m3 = c3 / cnt3; %current mean for cluster 3
    if p1(1) == m1(1) && p2(1) == m2(1) && p3(1) == m3(1) && p1(2) == m1(2) && p2(2) == m2(2) && p3(2) == m3(2) %compear with previous mean
        break;
    end
end


%ploting means & point highlighting region color 
plot(m1(1,1),m1(1,2),'b+');
hold on;
plot(m2(1,1),m2(1,2),'k+');
hold on;
plot(m3(1,1),m3(1,2),'r+');
hold on;
for i=1:1:sz
    if region(i,1) == 1 
        plot(x(i,1),x(i,2),'bo'); %for cluster 1
        hold on;
    elseif region(i,1) == 2
        plot(x(i,1),x(i,2),'ko');%for cluster 2
        hold on;
    else
        plot(x(i,1),x(i,2),'ro');%for cluster 3
        hold on;
    end
end
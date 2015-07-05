w1x = [2 3 3 -1 4 -2];
w1y = [2 1 3 -3 2 -2];
w2x = [0 -2 -1 -4 -4 2];
w2y = [0 2 -1 2 3 6];
figure
plot(w1x,w1y,'r.');
hold on;
plot(w2x,w2y,'b.');
hold on;
y1 = [mean(w1x) mean(w1y)];
y2 = [mean(w2x) mean(w2y)];
plot(y1(1),y1(2),'ro');
hold on;
plot(y2(1),y2(2),'bo');
hold on;
x = [-1 -1;3 2;-2 1;8 2];

for i=1:1:4
    g1 = x(i,:)*y1' - .5*(y1*y1');
    g2 = x(i,:)*y2' - .5*(y2*y2');
    if g1>g2
        plot(x(i,1),x(i,2),'r+');
        hold on;
    else
        plot(x(i,1),x(i,2),'b+');
        hold on;
    end
end

d = [-4:2:8];
x = 2 .* d' + 1.25;
d = [d' x];
hold on;
plot(d(:,1), d(:,2), 'k-')
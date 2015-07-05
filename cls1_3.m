	x=[7 6 1 2 0 -1 4 3 -2 0];
	n=length(x);
	for i=1:n
		if(x(i)<0)
			x(i)=0;
		end
    end
	y=x(x>3);
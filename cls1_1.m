

	x=2:0.25:3;
	x(2)+1;
	x(1,2)=ans;



	y=zeros(1,5);
	s=0;
	for i=1:5
		y(1,i)=4+s;
		s=s+2;
	end


	A=[x;[1 1 1 1 1];y];

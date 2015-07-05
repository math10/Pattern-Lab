	A=[1 2;4 -1];
	B=[4 -2; -6 3];
	C1=A+B;
	C2=A-B;
	D1=A*B;
	D2=B*A;
	for i=1:2
		for j=1:2
			F(i,j)=B(i,j)+A(i,j)*(B(i,j)^(1/4));
		end
	end

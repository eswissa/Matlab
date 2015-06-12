

function all_permutation( a, n)

if(n==1)
    a
end


for i=1:n
    temp=b(1);
    b(1)=b(i);
    b(i)=temp;
    
    sprintf('\n');
    a
    permute(a(2:end),n-1);
    
    temp=b(1);
    b(1)=b(i);
    b(i)=temp;
    
    sprintf('\n');
    a
end
end

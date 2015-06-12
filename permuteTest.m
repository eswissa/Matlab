function permuteTest(a, l, r)

if(l==r)
    a
else
    for i=l:r
        temp = a(l);
        a(l)=a(i);
        a(i)=temp;
        
        permuteTest (a,l+1,r)
        
        temp = a(l);
        a(l)=a(i);
        a(i)=temp;
    end
end

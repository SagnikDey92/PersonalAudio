function v = splitv(x, index, n)
if(index<n)
    v = x(1:index, 1);
    v = [zeros(n-index, 1); v];
else
    v = x(index-n+1:index, 1);
end
end
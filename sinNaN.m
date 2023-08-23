function y=sinNaN(x) %x puede ser matriz
y=x(~isnan(sum(x,2)),:);
end

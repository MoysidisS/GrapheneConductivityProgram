globals

for i = 1:size(Hold,2)
   if xs(i)>=x1 && xs(i)<=x2 && ys(i)<=y1 && ys(i)>=y2 && Is(i) == 1
      H(transform(Hold,H,i),transform(Hold,H,i)) = H(transform(Hold,H,i),transform(Hold,H,i)) + value1;
      index = index + 1;
   end
end

rectangle('position',[x1 y2 abs(x2-x1) abs(y2-y1)])
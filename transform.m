function out = transform(Hold,~,index)
   temp = 0;
   for i = 1:index
      if Hold(i,:) == 0
         temp = temp + 1;
      end
   end
   out = index - temp;
end
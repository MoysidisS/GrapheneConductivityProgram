% removal of atoms

globals
Hold = H;
if removingContinues
    for i = 1:size(H,2)
       if xs(i)>=x1 && xs(i)<=x2 && ys(i)<=y1 && ys(i)>=y2 && Is(i) == 1
          Is(i) = 0;
          % in bond the removed atoms must stop existing as values
          for j = 1:size(H,2)
             H(i,j) = 0;
             H(j,i) = 0;
          end
       end
    end
    Hold = H;
else
    index = 1;
    while(index == 1)
        for i = 1:size(H,2)
           index = 0;
           if sum(H(i,:)) == 0
              H(i,:) = [];
              H(:,i) = [];
              index = 1;
              break;
           end
        end
    end
end
    for i = 1:size(xs,1)%size(H,2)
       if mod(i,2)==1 && Is(i) == 1  %!!!if ATM(iy,ix)==1
          plot(xs(i),ys(i),'.','Color','r','MarkerSize',sizea)
          hold on;
%           text(xs(i),ys(i),num2str(i),'VerticalAlignment','top','HorizontalAlignment','right')
       elseif mod(i,2)==0 && Is(i) == 1 % !!!elseif ATM(iy,ix)==2
          plot(xs(i),ys(i),'.','Color','b','MarkerSize',sizea)
          hold on;
%           text(xs(i),ys(i),num2str(i),'VerticalAlignment','top','HorizontalAlignment','right')
       end
    end
    hold on;
    for i = 1:2:size(bond,2)
       if Is(bond(i)) == 1 && Is(bond(i+1)) == 1
           x(1) = xs(bond(i));
           x(2) = xs(bond(i+1));
           y(1) = ys(bond(i));
           y(2) = ys(bond(i+1));
           plot(x,y,'Color','black');
       end
    end

    axis([floor(xs(1)-2*a) ceil(((xs(length(xs))))+2*a) ceil(ys(length(ys))-2*a) floor(ys(1)+2*a)]);
    axis equal

    hold off;
%     
%     if removingContinues==0
%         index = 1;
%         while(index == 1)
%             for i = 1:size(xs,1)
%                index = 0;
%                if Is(i) == 0
%                   xs(i)=[];
%                   ys(i)=[];
%                   Is(i)=[];
%                   index = 1;
%                   break;
%                end
%             end
%         end
%     end
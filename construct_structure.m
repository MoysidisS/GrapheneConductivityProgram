globals

% global t;
% global H;
% global i;
% global j;
% global a0;
% global a;
% global dy;
% global dx;
% global xstart;
% global ystart;
% global bond;
% global ys;
% global xs;
% global x;
% global y;
% global sizea;
% global Is;
% global Rfind;
% global temp;
% global z;

% clc
% clear
% close all
a0=1.42; % Angstroms. Distance between atoms of different sublattices
%!!! a=a0*sqrt(3); % Angstroms. Distance between atoms of the same sublattice
a=a0*2.0;

dy=a0*3/2 - a0;
dx=(a0*sqrt(3))/2;%dx=a/2;

xstart = 0;
ystart = 0;
% global H;
% global t;
%figure;
% bond between the i and j atoms is depicted in vector named bond
bond = 0;
global xs;
global ys;
global H;
xs = zeros(size(H,1),1);
ys = zeros(size(H,1),1);
xs(1) = xstart;
ys(1) = ystart;
for temp = 1:size(H,2)
   if(H(temp,temp + 1) ~= -3)
      Rfind = temp;
      break;
   end
end
  
for i = 1:size(H,1)
   for j = i:size(H,1) % scan only the upper triangular part of the Hamiltonian (H).
      % find the bonds
      if H(i,j) == t
         bond(size(bond,2)+1) = i;
         bond(size(bond,2)+1) = j;
      end
   end
   %x,y coordinations compute
   if i~=1 &&(mod(i,4) == 1)
      xs(i) = xs(i-1);
      ys(i) = ys(i-1)-a0;
      if bond(size(bond,2)-2) ~= i && bond(size(bond,2)-4) ~= i && (size(bond,2)~=6 && bond(size(bond,2)-6) ~= i)
         xs(i) = xs(i-1) + 2*dx;
         ys(i) = ystart;
         for z = i - Rfind:i-1
            if H(z,i+1) == t
               xs(i) = xs(i-1) + 2*dx;
               ys(i) = ys(z);
            end
         end
%          xs(i) = xs(i-1) + a;
%          ys(i) = ystart;
         Rfind = i - Rfind;
      end
   elseif mod(i,4) == 3
      xs(i) = xs(i-1);
      ys(i) = ys(i-1)-a0;
   elseif mod(i,4) == 2
      xs(i) = xs(i-1) - dx;
      ys(i) = ys(i-1) - dy;
%       if ys(i-1) == 0 && 
%           
%       end
   elseif mod(i,4) == 0
      xs(i) = xs(i-1) + dx;
      ys(i) = ys(i-1) - dy;
   end
end

bond = bond(2:size(bond,2));

% for i = 1:size(H,2)
%    if i~=1 &&( mod(i,4) == 1 || mod(i,4) == 3)
%       xs(i) = xs(i-1);
%       ys(i) = ys(i-1)-a0;
%       if bond(i-1) == i || (i~=3 && bond(i-3) == i)
%          xs(i) = x(i-1) + a;
%          ys(i) = ystart;
%       end
%    elseif mod(i,4) == 2
%       xs(i) = xs(i-1) - dx;
%       ys(i) = ys(i-1) - dy;
%    elseif mod(i,4) == 0
%       xs(i) = xs(i-1) + dx;
%       ys(i) = ys(i-1) - dy;
%    end 
% end
% global Is;
sizea = 5;

for i = 1:size(H,2)
   if mod(i,2)==1 && Is(i) == 1  %!!!if ATM(iy,ix)==1
      plot(xs(i),ys(i),'.','Color','r','MarkerSize',sizea)
      hold on;
%       text(xs(i),ys(i),num2str(i),'VerticalAlignment','top','HorizontalAlignment','right')
   elseif mod(i,2)==0 && Is(i) == 1 % !!!elseif ATM(iy,ix)==2
      plot(xs(i),ys(i),'.','Color','b','MarkerSize',sizea)
      hold on;
%       text(xs(i),ys(i),num2str(i),'VerticalAlignment','top','HorizontalAlignment','right')
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

axis([floor(xs(1)-2*a) ceil(xs(round(size(H,2)))+2*a) ceil(ys(round(size(H,2)))-2*a) floor(ys(1)+2*a)]);
axis equal

hold off;
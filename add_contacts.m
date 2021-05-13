% add contacts (maximum 2 contacts for now)
% we choose the atoms.
% constraints: consecutive atoms must be chosen as interface with contact the contacts
% 29/06/2017

globals

if firstContact == 1
    Cntct1PlcSlct = 0;
    index = 1;
    contact1 = 0;
    for i = 1:size(Hold,2)
       if xs(i)>=x1 && xs(i)<=x2 && ys(i)<=y1 && ys(i)>=y2 && Is(i) == 1
          contact1(index) = transform(Hold,H,i);
          index = index + 1;
       end
    end

    A1 = zeros(length(contact1));
    
    if vertical_contact == 0 % horizontal selection
        Cntct1PlcSlct = 1;
        %        for i = 1:length(contact1)-1
%           if mod(i,2) == 1
%              contact1(i)=contact1(i)+contact1(i+1);
%              contact1(i+1)=contact1(i)-contact1(i+1);
%              contact1(i)=(contact1(i)-contact1(i+1));
%           end
%        end
%        
%        contact1 = union(contact1,contact2);
%        A1 = zeros(length(contact1));
%        for i = 1:length(contact1)
%           if mod(i,4) ~= 0
%              A1(i,i+1) = t;
%           end
%           if mod(i,4) == 1 && i+5<=max(contact1)
%              A1(i,i+5) = t;
%           end
%           if mod(i,4) == 0 && i+3<=max(contact1)
%              A1(i,i+3) = t;
%           end
%        end 
%        A1 = A1 + tril(A1');
       A1 = kron(eye(length(contact1)/2),t*[0 1 0 0;1 0 1 0;0 1 0 1;0 0 1 0])+kron(eye(length(contact1)/2),value3*[1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1])+...
            kron(diag(ones(1,length(contact1)/2-1),+1),t*[0 1 0 0;0 0 0 0;0 0 0 0;0 0 1 0])+...
            kron(diag(ones(1,length(contact1)/2-1),-1),t*[0 1 0 0;0 0 0 0;0 0 0 0;0 0 1 0]');
%        A1=H;
       
    else
        
       for i = 1:length(contact1)
          for j = 1:length(contact1)
             A1(i,j) = H((contact1(i)),(contact1(j)));
          end
       end
    
    end
    
    B1 = zeros(length(contact1));
    for i = 1:length(contact1)
       if vertical_contact == 1
          if mod(i,4) == 2 
             B1(i,i-1) = t;
          end
          if mod(i,4) == 3
             B1(i,i+1) = t;
          end
       else
%           if mod(i,4) == 1
%              B1(i,i+3) = t;
%           end
          B1=kron(eye(length(contact1)/2),t*[0 0 0 0;0 0 0 0;0 0 0 0;1 0 0 0]);
          
       end
    end
%     B1 =B1';
    firstContact = 0;
else
    index = 1;
    contact2 = 0;
    Cntct2PlcSlct = 0;
    for i = 1:length(xs)
       if xs(i)>=x1 && xs(i)<=x2 && ys(i)<=y1 && ys(i)>=y2 && Is(i) == 1
          contact2(index) = transform(Hold,H,i);
          index = index + 1;
       end
    end

    A2 = zeros(length(contact2));
    
    if vertical_contact == 0 % horizontal selection
        Cntct2PlcSlct = 1;
        %        for i = 1:length(contact2)
%            if mod(i,4) == 3   
%               contact2 = union(contact2,i-1);
%               contact2 = union(contact2,i-2);
%            end
%        end
%        contact2 = union(contact2,contact2-3);
%        A2 = zeros(length(contact2));
%        for i = 1:length(contact2)-1
%           if mod(i,4) ~= 0
%              A2(i,i+1) = t;
%           end
%           if mod(i,4) == 1 && i+5<=max(contact2)
%              A2(i,i+5) = t;
%           end
%           if mod(i,4) == 0 && i+3<=max(contact2)
%              A2(i,i+3) = t;
%           end
%        end 
%        A2 = A2 + tril(A2');
       A2 = kron(eye(length(contact2)/2),t*[0 1 0 0;1 0 1 0;0 1 0 1;0 0 1 0])+kron(eye(length(contact2)/2),value3*[1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1])+...
            kron(diag(ones(1,length(contact2)/2-1),+1),t*[0 1 0 0;0 0 0 0;0 0 0 0;0 0 1 0])+...
            kron(diag(ones(1,length(contact2)/2-1),-1),t*[0 1 0 0;0 0 0 0;0 0 0 0;0 0 1 0]');
       
    else
       for i = 1:length(contact2)
          for j = 1:length(contact2)
             A2(i,j) = H((contact2(i)),(contact2(j)));
          end
       end
    end
    
    B2 = zeros(length(contact2));
    for i = 1:length(contact2)
       if vertical_contact == 1
          if mod(i,4) == 1 
             B2(i,i+1) = t;
          end
          if mod(i,4) == 0
             B2(i,i-1) = t;
          end
       else
%           if mod(i,4) == 0
%              B2(i,i-3) = t;
%           end
          B2=kron(eye(length(contact2)/2),t*[0 0 0 0;0 0 0 0;0 0 0 0;1 0 0 0]');
       end
    end
    firstContact = 2;
end

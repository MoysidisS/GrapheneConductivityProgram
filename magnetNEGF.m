function out = magnetNEGF(A1,B1,Cntct1PlcSlct,B2,H,contact1,contact2,P1,P2,A2,dE,t,h,Cntct2PlcSlct,I,sigmax,sigmay,sigmaz)        
        parfor ihere = 1:100%E = -.15 : dE : .15
        %if (E~=0)
        E = -0.5+(ihere-1)*dE;
               
        if E == 0
            continue;
        end
    %         Ec(index) = E;
            disp(E)
            ig0 = (E*t + 1i*h) * eye(size(A1,2)) - A1;
            gs1 = inv(ig0);
            change = 1;
            if Cntct1PlcSlct == 1
                while change > 1e-6
                    Gs = inv(ig0 - B1' * gs1 * B1);
                    change = sum(sum(abs(Gs-gs1))) / (sum(sum(abs(gs1)+abs(Gs))));
                    gs1 = 0.5 * Gs + 0.5 * gs1;
                end
                el = B1' * gs1 * B1;
            else
                while change > 1e-6
                    Gs = inv(ig0 - B1 * gs1 * B1');
                    change = sum(sum(abs(Gs-gs1))) / (sum(sum(abs(gs1)+abs(Gs))));
                    gs1 = 0.5 * Gs + 0.5 * gs1;
                end
                el = B1 * gs1 * B1';
            end
            change = 1;
            ig0 = (E*t + 1i*h) * eye(size(A2,2)) - A2;
            gs1 = inv(ig0);
            if Cntct2PlcSlct == 1
                while change > 1e-6
                    Gs = inv(ig0 - B2' * gs1 * B2);
                    change = sum(sum(abs(Gs-gs1))) / (sum(sum(abs(gs1)+abs(Gs))));
                    gs1 = 0.5 * Gs + 0.5 * gs1;
                end
                el2 = B2' * gs1 * B2;
                
            else
                while change > 1e-6
                    Gs = inv(ig0 - B2 * gs1 * B2');
                    change = sum(sum(abs(Gs-gs1))) / (sum(sum(abs(gs1)+abs(Gs))));
                    gs1 = 0.5 * Gs + 0.5 * gs1;
                end
                el2 = B2 * gs1 * B2';
                
            end

            sig1 = zeros(size(H,2)/2);
            p = 0;
            pl = 0;
            if Cntct1PlcSlct == 1
                for i = 1:2:length(contact1)
                   pl = 0;
                   for j = 1:2:length(contact1)
                      sig1(contact1(i),contact1(j)) = el((1+4*p),(1+4*pl));
                      pl = pl + 1;
                   end
                   p = p + 1;
                end
            else
               for i = 1:length(contact1)
                   for j = 1:length(contact1)
                      sig1(contact1(i),contact1(j)) = el(i,j);
                   end
               end 
            end
            sig1=kron(sig1,(I+P1(1)*sigmax+P1(2)*sigmay+P1(3)*sigmaz));
            p = 0;
            pl = 0;
            sig2 = zeros(size(H,2)/2);
            if Cntct2PlcSlct == 1
                for i = 2:2:length(contact2)
                   pl = 0;
                   for j = 2:2:length(contact2)
                      sig2(contact2(i),contact2(j)) = el2((4+4*p),(4+4*pl));
                      pl = pl + 1;
                   end
                   p = p + 1;
                end
            else
               for i = 1:length(contact2)
                   for j = 1:length(contact2)
                      sig2(contact2(i),contact2(j)) = el2(i,j);
                   end
                end
            end
            sig2=kron(sig2,(I+P2(1)*sigmax+P2(2)*sigmay+P2(3)*sigmaz));
            sig1=sparse(sig1);
            sig2=sparse(sig2);
            gama1 = 1i*(sig1 - sig1');
            gama2 = 1i*(sig2 - sig2');
%             sig2
%             el2
            disp((sig2))
            

            GR = inv(E*t*eye(size(H,2)) + 1i*h*eye(size(H,2)) - H - sig1 - sig2);
            GA = GR';
            GR = sparse(GR);
            GA = sparse(GA);
            T1(ihere) = real(trace(gama1*GR*gama2*GA))/2;
            Ec(ihere)=E;
            
            %             index = index + 1;
        end
        
%         T1(51) = [];
%         Ec(51) = [];
        out = T1;
end

%     parfor ihere = 1:(1/dE)+1%E = -.15 : dE : .15
%     %if (E~=0)
%     E = -0.5+(ihere-1)*dE;
%     if E == 0
%         continue;
%     end
% %         Ec(index) = E;
% %         disp(E)
%         ig0 = (E*t + 1i*h) * eye(size(A1,2)) - A1;
%         gs1 = inv(ig0);
%         change = 1;
%         if Cntct1PlcSlct == 1
%             while change > 1e-6
%                 Gs = inv(ig0 - B1' * gs1 * B1);
%                 change = sum(sum(abs(Gs-gs1))) / (sum(sum(abs(gs1)+abs(Gs))));
%                 gs1 = 0.5 * Gs + 0.5 * gs1;
%             end
%             el = B1' * gs1 * B1;
%         else
%             while change > 1e-6
%                 Gs = inv(ig0 - B1 * gs1 * B1');
%                 change = sum(sum(abs(Gs-gs1))) / (sum(sum(abs(gs1)+abs(Gs))));
%                 gs1 = 0.5 * Gs + 0.5 * gs1;
%             end
%             el = B1 * gs1 * B1';
%         end
%         change = 1;
%         ig0 = (E*t + 1i*h) * eye(size(A2,2)) - A2;
%         gs1 = inv(ig0);
%         if Cntct2PlcSlct == 1
%             while change > 1e-6
%                 Gs = inv(ig0 - B2' * gs1 * B2);
%                 change = sum(sum(abs(Gs-gs1))) / (sum(sum(abs(gs1)+abs(Gs))));
%                 gs1 = 0.5 * Gs + 0.5 * gs1;
%             end
%             el2 = B2' * gs1 * B2;
%         else
%             while change > 1e-6
%                 Gs = inv(ig0 - B2 * gs1 * B2');
%                 change = sum(sum(abs(Gs-gs1))) / (sum(sum(abs(gs1)+abs(Gs))));
%                 gs1 = 0.5 * Gs + 0.5 * gs1;
%             end
%             el2 = B2 * gs1 * B2';
%         end
% 
%         sig1 = zeros(size(H,2)/2);
%         p = 0;
%         pl = 0;
%         if Cntct1PlcSlct == 1
%             for i = 1:2:length(contact1)
%                pl = 0;
%                for j = 1:2:length(contact1)
%                   sig1(contact1(i),contact1(j)) = el((1+4*p),(1+4*pl));
%                   pl = pl + 1;
%                end
%                p = p + 1;
%             end
%         else
%            for i = 1:length(contact1)
%                for j = 1:length(contact1)
%                   sig1(contact1(i),contact1(j)) = el(i,j);
%                end
%            end 
%         end
%         sig1=kron(sig1,(I+P1(1)*sigmax+P1(2)*sigmay+P1(3)*sigmaz));
%         p = 0;
%         pl = 0;
%         sig2 = zeros(size(H,2)/2);
%         if Cntct2PlcSlct == 1
%             for i = 2:2:length(contact2)
%                pl = 0;
%                for j = 2:2:length(contact2)
%                   sig2(contact2(i),contact2(j)) = el2((4+4*p),(4+4*pl));
%                   pl = pl + 1;
%                end
%                p = p + 1;
%             end
%         else
%            for i = 1:length(contact2)
%                for j = 1:length(contact2)
%                   sig2(contact2(i),contact2(j)) = el2(i,j);
%                end
%             end
%         end
%         sig2=kron(sig2,(I+P2(1)*sigmax+P2(2)*sigmay+P2(3)*sigmaz));
%         sig1=sparse(sig1);
%         sig2=sparse(sig2);
%         gama1 = 1i*(sig1 - sig1');
%         gama2 = 1i*(sig2 - sig2');
% 
%         
% 
%         GR = inv(E*t*eye(size(H,2)) + 1i*h*eye(size(H,2)) - H - sig1 - sig2);
%         GA = GR';
%         GR = sparse(GR);
%         GA = sparse(GA);
%         T1(ihere) = real(trace(gama1*GR*gama2*GA));
%         index = index + 1;
%     end





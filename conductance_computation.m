% 29/03/2017
% computation of T(E)

globals

if Bvalue ~= 1

    sig1 = zeros(size(H,2));
    sig2 = zeros(size(H,2));
    index = 1;
    dE = 0.01;
    Ec = 0;
    T1 = 0;
    %parallel loop
    T1 = NEGFparallel( A1,B1,Cntct1PlcSlct,B2,H,contact1,contact2,A2,dE,t,h,Cntct2PlcSlct);
    Ec = -.5:dE:.5;
    Ec(51)=[];
    
    %single core loop
%     for E = -.15 : dE : .15
%     %if (E~=0)
%     if E == 0
%         continue;
%     end
%         Ec(index) = E;
%         disp(E)
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
%         sig1 = zeros(size(H,2));
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
%         p = 0;
%         pl = 0;
%         sig2 = zeros(size(H,2));
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
% 
%         gama1 = 1i*(sig1 - sig1');
%         gama2 = 1i*(sig2 - sig2');
% 
%         sig1=sparse(sig1);
%         sig2=sparse(sig2);
% 
%         GR = inv(E*t*eye(size(H,2)) + 1i*h*eye(size(H,2)) - H - sig1 - sig2);
%         GA = GR';
%         GR = sparse(GR);
%         GA = sparse(GA);
%         T1(index) = real(trace(gama1*GR*gama2*GA));
%         index = index + 1;
%     end
    %end
    
    figure
    h=plot(T1,Ec);
    xlabel('(h/2q^2)G');
    ylabel('(E-E_F)/\tau');
    xlim([0 5])
    ylim([-0.55 0.55]);
    set(h, 'linewidth', [3.0])
    
%     T1 = mean(T1)%*2*(1.6e-19)*(1.6e-19)/6.62607015*1e-34;
    fprintf(1,'The computation produced the following normalized Conductance T:\n\n')
    disp(T1)
    save('ANDinfo.mat', 'H','T1','Ec');
    fprintf(1,'Execution ended... \nMatrices of NEGF are saved in ANDinfo.mat file \n\nThe figure contains the relation between the Energy (around the Fermi Level) and the normalized Conductance of the defined structure.\n')

else
    I = eye(2);
    index = 1;
    dE = 0.01;
    Ec = 0;
    T1 = 0;
    Ttot = 0;
    H = kron(H,I);

% replace this script with MeanConductancFerromagnets
    
    theta1 = pi/2; % angle theta of spherical coordinations
    theta2 = pi/2; % angle theta of spherical coordinations
% -------------------------------------------------------------------------


    % magnetic contact 1-------

    P1 = mag1*[sin(theta1)*cos(phi1);    % polarization
               sin(theta1)*sin(phi1);
               cos(theta1)];               

    % -------------------------

    % magnetic contact 2-------

    P2 = mag2*[sin(theta2)*cos(phi2);    % polarization
               sin(theta2)*sin(phi2);
               cos(theta2)];               

    % -------------------------

    sigmax = [0 1;1 0];
    sigmay = [0 -1j;1j 0];
    sigmaz = [1 0;0 -1];
    I = eye(2);
    
    sig1 = zeros(size(H,2));
    sig2 = zeros(size(H,2));
%     A1 = kron(A1,eye(2));
%     A2 = kron(A2,eye(2));
%     B1 = kron(B1,eye(2));%I+P1(1)*sigmax+P1(2)*sigmay+P1(3)*sigmaz);
%     B2 = kron(B2,eye(2));%I+P2(1)*sigmax+P2(2)*sigmay+P2(3)*sigmaz);
%     contact1 = [contact1 contact1+size(contact1,2)*ones(1,size(contact1,2))];
%     contact2 = [contact2+size(H,2)/2*ones(1,size(contact2,2))-size(contact2,2) contact2+size(H,2)/2*ones(1,size(contact2,2))];
%     contact2 = [contact2+size(H,2)/2*ones(1,size(contact2,2))-size(contact2,2)];
    T1 = magnetNEGF(A1,B1,Cntct1PlcSlct,B2,H,contact1,contact2,P1,P2,A2,dE,t,h,Cntct2PlcSlct,I,sigmax,sigmay,sigmaz);
    Ec = -.5:dE:.5;
    Ec(51)=[];
    figure
    h=plot(T1,Ec);
    xlabel('T');
    ylabel('E');
    xlim([0 5])
    ylim([-0.55 0.55]);
    set(h, 'linewidth', [3.0])

%     figure
%     E = -.15:dE:.15;
%     E(16)=[];
%     h=plot(T1,E);
%     xlabel('T');
%     ylabel('E');
%     xlim([0 5])
%     ylim([-0.55 0.55]);
%     set(h, 'linewidth', [3.0])
%     

%     T1r
    save('ANDinfo.mat','H','T1','Ec');
    fprintf(1,'Execution ended... \nMatrices of NEGF are saved in ANDinfo.mat file \n\nThe figure contains the relation between the Energy (around the Fermi Level) and the normalized Conductance of the defined structure.\n')
end



% pw = parpool(2);
% 
% sig1 = zeros(size(H,2));
% sig2 = zeros(size(H,2));
% index = 1;
% dE = 0.01;
% T1(1:1:(1/dE)+1) = 0;
% ig0 = 0;
% gs1 = 0;
% Gs = 0;
% el = 0;
% el2 = 0;
% E = 0;
% B1 = 0;
% B2 = 0;
% 
% 
% parfor ihere=1:1:(1/dE)+1%E = -.5 : dE : .5
% 
%     
%     
% E = -0.5+(ihere-1)*dE;
% if E == 0
%     continue;
% end
%     
%     disp(E)
%     ig0 = (E*t + 1i*h) * eye(size(A1,2)) - A1;
%     gs1 = inv(ig0);
%     change = 1;
%     if Cntct1PlcSlct == 1
%         while change > 1e-6
%             Gs = inv(ig0 - B1' * gs1 * B1);
%             change = sum(sum(abs(Gs-gs1))) / (sum(sum(abs(gs1)+abs(Gs))));
%             gs1 = 0.5 * Gs + 0.5 * gs1;
%         end
%         el = B1' * gs1 * B1;
%     else
%         while change > 1e-6
%             Gs = inv(ig0 - B1 * gs1 * B1');
%             change = sum(sum(abs(Gs-gs1))) / (sum(sum(abs(gs1)+abs(Gs))));
%             gs1 = 0.5 * Gs + 0.5 * gs1;
%         end
%         el = B1 * gs1 * B1';
%     end
%     change = 1;
%     ig0 = (E*t + 1i*h) * eye(size(A2,2)) - A2;
%     gs1 = inv(ig0);
%     if Cntct2PlcSlct == 1
%         while change > 1e-6
%             Gs = inv(ig0 - B2' * gs1 * B2);
%             change = sum(sum(abs(Gs-gs1))) / (sum(sum(abs(gs1)+abs(Gs))));
%             gs1 = 0.5 * Gs + 0.5 * gs1;
%         end
%         el2 = B2' * gs1 * B2;
%     else
%         while change > 1e-6
%             Gs = inv(ig0 - B2 * gs1 * B2');
%             change = sum(sum(abs(Gs-gs1))) / (sum(sum(abs(gs1)+abs(Gs))));
%             gs1 = 0.5 * Gs + 0.5 * gs1;
%         end
%         el2 = B2 * gs1 * B2';
%     end
%     
%     sig1 = zeros(size(H,2));
%     p = 0;
%     pl = 0;
%     if Cntct1PlcSlct == 1
%         for i = 1:2:length(contact1)
%            pl = 0;
%            for j = 1:2:length(contact1)
%               sig1(contact1(i),contact1(j)) = el((1+4*p),(1+4*pl));
%               pl = pl + 1;
%            end
%            p = p + 1;
%         end
%     else
%        for i = 1:length(contact1)
%            for j = 1:length(contact1)
%               sig1(contact1(i),contact1(j)) = el(i,j);
%            end
%        end 
%     end
%     p = 0;
%     pl = 0;
%     sig2 = zeros(size(H,2));
%     if Cntct2PlcSlct == 1
%         for i = 2:2:length(contact2)
%            pl = 0;
%            for j = 2:2:length(contact2)
%               sig2(contact2(i),contact2(j)) = el2((4+4*p),(4+4*pl));
%               pl = pl + 1;
%            end
%            p = p + 1;
%         end
%     else
%        for i = 1:length(contact2)
%            for j = 1:length(contact2)
%               sig2(contact2(i),contact2(j)) = el2(i,j);
%            end
%         end
%     end
%     
%     gama1 = 1i*(sig1 - sig1');
%     gama2 = 1i*(sig2 - sig2');
%     
%     sig1=sparse(sig1);
%     sig2=sparse(sig2);
%     
%     GR = inv(E*t*eye(size(H,2)) + 1i*h*eye(size(H,2)) - H - sig1 - sig2);
%     GA = GR';
%     GR = sparse(GR);
%     GA = sparse(GA);
%     T1(ihere) = real(trace(gama1*GR*gama2*GA));
%     %index = index + 1;
% end
% %end
% 
% Ec(1:(1/dE)/2) = -0.5:dE:-dE;
% Ec(((1/dE)/2+1):1/dE) = dE:dE:0.5;
% figure
% plot(T1,Ec);
% xlabel('T');
% ylabel('E');
% T1
% delete(pw);
% % save ANDinfo.mat
% disp('end')

% 
% globals
% dE = 0.03;
% index = 1:ceil(1/dE);
% sig1 = zeros(size(H,1));
% sig2 = sig1;
% Ec = zeros(length(index),1);
% T1 = zeros(length(index),1);
% E = 0;
% gama1 = sig1;
% gama2 = sig2;
% GR = sig1;
% GA = GR;
% parpool('local',2);
% [T1, Ec] = parscriptNEGF(H,t,A1,A2,B1,B2,contact1,contact2,index,sig1,sig2,ig0,Gs,dE,E,T1,Ec,h,gs1,change,el,el2,gama1,gama2,GR,GA);
% figure
% plot(T1,Ec);
% xlabel('T');
% ylabel('E');
% save lastExecution.mat
% delete(gcp);
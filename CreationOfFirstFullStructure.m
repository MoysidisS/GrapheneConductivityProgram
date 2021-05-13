% clc
% clear all
% close all % Figures
globals

% 
% global t;
% global H;
% global i;

fprintf(1,'Starting... \n\n')
fprintf(1,'Choose the ribbon''s dimensions ...\n\n')
tic
%=========== CONSTANTS ====================================================
% ------ Constants (all MKS, except energy which is in eV)-------

hbar=1.06e-34; % Plank's constant
q=1.6e-19;     % Electron charge
qh=q/hbar;     % Quantum of conductence
a=1e-9; % Atomic distance

zplus=i*1e-3; % This is the "+i*0+" added to E for non-Hermiticity
               % Lecture 21 Module M3.4
               
% Overlap integral        
t=-2.5;   % t0 = "t" the coupling between atoms, matrix elements
E0 = 0;
%=========== END CONSTANTS ================================================

% =============== INPUTS ==================================================
%Sub-programs for user's input

%  globals
 gui('name','Graphene')
 usein=figure(gui);
 waitfor(usein)
% 

% calculate_AupAdn
%columns=9;
%rows=5;
%======================MAIN PROGRAM============================
UX=columns;
UY=rows;

NL=UX;%The number of columns in X-axis
NW=UY;%Number of unit cells in all columns of the Full Hamiltonian

%===========================end try=============================
R  = 4*rows;
C  = columns;

N1 = R * C;
global H;
H  = zeros(N1);

for i = 1 : N1
   H(i,i) = E0;
   if(mod(i,R) ~= 0)
      H(i,i+1) = t;
   end
   if(mod(i,4)==1 && i<=(C-1)*R)
      H(i,i+R+1) = t;
   end
   if(mod(i,4) == 0 && i <= (C-1)*R)
      H(i, i + R - 1) = t;
   end
end

HL = tril(H');
H  = H + HL;
H = sparse(H);
% global Is;
% evalin('base','H=H;');
Is = ones(size(H,2),1);


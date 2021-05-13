function StructureGUI(H,Is,t,firstPoint,xs,ys,x1,x2,y1,y2,pl,nextPhase,a0,dy,dx,xstart,ystart,bond,temp,Rfind,i,j,z,sizea,x,y,p,A1,A2,B1,B2,contact1,contact2,...
             index,swtch,firstContact,fin,vertical_contact,sig1,sig2,ig0,Gs,dE,E,T1,Ec,h,gs1,change,el,el2,gama1,gama2,GR,GA,a,Hold,removingContinues,rows,columns,...
             hbar,q,qh,zplus,E0,usein,UX,UY,NL,NW,R,C,N1,N,N2,HL,TopG2,TopG1,TopG,value1,value2,value3, Btop,Bvalue,pw,ihere,P1,P2,theta1,theta2,phi1,phi2,sigmax,sigmay,sigmaz,I,mag1,mag2,gca,Ttot,count)
    globals
    Bvalue = 0;
    count = 1;
    CreationOfFirstFullStructure
    figure('position',[10 10 1300 600])
    ax = axes('units','pixels');
    set(ax,'ButtonDownFcn',@axButtonDown)
    Cntct1PlcSlct = 0;
    Cntct2PlcSlct = 0;
    TopG1 = 0;
    TopG2 = 0;
    TopG  = 0;
    Btop  = 0;
    
    firstPoint = 1;
    removingContinues = 1;
    VbackSelect = 0;
    value3 = 0;
    h = 1e-12;
    vertical_contact = 0;
    fin = 0;
    swtch = 0;
    firstContact = 1;
    button1 = uicontrol('style','pushbutton',...
                        'position',[10 500 100 80], ...
                        'String','Choose Contacts',...
                        'Enable','off',...
                        'callback',@push);
    button2 = uicontrol('style','pushbutton',...
                        'position',[10 400 100 80], ...
                        'String','Run',...
                        'Enable','off',...
                        'callback',@finalize);
    ToggleB = uicontrol('style','pushbutton',...
                        'position',[10 300 100 80], ...
                        'String','Toggle Edges',...
                        'Enable','off',...
                        'callback',@toggle);
    bttnRmvCmplt = uicontrol('style','pushbutton',...
                        'position',[10 200 100 80], ...
                        'String','Final Design',...
                        'callback',@rmvCmplt);
    
    Vback   = uicontrol('style','pushbutton',...
                        'position',[1190 500 100 80], ...
                        'String','Add BackGate',...
                        'Enable','off',...
                        'callback',@addVback);
%     Vtop1   = uicontrol('style','pushbutton',...
%                         'position',[1190 200 100 80], ...
%                         'String','Add Vtop 1',...
%                         'Enable','off',...
%                         'callback',@addVtop1);
%     Vtop2   = uicontrol('style','pushbutton',...
%                         'position',[1190 100 100 80], ...
%                         'String','Add Vtop 2',...
%                         'Enable','off',...
%                         'callback',@addVtop2);
    Vtop   = uicontrol('style','pushbutton',...
                        'position',[1190 300 100 80], ...
                        'String','Add Vtop',...
                        'Enable','off',...
                        'callback',@addVtop);
                    
    BtopButton   = uicontrol('style','pushbutton',...
                        'position',[1190 400 100 80], ...
                        'String','Add Ferromagnets',...
                        'Enable','off',...
                        'callback',@addBtop);
    construct_structure
    set(ax,'Tag','ax');
    set(ax,'ButtonDownFcn',@axButtonDown)
    fprintf(1,'Remove every unneccesary atom... \n\n')

    function addVback(varargin)
       globals
       set(Vback,'Enable','off');
%        disp('Adding Vback');
       VbackSelect = 1;
       BG;
       set(ax,'ButtonDownFcn',@axButtonDown);
    end

    function addBtop(varargin)
       globals
       Btop = 1;
       BGV;
       set(ax,'ButtonDownFcn',@axButtonDown);
    end
%     function addVtop1(varargin)
%        globals
%        TopG1 = 1;
%        TGV1;
%        set(ax,'ButtonDownFcn',@axButtonDown);
%     end

    function addVtop(varargin)
       globals
       TopG = 1;
       TGV1;
       set(ax,'ButtonDownFcn',@axButtonDown);
    end

%     function addVtop2(varargin)
%        globals
%        TopG2 = 1;
%        TGV2;
%        set(ax,'ButtonDownFcn',@axButtonDown);
%     end


    function finalize(varargin)
       globals
       fin = 1;
       set(button1,'Enable','off');
       set(button2,'Enable','off');
       set(ToggleB,'Enable','off');
       set(Vback,'Enable','off');
       set(BtopButton,'Enable','off');
%        set(Vtop1,'Enable','on');
%        set(Vtop2,'Enable','on');
       set(Vtop,'Enable','off');
       conductance_computation
%        disp('ready')
       set(ax,'Tag','ax');
       set(ax,'ButtonDownFcn',@axButtonDown);
    end

    function rmvCmplt(varargin)
       globals
       removingContinues = 0;
       set(button1,'Enable','on');
       set(button2,'Enable','on');
       set(ToggleB,'Enable','on');
       set(Vback,'Enable','on');
%        set(Vtop1,'Enable','on');
%        set(Vtop2,'Enable','on');
       set(Vtop,'Enable','on');
       
       set(bttnRmvCmplt,'Enable','off');
       remove_atoms
       swtch = 1;
       fprintf(1,'Removal completed \n\n')
       fprintf(1,'FIRST STEP: Add Vback and/or Vtop, if it is needed\nSECOND STEP: Toggle the ribbon''s edges, if it is needed (DEFAULT: ARMCHAIR EDGES)\nTHIRD STEP: Choose Contacts \nFOURTH STEP: Add Ferromagnetic material for the contacts, if it is needed \n\n')
       fprintf(1,'**To select the appropriate atoms, define (by clicking on the figure) the upper left and then the down right points of the rectangle that contains the atoms\n\n')
    end


    function push(varargin)
       set(button1,'Enable','off');
       set(Vtop,'Enable','off');
       set(Vback,'Enable','off');       
       set(BtopButton,'Enable','on');
       set(ToggleB,'Enable','on');
       globals
%        disp('Choose ZigZag edges and/or select the contacts (Default: ArmChair edges)')
       swtch = 1;
       set(ax,'Tag','ax');
       set(ax,'ButtonDownFcn',@axButtonDown);
    end

    function toggle(varargin)
       globals
       disp('toggle from/to ZigZag edges')
       if vertical_contact == 0
          vertical_contact = 1;
          disp('ZigZag edges'' option is on')
       else
          vertical_contact = 0;
          disp('ArmChair edges'' option is on')
       end
       set(ax,'Tag','ax');
       set(ax,'ButtonDownFcn',@axButtonDown);
    end

    function axButtonDown(varargin)
        globals
        nextPhase = 0;
        %while nextPhase == 0
        cP = get(ax,'Currentpoint');
        if firstPoint == 1
            x1 = cP(1,1);
            y1 = cP(1,2);
            firstPoint = 0;
            X = [' ( ',num2str(x1) ,' ', num2str(y1) ,' ) '];
            disp(X);
        else
            x2 = cP(1,1);
            y2 = cP(1,2);
            firstPoint = 1;
            X = [' ( ',num2str(x2) ,' ', num2str(y2) ,' ) '];
            disp(X);
            if swtch == 0
               remove_atoms
               disp('The extra atoms were removed')
            elseif VbackSelect == 1
                add_Vback
                disp('Back Gate was added')
                VbackSelect = 0;
            elseif TopG1 == 1
                Tgate1
                disp('Top Gate 1 was added')
                TopG1 = 0;
            elseif TopG2 == 1
                Tgate2
                disp('Top Gate 2 was added')
                TopG2 = 0;
            elseif TopG == 1
                Tgate1
                disp('Top Gate was added')
                TopG = 0;
            elseif Btop ==1
%                 Bgate
                disp('Top magnetic Gate was added')
                Btop = 0;
                disp(H)
            else
               add_contacts
               disp('Contact added')
            end
            set(ax,'ButtonDownFcn',@axButtonDown)
        end
    end
end
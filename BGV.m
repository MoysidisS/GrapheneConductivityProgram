function BGV
    global Bvalue;
    global mag1;
    global mag2;
    global phi1;
    global phi2;
    global labelMag1;
    global labelMag2;
    global labelPhi1;
    global labelPhi2;
    figure('position',[500 400 470 250],'name', 'Magnetic Contacts'' Properties');
    
    mag1_=uicontrol('Style','edit','position',[45 100 50 50]);
    mag2_=uicontrol('Style','edit','position',[155 100 50 50]);
    phi1_=uicontrol('Style','edit','position',[265 100 50 50]);
    phi2_=uicontrol('Style','edit','position',[375 100 50 50]);   
    %labelMag1 = uilabel(BGVFig); %= uilabel("labelMag1","First Contact's Magnetic Magnitude");
    %labelMag1.text = "First Contact's Normalized Magnetic Amplitude";
    uicontrol('Style','pushbutton','String','Ok','position',[210 50 50 30],'callback',@press);
    uicontrol('Style','text','position',[20 150 100 50],'String',"First Contact's Normalized Magnetic Amplitude");
    uicontrol('Style','text','position',[130 150 100 50],'String',"Second Contact's Normalized Magnetic Amplitude");
    uicontrol('Style','text','position',[240 150 100 50],'String',"First Contact's Magnetic Angle in rads");
    uicontrol('Style','text','position',[350 150 100 50],'String',"Second Contact's Magnetic Angle in rads");
    Bvalue = 1;
    disp('Ferromagnetic Contacts in use...');
    function press(varargin)
       mag1 = str2double(mag1_.String);
       mag2 = str2double(mag2_.String);
       phi1 = str2num(phi1_.String);
       phi2 = str2num(phi2_.String);
       close();
    end
end
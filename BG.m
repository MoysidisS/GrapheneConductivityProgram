% top gate value

function BG
    global value3;
    figure('position',[600 400 400 200],'name', 'Adding a BackGate')
    uicontrol('Style','text','position',[140 120 100 50],'String',"Voltage (V)");
    
    h=uicontrol('Style','edit','position',[165 115 50 25]);
    uicontrol('Style','pushbutton','String','Ok','position',[165 70 50 25],'callback',@press);
    
    function press(varargin)
       value3 = str2double(h.String);
       fprintf('The BackGate''s Voltage is %d\n',value3);
%        disp(value3);
       close();
    end
end
% top gate value

function TGV1
    global value1;
    figure('position',[600 400 400 200],'Name', 'Adding a Top Gate')
    uicontrol('Style','text','position',[140 120 100 50],'String',"Voltage (V)");
    
    h=uicontrol('Style','edit','position',[165 115 50 25]);
    uicontrol('Style','pushbutton','String','Ok','position',[165 70 50 25],'callback',@press);
    
    function press(varargin)
       value1 = str2double(h.String);
       fprintf('The Top Gate''s Voltage is %d\n',value1);
%        disp(value3);
       close();
    end
end
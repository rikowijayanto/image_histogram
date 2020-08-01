function varargout = CITRA_GUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CITRA_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @CITRA_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function CITRA_GUI_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
handles.output = hObject;
clc;

axes(handles.logo)
imshow('logoits.png')
guidata(hObject, handles)

function varargout = CITRA_GUI_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
set(handles.kontras,'value',0);
[name_file1, name_path1] = uigetfile({'*.jpg;*.png;*.jpeg'});
if ~isequal(name_file1,0)
    cla reset
    handles.data1 = imread(fullfile(name_path1, name_file1));
    handles.data2 = imread(fullfile(name_path1, name_file1));
    handles.data1 = im2double(handles.data1);
    handles.data2 = im2double(handles.data2);
    
    axes(handles.ori_pic)
    imshow(handles.data1)
    axes(handles.adj_pic)
    imshow(handles.data2)
    set(handles.edit2,'String', name_file1);
    
        
    info = imfinfo(fullfile(name_path1, name_file1));
    bitdepth = info.BitDepth
    handles.bitdepth = bitdepth
    
    if(handles.bitdepth == 24)
        cla reset
        axes(handles.ori_his)
        red = handles.data1(:,:,1);
        green = handles.data1(:,:,2);
        blue = handles.data1(:,:,3);
        A= imhist(red);
        B= imhist(green);
        C= imhist(blue);
        x=1:256;
        plot(x,A,'r-')
        hold on
        plot(x,B,'g-')
        plot(x,C,'b-')
    
        axes(handles.adj_his)
        red = handles.data2(:,:,1);
        green = handles.data2(:,:,2);
        blue = handles.data2(:,:,3);
        A= imhist(red);
        B= imhist(green);
        C= imhist(blue);
        x=1:256;
        plot(x,A,'r-')
        hold on
        plot(x,B,'g-')
        plot(x,C,'b-')
    else
        cla reset
        axes(handles.ori_his)
        imhist(handles.data1)
        azes(handles.adj_his)
        imhist(handles.data2)
    end
   

    handles.p = handles.data2;
    guidata(hObject, handles); 
    set(handles.kon,'Value',1);
else
    return;
end


   



function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function kontras_Callback(hObject, eventdata, handles)
global gb1 gb2;
cla
nilai_slider = get(hObject,'value');
handles.p = handles.p+nilai_slider;
gb2 = handles.p;
axes(handles.adj_pic);
imshow(gb2);
axes(handles.adj_his)
red = gb2(:,:,1);
green = gb2(:,:,2);
blue = gb2(:,:,3);
A= imhist(red);
B= imhist(green);
C= imhist(blue);
x=1:256;
plot(x,A,'r-')
hold on
plot(x,B,'g-')
plot(x,C,'b-')
gudaiata(hObject, handles);
    
    




function kontras_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.


function bright_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in gray.
function gray_Callback(hObject, eventdata, handles)

function rgb_Callback(hObject, eventdata, handles)

function bw_Callback(hObject, eventdata, handles)

function neg_Callback(hObject, eventdata, handles)

function tombol_set_Callback(hObject, eventdata, handles)

function trans_SelectionChangeFcn(hObject, eventdata, handles)
switch(get(eventdata.NewValue,'Tag'));
    case 'ori'
        handles.p = handles.data2;
        axes(handles.adj_pic);
        imshow(handles.p);
        axes(handles.adj_his);
        red = handles.p(:,:,1);
        green = handles.p(:,:,2);
        blue = handles.p(:,:,3);
        A= imhist(red);
        B= imhist(green);
        C= imhist(blue);
        x=1:256;
        plot(x,A,'r-')
        hold on
        plot(x,B,'g-')
        plot(x,C,'b-')
        guidata(hObject, handles);
        
    case 'gray'
        cla reset
        
        handles.p = rgb2gray(handles.data2);
        axes(handles.adj_pic);
        imshow(handles.p);
        axes(handles.adj_his);
        imhist(handles.p)
        guidata(hObject, handles);
        
    case 'ori'
        cla reset
        handles.p = handles.data2;
        axes(handles.adj_pic);
        imshow(handles.p);
        guidata(hObject, handles);
        
    case 'black'
        cla reset
        T = graythresh(handles.data2);
        handles.p=im2bw(handles.data2,T);
        axes(handles.adj_pic);
        guidata(hObject, handles);
        imshow(handles.p)
        axes(handles.adj_his);
        imhist(handles.p)
        guidata(hObjectt, handles);
        
    case 'neg'
        cla reset
        axes(handles.adj_pic)
        handles.p = imcomplement(handles.data2);
        imshow(handles.p)
        axes(handles.adj_his);
        imhist(rgb2gray(handles.p));
        guidata(hObject, handles);
  
        
end

function kontras_ButtonDownFcn(hObject, eventdata, handles)

function kon_Callback(hObject, eventdata, handles)
global gb1 gb2;
cla
nilai_slider = get(hObject,'value');
gambar = handles.p*nilai_slider;
gb2 = gambar;
axes(handles.adj_pic);
imshow(gb2);
axes(handles.adj_his)
red = gb2(:,:,1);
green = gb2(:,:,2);
blue = gb2(:,:,3);
A= imhist(red);
B= imhist(green);
C= imhist(blue);
x=1:256;
plot(x,A,'r-')
hold on
plot(x,B,'g-')
plot(x,C,'b-')
guidata(hObject, handles);


function kon_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes when selected object is changed in uipanel7.
function uipanel7_SelectionChangeFcn(hObject, eventdata, handles)
switch(get(eventdata.NewValue,'Tag'));
    case 'equiv'
        cla reset
        handles.p = histeq(rgb2gray(handles.data2),256);
        axes(handles.adj_pic);
        imshow(handles.p);
        axes(handles.adj_his);
        imhist(handles.p);
        guidata(hObject, handles);
        
    case 'norm'
        cla reset
        citra = rgb2gray(handles.data2);
        [m,n,~]=size(handles.p);
        mins = min(min(citra));
        maks = max(max(citra));
        
        a=size(citra)
        tot = (a(1)*a(2))-1;
        for i= 1:m
            for j=1:n
                citra(i,j)=((citra(i,j)-mins)./(maks-mins))*tot;
            end;
        end;
        handles.p = citra;
        axes(handles.adj_pic);
        imshow(handles.p);
        axes(handles.adj_his);
        imhist(handles.p);
        guidata(hObject, handles);
        
    case 'equiv2'
        cla reset
        handles.p = adapthisteq(rgb2gray(handles.data2));
        axes(handles.adj_pic);
        imshow(handles.p);
        axes(handles.adj_his);
        imhist(handles.p);
       
        
end;

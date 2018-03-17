function varargout = figure(varargin)
% FIGURE MATLAB code for figure.fig
%      FIGURE, by itself, creates a new FIGURE or raises the existing
%      singleton*.
%
%      H = FIGURE returns the handle to a new FIGURE or the handle to
%      the existing singleton*.
%
%      FIGURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIGURE.M with the given input arguments.
%
%      FIGURE('Property','Value',...) creates a new FIGURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before figure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to figure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help figure

% Last Modified by GUIDE v2.5 25-Mar-2017 08:59:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @figure_OpeningFcn, ...
                   'gui_OutputFcn',  @figure_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before figure is made visible.
function figure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to figure (see VARARGIN)

% Choose default command line output for figure
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes figure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = figure_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file path] = uigetfile({'*jpg','*png'},'FileSelect');
a=imread(file);
axes(handles.axes1);
imshow(a);
handles.cimage=a;
guidata(hObject,handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'cimage')
    i=handles.cimage;
    g=rgb2gray(i);
    axes(handles.axes3);
    imshow(g);
end
handles.gimage=g;
guidata(hObject,handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'gimage')
    j=handles.gimage;
    bw=im2bw(j,0.7);
    axes(handles.axes2);
    imshow(bw);
end
handles.bwimage=bw;
guidata(hObject,handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'cimage')
    ni=handles.cimage;
    ni=imnoise(ni,'salt & pepper',0.30);
    axes(handles.axes4);
    imshow(ni);
end
handles.niimage=ni;
guidata(hObject,handles);
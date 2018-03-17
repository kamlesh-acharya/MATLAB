function varargout = ICT(varargin)
% ICT MATLAB code for ICT.fig
%      ICT, by itself, creates a new ICT or raises the existing
%      singleton*.
%
%      H = ICT returns the handle to a new ICT or the handle to
%      the existing singleton*.
%
%      ICT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ICT.M with the given input arguments.
%
%      ICT('Property','Value',...) creates a new ICT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ICT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ICT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ICT

% Last Modified by GUIDE v2.5 09-Mar-2018 11:40:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ICT_OpeningFcn, ...
                   'gui_OutputFcn',  @ICT_OutputFcn, ...
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


% --- Executes just before ICT is made visible.
function ICT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ICT (see VARARGIN)

% Choose default command line output for ICT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ICT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ICT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[file_name path]=uigetfile({'*.bmp;*.jpg;*.png;*.tiff;';'*.*'},'Select an Image File');
fileinfo = dir(file_name);
InputImage = imread(file_name);
[M , N] = size(InputImage);
Temp = strsplit(fileinfo.name,'.');
Ext = Temp(2);
SIZE = fileinfo.bytes;
Size = SIZE/1024;

set(handles.text36,'string',sprintf('%.2f KB',Size));
set(handles.text42,'string',sprintf('%.2f KB',Size));
set(handles.text48,'string',sprintf('%.2f KB',Size));

imshow(file_name,'Parent', handles.axes1)
imshow(file_name,'Parent', handles.axes3)
imshow(file_name,'Parent', handles.axes5) 

%% %BT-CODE
Out_file_name = strcat('Out_Bt.',Ext);
Out_Bt = btcode(file_name,4,4,Out_file_name{1});
fileinfo = dir(Out_file_name{1});
SIZE = fileinfo.bytes;
Out_Size = SIZE/1024;

set(handles.text39,'string',sprintf('%.2f KB',Out_Size));
imshow(Out_Bt,'Parent', handles.axes2)

MSE = sum(sum((InputImage-Out_Bt).^2))/(M*N);
PSNR = 10*log10(256*256/MSE);
CR = (Size/Out_Size);

set(handles.text37,'string',sprintf('%7.2f',MSE));
set(handles.text38,'string',sprintf('%9.5f dB',PSNR));
set(handles.text54,'string',sprintf('%.2f ',CR));

%% DCT-Comp
Out_file_name = strcat('Out_Dct.',Ext);
Out_Bt = dctcompr(file_name,15000,Out_file_name{1});
fileinfo = dir(Out_file_name{1});
SIZE = fileinfo.bytes;
Out_Size = SIZE/1024;

set(handles.text45,'string',sprintf('%.2f KB',Out_Size));
imshow(Out_Bt,'Parent', handles.axes4)

MSE = sum(sum((InputImage-Out_Bt).^2))/(M*N);
PSNR = 10*log10(256*256/MSE);
CR = (Size/Out_Size);

set(handles.text43,'string',sprintf('%7.2f',MSE));
set(handles.text44,'string',sprintf('%9.5f dB',PSNR));
set(handles.text55,'string',sprintf('%.2f ',CR));

%% %SVT
Out_file_name = strcat('Out_Svt.',Ext);
Out_Bt = imcompr(file_name,200,Out_file_name{1});
fileinfo = dir(Out_file_name{1});
SIZE = fileinfo.bytes;
Out_Size = SIZE/1024;

set(handles.text51,'string',sprintf('%.2f KB',Out_Size));
imshow(Out_Bt,'Parent', handles.axes6)

MSE = sum(sum((InputImage-Out_Bt).^2))/(M*N);
PSNR = 10*log10(256*256/MSE);
CR = (Size/Out_Size);

set(handles.text49,'string',sprintf('%7.2f',MSE));
set(handles.text50,'string',sprintf('%9.5f dB',PSNR));
set(handles.text56,'string',sprintf('%.2f ',CR));

%% Get default command line output from handles structure
varargout{1} = handles.output;

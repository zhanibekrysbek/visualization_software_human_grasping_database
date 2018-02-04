function varargout = hgd_nu_visual(varargin)
% HGD_NU_VISUAL MATLAB code for hgd_nu_visual.fig
%      HGD_NU_VISUAL - software created as part of Nazarbayev University 
%      Human Grasping Database project.
%
% HGD_NU_VISUAL allows to visualize all three channels (Kinematic, RGB and Depth)
%      and plays concurrently. 
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Edit the above text to modify the response to help hgd_nu_visual

% Last Modified by GUIDE v2.5 04-Feb-2018 14:52:20
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hgd_nu_visual_OpeningFcn, ...
                   'gui_OutputFcn',  @hgd_nu_visual_OutputFcn, ...
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


% --- Executes just before hgd_nu_visual is made visible.
function hgd_nu_visual_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hgd_nu_visual (see VARARGIN)

% Choose default command line output for hgd_nu_visual
handles.output = hObject;
% initialize global variables
handles.videoFileNameGopro = 0;
handles.posGopro = 1;
handles.posXsens = 1;
handles.posDepth = 1;
set(handles.figure1, 'Name', 'NU Human Grasping Database visual');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes hgd_nu_visual wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hgd_nu_visual_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

r = get(hObject,'Value');
handles.posXsens = round(r*size(handles.segment_pos,3));
if handles.posXsens == 0
    handles.posXsens = 1;
end
showXsensFrame(handles, handles.posXsens);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

r = get(hObject,'Value');
handles.posGopro = round(r*handles.vidGopro.NumberOfFrames);
if handles.posGopro == 0
    handles.posGopro = 1;
end
showGoproFrame(handles, handles.posGopro);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% functionality of slider3 under Depth stream axis
% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% read the current value
r = get(hObject,'Value');
% convert rescale to frame number and show to screen
handles.posDepth = round(r*handles.vidDepth.NumberOfFrames);
if handles.posDepth == 0
    handles.posDepth = 1;
end
showDepthFrame(handles, handles.posDepth);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function fileNameXsens_Callback(~, ~, ~)
% hObject    handle to fileNameXsens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fileNameXsens as text
%        str2double(get(hObject,'String')) returns contents of fileNameXsens as a double


% --- Executes during object creation, after setting all properties.
function fileNameXsens_CreateFcn(hObject, ~, ~)
% hObject    handle to fileNameXsens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% loads specified csv value for kinematic data
% --- Executes on button press in loadXsens.
function loadXsens_Callback(hObject, ~, handles)
% hObject    handle to loadXsens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% initilize current index of xsens frame
handles.posXsens = 1;
% read raw xsens data
A = csvread(get(handles.fileNameXsens,'String'));
if size(A,2) == 228
    A(:, end) = []; % Remove last zero column
end
% extract segment data
B = A(:, 1:150)'; 
% rearrange segment data matrix. At the end B is 15x10xTotalFrame
% dimensional matrix. 15 stands for number of segments. 10 stands for 10
% data points for each segments (i.e. 3 positions, 4 quaternion and 3
% angular velocity). And the third dimension for frame numbers
B = reshape(B, [10, 15, size(B, 2)]);
B = permute(B, [2, 1, 3]);
% Since we are interested at only position data we discard all unnesessary
% information.
handles.segment_pos = B(:, 1:3, :); % Segment position data
showXsensFrame(handles, handles.posXsens);
guidata(hObject,handles);

% --- Executes on button press in playPauseXsens.
function playPauseXsens_Callback(hObject, eventdata, handles)
% hObject    handle to playPauseXsens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% if it runs out all frames in the video file then go back to initiale
% state and pause.
if get(handles.slider1, 'Value') == 1 && get(hObject, 'Value')
    handles.posXsens = 1;
    set(handles.slider1,'Value', 0);
end
% update the name of button depending on toggle state
if get(hObject,'Value')
    set(hObject,'String', 'Pause');
else 
    set(hObject,'String', 'Play');
end
% run the loop for showing images until toggle state changes to "pause" or
% until the end of video file
while get(hObject, 'Value') && handles.posXsens < size(handles.segment_pos,3);
    % increment the frame number and show that frame
    handles.posXsens = handles.posXsens + 1;
    showXsensFrame(handles, handles.posXsens);
    pause(0.1);
   % if we are at the end of video file bring toggle state to false
    if handles.posXsens == size(handles.segment_pos,3) 
        set(hObject,'String', 'Play', 'Value', false);
    end
end
guidata(hObject,handles);

% goes to the previous frame. It is useful if user wants to play the video very
% slowly 
% --- Executes on button press in takeFrameXsens.
function takeFrameXsens_Callback(hObject, ~, handles)
% hObject    handle to takeFrameXsens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% check that we can go back safely
if handles.posXsens - 1 >=1
    % update current frame index and show the image
    handles.posXsens = handles.posXsens - 1;
    showXsensFrame(handles, handles.posXsens);
end
guidata(hObject, handles);

% goes to the next frame. It is useful if user wants to play the video very
% slowly 
% --- Executes on button press in addFrameXsens.
function addFrameXsens_Callback(hObject, eventdata, handles)
% hObject    handle to addFrameXsens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% check that we can show the next frame
if handles.posXsens + 1 <= size(handles.segment_pos,3)
    % update current frame index and show the image
    handles.posXsens = handles.posXsens + 1;
    showXsensFrame(handles, handles.posXsens);
end
guidata(hObject, handles);

% one of the media control buttons. It goes back to first frame in the
% video file
% --- Executes on button press in stopXsens.
function stopXsens_Callback(hObject, eventdata, handles)
% hObject    handle to stopXsens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Assign 1 to index of current frame and show it
handles.posXsens = 1;
showXsensFrame(handles, handles.posXsens);
guidata(hObject,handles);


% if user wants to go to a specific frame. Reads the desired frame and
% shows it in the axis2
function jumpXsens_Callback(hObject, eventdata, handles)
% hObject    handle to jumpXsens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% read and convert to number of desired frame number
k = str2double(get(hObject,'String'));
if k >= 1 && k <= size(handles.segment_pos,3)
    handles.posXsens = k;
    showXsensFrame(handles, handles.posXsens);
else
    msgbox('You entered invalid number', 'Wrong Input','warn','modal');   
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function jumpXsens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jumpXsens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fileNameGopro_Callback(hObject, eventdata, handles)
% hObject    handle to fileNameGopro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fileNameGopro as text
%        str2double(get(hObject,'String')) returns contents of fileNameGopro as a double
handles.videoFileNameGopro = get(hObject,'String');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function fileNameGopro_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileNameGopro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadGopro.
function loadGopro_Callback(hObject, eventdata, handles)
% hObject    handle to loadGopro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% read path of the interested video file and separate 
videoFileGoproPath = get(handles.fileNameGopro,'String');
% handles.videoFileGoproPath = get(handles.pathGopro,'String');
[~,name,ext] = fileparts(videoFileGoproPath);
% store video file name to global variable
handles.videoFileNameGopro = [name ext];
% call VideoReader class to open vid object
handles.vidGopro = VideoReader(videoFileGoproPath);
% initialize current frame num
handles.posGopro = 1;
% show first frame
showGoproFrame(handles, handles.posGopro);
% set(handles.fileName, 'String', handles.videoFileGopro);
guidata(hObject,handles);



function fileNameDepth_Callback(hObject, eventdata, handles)
% hObject    handle to fileNameDepth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.videoFileNameDepth = get(hObject,'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of fileNameDepth as text
%        str2double(get(hObject,'String')) returns contents of fileNameDepth as a double

% --- Executes during object creation, after setting all properties.
function fileNameDepth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileNameDepth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadDepth.
function loadDepth_Callback(hObject, eventdata, handles)
% hObject    handle to loadDepth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% read file name
handles.videoFileNameDepth = get(handles.fileNameDepth,'String');
% set current index of depth stream to 1
handles.posDepth = 1;
% load depth video file
handles.vidDepth = VideoReader(handles.videoFileNameDepth);
showDepthFrame(handles, handles.posDepth);
guidata(hObject,handles);


% --- Executes on button press in playPauseDepth.
function playPauseDepth_Callback(hObject, eventdata, handles)
% hObject    handle to playPauseDepth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% if it runs out all frames in the video file then go back to initiale
% state and pause.
if get(handles.slider3, 'Value') == 1 && get(hObject, 'Value')
    handles.posDepth = 1;
    set(handles.slider3,'Value', 0);
end
% update the name of button depending on toggle state
if get(hObject,'Value')
    set(hObject,'String', 'Pause');
else 
    set(hObject,'String', 'Play');
end
% run the loop for showing images until toggle state changes to "pause" or
% until the end of video file
while get(hObject,'Value') && handles.posDepth < handles.vidDepth.NumberOfFrames
    handles.posDepth = handles.posDepth + 1;
    showDepthFrame(handles, handles.posDepth);
    pause(0.1);
    if handles.posDepth == handles.vidDepth.NumberOfFrames 
        set(hObject,'String', 'Play', 'Value', false);
    end
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of playPauseDepth


% goes to the previous frame. It is useful if user wants to play the video very
% slowly 
% --- Executes on button press in takeFrameDepth.
function takeFrameDepth_Callback(hObject, eventdata, handles)
% hObject    handle to takeFrameDepth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% check that we can go back safely
if handles.posDepth - 1 >= 1
    % update current frame index and show the image
    handles.posDepth = handles.posDepth - 1;
    showDepthFrame(handles, handles.posDepth);
end
guidata(hObject, handles);

% goes to the next frame. It is useful if user wants to play the video very
% slowly 
% --- Executes on button press in addFrameDepth.
function addFrameDepth_Callback(hObject, eventdata, handles)
% hObject    handle to addFrameDepth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% check that we can show the next frame
if handles.posDepth + 1 <= handles.vidDepth.NumberOfFrames
% update current frame index and show the image
    handles.posDepth = handles.posDepth + 1;
    showDepthFrame(handles, handles.posDepth);
end
guidata(hObject, handles);

% one of the media control buttons. It goes back to first frame in the
% video file
% --- Executes on button press in stopDepth.
function stopDepth_Callback(hObject, eventdata, handles)
% hObject    handle to stopDepth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Assign 1 to index of current frame and show it
handles.posDepth = 1;
showDepthFrame(handles, handles.posDepth);
guidata(hObject,handles);


% if user wants to go to a specific frame. Reads the desired frame and
% shows it in the axis2
function jumpDepth_Callback(hObject, eventdata, handles)
% hObject    handle to jumpDepth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% read and convert to number of desired frame number
k = str2double(get(hObject,'String'));
if k >= 1 && k <= handles.vidDepth.NumberOfFrames
    handles.posDepth = k;
    showDepthFrame(handles, handles.posDepth);
else
    msgbox('You entered invalid number', 'Wrong Input','warn','modal');   
end
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of jumpDepth as text
%        str2double(get(hObject,'String')) returns contents of jumpDepth as a double


% --- Executes during object creation, after setting all properties.
function jumpDepth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jumpDepth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% Play/pause toggle button's callback function. Depending on the state 
% function will play rgb video stream or pause
function playPauseGopro_Callback(hObject, eventdata, handles)
% hObject    handle to playPauseGopro (see GCBO)
% handles    structure with handles and user data (see GUIDATA)

% if it runs out all frames in the video file then go back to initiale
% state and pause.
if get(handles.slider2, 'Value') == 1 && get(hObject, 'Value')
    handles.posGopro = 1;
    set(handles.slider2,'Value', 0);
end
% update the name of button depending on toggle state
if get(hObject,'Value')
    set(hObject,'String', 'Pause');
else 
    set(hObject,'String', 'Play');
end
% run the loop for showing images until toggle state changes to "pause" or
% until the end of video file
while get(hObject,'Value') && handles.posGopro < handles.vidGopro.NumberOfFrames
    % increment the frame number and show that frame
    handles.posGopro = handles.posGopro + 1;
    showGoproFrame(handles, handles.posGopro);
    pause(0.1);
   % if we are at the end of video file bring toggle state to false
    if handles.posGopro == handles.vidGopro.NumberOfFrames 
        set(hObject,'String', 'Play', 'Value', false);
    end
end
% Hint: get(hObject,'Value') returns toggle state of playPauseGopro
guidata(hObject, handles);

% goes to the previous frame. It is useful if user wants to play the video very
% slowly 
% --- Executes on button press in takeFrameGopro.
function takeFrameGopro_Callback(hObject, eventdata, handles)
% hObject    handle to takeFrameGopro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% check that we can go back safely
if handles.posGopro - 1 >= 1
    % update current frame index and show the image
    handles.posGopro = handles.posGopro - 1;
    showGoproFrame(handles, handles.posGopro);
end
guidata(hObject, handles);

% goes to the next frame. It is useful if user wants to play the video very
% slowly 
% --- Executes on button press in addFrameGopro.
function addFrameGopro_Callback(hObject, eventdata, handles)
% hObject    handle to addFrameGopro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% check that we can show the next frame
if handles.posGopro + 1 <= handles.vidGopro.NumberOfFrames
    % increment current frame index and show that image
    handles.posGopro = handles.posGopro + 1;
    showGoproFrame(handles, handles.posGopro);
end
guidata(hObject, handles);

% one of the media control buttons. It goes back to first frame in the
% video file
% --- Executes on button press in stopGopro.
function stopGopro_Callback(hObject, eventdata, handles)
% hObject    handle to stopGopro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Assign 1 to index of current frame and show it
handles.posGopro = 1;
showGoproFrame(handles, handles.posGopro);
guidata(hObject,handles);

% if user wants to go to a specific frame. Reads the desired frame and
% shows it in the axis2
function jumpGopro_Callback(hObject, eventdata, handles)
% hObject    handle to jumpGopro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% read and convert to number of desired frame number
k = str2double(get(hObject,'String'));
if k >= 1 && k <= handles.vidGopro.NumberOfFrames
    handles.posGopro = k;
    showGoproFrame(handles, handles.posGopro);
else
    msgbox('You entered invalid number', 'Wrong Input','warn','modal');   
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function jumpGopro_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jumpGopro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% Helper function. It is responsible to show the specified frame and update
% relating information for RGB stream (Gopro).
function outPut = showGoproFrame(handles, frameNum)
    snapshot2 = read(handles.vidGopro, frameNum);   % read the next frame
    % update the static text field to show current frame
    set(handles.goproFrameCount, 'String', sprintf('%d/%d', frameNum, handles.vidGopro.NumberOfFrames));
    % activate axes for RGB
    axes(handles.axes2);
    % throw selected frame to active axis
    imshow(snapshot2);
    % update the slider2
    set(handles.slider2, 'Value', (frameNum/handles.vidGopro.NumberOfFrames));
    outPut = handles;

% Helper function. It is responsible to show the specified frame and update
% relating information for Depth stream.
function outPut = showDepthFrame(handles, frameNum)
    % read the frame of interest and convert that to pseudoColor image
    snapshot3 = read(handles.vidDepth, frameNum);
    snapshot3 = pseudoColorDepthImage(snapshot3);
    % update the static text field to show current frame
    set(handles.depthFrameCount, 'String', sprintf('%d/%d', frameNum, handles.vidDepth.NumberOfFrames));
    axes(handles.axes3); % activate axis3
    imshow(snapshot3);      % throw the image
    % update slider3
    x = (double(frameNum) / double(handles.vidDepth.NumberOfFrames) );
    set(handles.slider3, 'Value', x);  
outPut = handles;

% Helper function. It is responsible to show the specified frame and update
% relating information for Kinematic data stream.
function outPut = showXsensFrame(handles, frameNum)
% activate axis for Xsens: axes1
axes(handles.axes1);
% plot the skeleton
skeletonViewer(handles.segment_pos(:,:,frameNum));
% update the static text field to show current frame
set(handles.xsensFrameCount, 'String', sprintf('%d/%d', frameNum, size(handles.segment_pos,3)));
% update slider1
set(handles.slider1, 'Value', (frameNum/size(handles.segment_pos,3)));
outPut = handles;


% concurrently play all selected channels. note that we assume xsens is 4
% times as fast as other two channels. ie framerate Xsens = 120, 
% Gopro = 30, Depth = 30.
% --- Executes on button press in playPauseAll.
function playPauseAll_Callback(hObject, eventdata, handles)
% hObject    handle to playPauseAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% xsens
xcheck = get(handles.xsensCheckAll, 'value');
% gopro
gcheck = get(handles.goproCheckAll, 'value');
% depth
dcheck = get(handles.depthCheckAll, 'value');

% if it runs out all frames in the video file then go back to initiale
% state and pause.

% update the name of button depending on toggle state
if get(hObject,'Value')
    set(hObject,'String', 'Pause');
else 
    set(hObject,'String', 'Play');
end
% run the loop for showing images until toggle state changes to "pause" or
% until the end of video file
while get(hObject,'Value')
    count = 1;
    while xcheck && count <=4  && handles.posXsens <= size(handles.segment_pos,3)
        handles.posXsens = handles.posXsens + 1;
        showXsensFrame(handles, handles.posXsens);
        count = count + 1;
        pause(0.1);
    end
    if gcheck && handles.posGopro <= handles.vidGopro.NumberOfFrames
        % increment the frame number and show that frame
        handles.posGopro = handles.posGopro + 1;
        showGoproFrame(handles, handles.posGopro);
    end
    
    if dcheck && handles.posDepth <= handles.vidDepth.NumberOfFrames
        handles.posDepth = handles.posDepth + 1;
        showDepthFrame(handles, handles.posDepth);
    end
   % if we are at the end of video file bring toggle state to false
    if handles.posGopro == handles.vidGopro.NumberOfFrames 
        set(hObject,'String', 'Play', 'Value', false);
    end
    pause(0.1);
end
% Hint: get(hObject,'Value') returns toggle state of playPauseGopro
guidata(hObject, handles);




% Hint: get(hObject,'Value') returns toggle state of playPauseAll


% --- Executes on button press in takeFrameAll.
function takeFrameAll_Callback(hObject, eventdata, handles)
% hObject    handle to takeFrameAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xcheck = get(handles.xsensCheckAll, 'value');
if xcheck == 1 && handles.posXsens - 4 >= 1
    handles.posXsens = handles.posXsens - 4;
    showXsensFrame(handles, handles.posXsens);
elseif handles.posXsens - 4 < 1
    handles.posXsens = 1;
    showXsensFrame(handles, handles.posXsens);
end
% gopro
gcheck = get(handles.goproCheckAll, 'value');
if gcheck == 1 && handles.posGopro - 1 >= 1
    handles.posGopro = handles.posGopro - 1;
    showGoproFrame(handles, handles.posGopro);
elseif handles.posGopro - 1 < 1
    handles.posGopro = 1;
    showGoproFrame(handles, handles.posGopro);
end

% depth
dcheck = get(handles.depthCheckAll, 'value');
if dcheck == 1 && handles.posDepth - 1 >= 1
    handles.posDepth = handles.posDepth - 1;
    showDepthFrame(handles, handles.posDepth);
elseif  handles.posDepth - 1 < 1
    handles.posDepth = 1;
    showDepthFrame(handles, handles.posDepth);
end

guidata(hObject, handles)


% --- Executes on button press in addFrameAll.
function addFrameAll_Callback(hObject, eventdata, handles)
% hObject    handle to addFrameAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xcheck = get(handles.xsensCheckAll, 'value');
if xcheck == 1 && handles.posXsens + 4 < size(handles.segment_pos,3)
    handles.posXsens = handles.posXsens + 4;
    showXsensFrame(handles, handles.posXsens);
elseif handles.posXsens + 4 < size(handles.segment_pos,3)
    handles.posXsens = size(handles.segment_pos,3);
    showXsensFrame(handles, handles.posXsens);
end
% gopro
gcheck = get(handles.goproCheckAll, 'value');
if gcheck == 1 && handles.posGopro + 1 < handles.vidGopro.NumberOfFrames
    handles.posGopro = handles.posGopro + 1;
    showGoproFrame(handles, handles.posGopro);
elseif handles.posGopro + 1 < handles.vidGopro.NumberOfFrames
    handles.posGopro = handles.vidGopro.NumberOfFrames;
    showGoproFrame(handles, handles.posGopro);
end
% depth
dcheck = get(handles.depthCheckAll, 'value');
if dcheck == 1 && handles.posDepth + 1 < handles.vidDepth.NumberOfFrames
    handles.posDepth = handles.posDepth + 1;
    showDepthFrame(handles, handles.posDepth);
elseif  handles.posDepth + 1 < handles.vidDepth.NumberOfFrames
    handles.posDepth = handles.vidDepth.NumberOfFrames;
    showDepthFrame(handles, handles.posDepth);
end
guidata(hObject, handles);



% media control button that belongs to "Play all" button group
% --- Executes on button press in stopAll.
function stopAll_Callback(hObject, eventdata, handles)
% hObject    handle to stopAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% depending on selected choice of concurrent channels we activate stop functionality 
xcheck = get(handles.xsensCheckAll, 'value');
if xcheck == 1
    handles.posXsens = 1;
    showXsensFrame(handles, handles.posXsens);
end

gcheck = get(handles.goproCheckAll, 'value');
if gcheck == 1
    handles.posGopro = 1;
    showGoproFrame(handles, handles.posGopro);
end

dcheck = get(handles.depthCheckAll, 'value');
if dcheck == 1
    handles.posDepth = 1;
    showDepthFrame(handles, handles.posDepth);
end

guidata(hObject, handles);



% --- Executes on button press in fastBackwardAll.
function fastBackwardAll_Callback(hObject, eventdata, handles)
% hObject    handle to fastBackwardAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% depending on selected choice of concurrent channels we activate stop functionality 

% 15 is taken as standard value for the amount of frames to go back/forward
% xsens
xcheck = get(handles.xsensCheckAll, 'value');
if xcheck == 1 && handles.posXsens - 4*15 >= 1
    handles.posXsens = handles.posXsens - 4*15;
    showXsensFrame(handles, handles.posXsens);
elseif handles.posXsens - 4*15 < 1
    handles.posXsens = 1;
    showXsensFrame(handles, handles.posXsens);
end
% gopro
gcheck = get(handles.goproCheckAll, 'value');
if gcheck == 1 && handles.posGopro - 15 >= 1
    handles.posGopro = handles.posGopro - 15;
    showGoproFrame(handles, handles.posGopro);
elseif handles.posGopro - 15 < 1
    handles.posGopro = 1;
    showGoproFrame(handles, handles.posGopro);
end
% depth
dcheck = get(handles.depthCheckAll, 'value');
if dcheck == 1 && handles.posDepth - 15 >= 1
    handles.posDepth = handles.posDepth - 15;
    showDepthFrame(handles, handles.posDepth);
elseif  handles.posDepth - 15 < 1
    handles.posDepth = 1;
    showDepthFrame(handles, handles.posDepth);
end

guidata(hObject, handles)

% --- Executes on button press in fastForwardAll.
function fastForwardAll_Callback(hObject, eventdata, handles)
% hObject    handle to fastForwardAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 15 is taken as standard value for the amount of frames to go back/forward
% xsens
xcheck = get(handles.xsensCheckAll, 'value');
if xcheck == 1 && handles.posXsens + 4*15 <= size(handles.segment_pos,3)
    handles.posXsens = handles.posXsens + 4*15;
    showXsensFrame(handles, handles.posXsens);
elseif handles.posXsens + 4*15 < size(handles.segment_pos,3)
    handles.posXsens = size(handles.segment_pos,3);
    showXsensFrame(handles, handles.posXsens);
end
% gopro
gcheck = get(handles.goproCheckAll, 'value');
if gcheck == 1 && handles.posGopro + 15 <= handles.vidGopro.NumberOfFrames
    handles.posGopro = handles.posGopro + 15;
    showGoproFrame(handles, handles.posGopro);
elseif handles.posGopro + 15 < handles.vidGopro.NumberOfFrames
    handles.posGopro = handles.vidGopro.NumberOfFrames;
    showGoproFrame(handles, handles.posGopro);
end
% depth
dcheck = get(handles.depthCheckAll, 'value');
if dcheck == 1 && handles.posDepth + 15 <= handles.vidDepth.NumberOfFrames
    handles.posDepth = handles.posDepth + 15;
    showDepthFrame(handles, handles.posDepth);
elseif  handles.posDepth + 15 < handles.vidDepth.NumberOfFrames
    handles.posDepth = handles.vidDepth.NumberOfFrames;
    showDepthFrame(handles, handles.posDepth);
end
guidata(hObject, handles);


% --- Executes on button press in xsensCheckAll.
function xsensCheckAll_Callback(hObject, eventdata, handles)
% hObject    handle to xsensCheckAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of xsensCheckAll


% --- Executes on button press in goproCheckAll.
function goproCheckAll_Callback(hObject, eventdata, handles)
% hObject    handle to goproCheckAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of goproCheckAll


% --- Executes on button press in depthCheckAll.
function depthCheckAll_Callback(hObject, eventdata, handles)
% hObject    handle to depthCheckAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of depthCheckAll


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% another way of opening csv file
% --- Executes on button press in xsensBrowse.
function xsensBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to xsensBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ name, path, ~] = uigetfile('*.csv');
% check the selected file name and load video file
if name ~= 0
    handles.videoFileXsensPath = [path '\' name];
    % fill fileNameXsens edit text area with file name
    set(handles.fileNameXsens, 'String', handles.videoFileXsensPath);
end
guidata(hObject, handles);

% another way of opening gopro video file
% --- Executes on button press in goproBrowse.
function goproBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to goproBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ name, path, ~] = uigetfile('*.mp4');
% check the selected file name and load video file
if name ~= 0
    handles.videoFileGoproPath = [path '\' name];
    % fill fileNameXsens edit text area with file name
    set(handles.fileNameGopro, 'String', handles.videoFileGoproPath);
end
guidata(hObject, handles);

% --- Executes on button press in depthBrowse.
function depthBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to depthBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ name, path, ~] = uigetfile('*.mj2');
% check the selected file name and load video file
if name ~= 0
    handles.videoFileDepthPath = [path '\' name];
    % fill fileNameXsens edit text area with file name
    set(handles.fileNameDepth, 'String', handles.videoFileDepthPath);
end
guidata(hObject, handles);

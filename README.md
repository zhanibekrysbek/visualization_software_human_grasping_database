# visualization_software_human_grasping_database



Vizualization software for Nazarbayev University Human Grasping Database project

This software was created as part of Nazarbayev University Human Grasping Database project
to visualize three channels concurrently. Particularly, it allows users to access frame by frame
Kinematic, RGB and Depth streams.

===========================================================================
STRUCTURE of SOFTWARE


	This is a single window software with additional helper functions ("pseudoColorDepthImage.m", 
	"skeletonViewer.m").

	"hgd_nu_visual.fig" contains three sections, denoted as Xsens, Gopro and Depth.
	Each section consists identical items:
		- axes: to display the data visually
		
		- slider: to see the progress and to control
		
		- media-control button group: funcionality is similar to regular media-controls
			- Play/Pause button: to play or pause.
			- Stop: brings the current fram back to first
			- +1 frame: shows next frame.
			- -1 frame: shows previous frame.
			- edit text (jump to frame): jumps into specified frame
		
		- General media-control button group: plays selected channels concurrently
			- Play/Pause button: to play or pause.
			- Stop: brings the current fram back to first
			- +1 frame: shows next frame.
			- -1 frame: shows previous frame.
			- edit text (jump to frame): jumps into specified frame
			- >>| and |<<: similar to fast forward, but it jumps to next/previous 0.5 seconds
			(equivalent for xsens: 60 frames, gopro and depth: 15 frames)
			
		
		- edit text: to specify file name and its path
		
		- load button: loads specified file at edit text field and displays first frame 
		in corresponding axes
		
		- browse button: another way of specifying input file. user interface pops up 
		to prompting to select a file of interest
			
	
	"pseudoColorDepthImage.m" - a MATLAB function that accepts 16bit single channel depth image
	and returns its pseudo color version implemented using jet colormap. For more information 
	refer to "pseudoColorDepthImage.m"
		
	"skeletonViewer.m" - a MATLAB function specificly built to sketch skeleton of a subject from 
	raw data captured by Xsens MVN. It extracts x-y-z position data from csv file and plots them 
	frame by frame. For more information please refer to "skeletonViewer.m" and "loadXsens" callback
	function of "hgd_nu_visual.m". 
	
=====================================================================	
HOW TO USE
	
	1) Run "hgd_nu_visual.fig"/"hgd_nu_visual.m"
	2) Specify input files:
		- For Xsens/Gopro/Depth part enter the file name along with path to corresponding edit text field.
		OR click "Browse" button and find target file.
	3) Click "Load". It may take a moment to load. An image should appear at corresponding axes once loaded.
	4) Check that it plays.
	5) To find frames at Xsens, Gopro and Depth channels corresponding to the same instant of time choose frame numbers in the following way:
	
	Get gopro frames of grasp X from the provided annotation file: 
	
		Gopro Frame = "StartFrame" column of Grasp X;
		Depth Frame = "depthStart" column of Grasp X;
		Xsens Frame = Gopro Frame * 4;
		
	Note: 
	- make sure that your loaded video file consists that particular grasp (Grasp X)
	- due to the large files the performance might be slow. 	
=====================================================================

(c) Zhanibek Rysbek
    PhD Student
    Department of Electrical and Computer Engineering 
    University of Illinois at Chicago
    email: zrysbe2@uic.edu
    
For more questions please feel free to contact.


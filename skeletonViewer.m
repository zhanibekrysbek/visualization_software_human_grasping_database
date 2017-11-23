function [] = skeletonViewer(skeleton)
%   SKELETONVIEWER - plots skeleton of a human subject from the inertial
%   motion data captured by XSENS MVN suit. 
% 
%   For more information about format of the file please refer to
%   manuscript for NU Human Grasping Database.
%

% create a joints map. i.e. which joints are connected as a link, in
% particular joints on the arm, neck, spine shoulder etc.
SkeletonConnectionMap = [[1 2];
    [2 3];
    [3 4];
    [4 5];
    [5 6];
    [6 7];
    [8 9];
    [9 10];
    [10 11];
    [12 13];
    [13 14];
    [14 15];
    [6 8];
    [6 12]];

% Loop to run over all links. At each step connect two links with solid
% visable line
pbaspect([1 1 1]);
xlabel('X');
ylabel('Y');
zlabel('Z');
for ind = 1:size(SkeletonConnectionMap, 1)
    f = skeleton(SkeletonConnectionMap(ind, :), :);
    plot3(f(:, 1), f(:, 2), f(:, 3), 'LineWidth', 3);
    hold on;
end
% consider interested joints
joints = [7;9;10;11;13;14;15];
% add spheres on head and wrist, elbow and shoulder joints
scatter3(skeleton(joints,1), skeleton(joints, 2), ...
    skeleton(joints, 3), 130, 'filled','LineWidth',5,...
    'MarkerFaceColor',[0.945, 0.831, 0.333]);
% fix view angle
view(10, 10);
grid on;
hold off;
end


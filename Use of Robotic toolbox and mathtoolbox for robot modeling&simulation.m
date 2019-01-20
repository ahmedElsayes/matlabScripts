%% Name:- Ahmed Elsayes         Student No:- 272537   
%% R1 Transformation between links + Robot links and assemply + sumbolic
% defining link parameters
L1=20; L2=60; L3=5; L4=57;
% Defining link objects with the DH parameters. 
% L = Link([Th d a alpha],'modified')
L(1) = Link('revolute', 'd', L1, 'a', 0, 'alpha', 0);
L(2) = Link('revolute', 'd', 0, 'a', L2, 'alpha', 0);
L(3) = Link('revolute', 'd', L3, 'a', 0, 'alpha', 0);
L(4) = Link('revolute', 'd', 0, 'a', L4, 'alpha', 0);
L(5) = Link('prismatic', 'theta', 0,'qlim', [-58 0], 'a', 1.5, 'alpha', pi); % qlim to set the limits of translation for the prismatic joint 
% Assemply of the robot
Robot = SerialLink(L,'name','Robot');
syms th1 th2 th3 th4 d1;
k1 = Robot.fkine([th1 th2 th3 th4 d1])

w = waitforbuttonpress;
if w == 0
    disp('Transformations between links')
else
    disp('Key press')
end
%% R2 angles = 0
zero_position = Robot.fkine([0 0 0 0 0])
w = waitforbuttonpress;
if w == 0
    disp('HT with joints values =0')
else
    disp('Key press')
end
%% R3 % R4 modeling robot in workstation
qz = [0 0 0 0 0];
qr = [0,pi/4,0,pi/8,0];
qn = [0,pi/6,0,pi/3,0];
% Robot at zero angle position
Robot.plot(qz,'workspace',[-70, 180 -70 180 -10 100]);
w = waitforbuttonpress;
if w == 0
    disp('Robot plot in zero position')
else
    disp('Key press')
end
%% R5 and R6 tool and base transformation
RobotBase = transl(10,10,28);
Robottool = transl(1,0,0);
Robot.base =RobotBase;
Robot.tool =Robottool;
w = waitforbuttonpress;
if w == 0
    disp('Tool and Base transformation')
else
    disp('Key press')
end
%% R7 and R8 at zero offset position and two other different position
for i = 0:1:2
    Robot.teach(qz,'workspace',[-7, 180 -7 180 -3 100]);
    pause(3)
    Robot.teach(qr,'workspace',[-7, 180 -7 180 -3 100]);
    pause(3)
    Robot.teach(qn,'workspace',[-7, 180 -7 180 -3 100]);
    pause(3)
end
w = waitforbuttonpress;
if w == 0
    disp('Robot in zero position and other two offset positions')
else
    disp('Key press')
end
%% R9 inverse kinematics to get the robot to objects coordination
T1 = transl(60, 60, 0);
T2 = transl(30, 80, 10);
q1 = Robot.ikine(T1,'mask',[1 1 0 1 1 0])
q2 = Robot.ikine(T2,'mask',[1 1 0 1 1 0])
plotcube([18 18 8],[ 2 2 0],.7,[1 1 0]);
plotcube([5 10 5],[ 60 60 0],.9,[0 1 0]);
plotcube([5 10 2.5],[ 30 80 10],.9,[1 0 0]);
w = waitforbuttonpress;
if w == 0
    disp('Robot in zero position and other two offset positions')
else
    disp('Key press')
end
%% R10 verification of points by forward kinematics
fk1 = Robot.fkine(q1)
fk2 = Robot.fkine(q2)
w = waitforbuttonpress;
if w == 0
    disp('Forward kinematics using fkine')
else
    disp('Key press')
end
%% R11 Symbolic math toolbox for getting the transformation matrix and FK
% checking
syms th1 th2 th3 th4 d1 th5 th6 th7 th8 d2;
th1=q1(1); th2=q1(2); th3=q1(3); th4=q1(4); d1=q1(5);
th5=q2(1); th6=q2(2); th7=q2(3); th8=q2(4); d2=q2(5);
fk_symbolic1 = Robot.fkine([th1 th2 th3 th4 d1])
fk_symbolic2 = Robot.fkine([th5 th6 th7 th8 d2])
w = waitforbuttonpress;
if w == 0
    disp('Forward kinematics using symbolic toolbox')
else
    disp('Key press')
end
%% R12 the simulation for the process
% Defining angles degrees and prismatic translation
% simulation for the full process
% loop of picking up the first object
plotcube([18 18 8],[ 2 2 0],.7,[1 1 0]);
plotcube([5 10 5],[ 60 60 0],.9,[0 1 0]);
plotcube([5 10 2.5],[ 30 80 10],.9,[1 0 0]);
  % start points at 
  % th1=0;  th2=0;  th3=0;  th4=0; d1=0;
  % end points at
  % th5=q1(1);  th6=q1(2);  th7=q1(3);  th8=q1(4); d2=q1(5);
% the loop where robot moves to the location of the green object
for th1 = 0:0.1:q1(1)+2*pi
    Robot.plot([th1 0 0 0 0],'workspace',[-180, 180 -180 180 -7 100]);
    pause(0.1)
end
pause(1)
for th2 = 0:-0.1:q1(2)
    Robot.plot([q1(1) th2 0 0 0],'workspace',[-180, 180 -180 180 -7 100]);
    pause(0.1)
end
pause(1)
for th3 = 0:-0.1:q1(3)
    Robot.plot([q1(1) q1(2) th3 0 0],'workspace',[-180, 180 -180 180 -7 100]);
    pause(0.1)
end
pause(1)
for th4 = 0:-0.1:q1(4)
    Robot.plot([q1(1) q1(2) q1(3) th4 0],'workspace',[-180, 180 -180 180 -7 100]);
    pause(0.1)
end
pause(1)
for d1 = 0:-0.1:q1(5)
    Robot.plot([q1(1) q1(2) q1(3) q1(4) d1],'workspace',[-180, 180 -180 180 -7 100]);
    pause(0.1)
end
pause(1)
% the other loop where robot moves to the location of the red object
for th5 = q1(1):0.05:q2(1)
    Robot.plot([th5 q1(2) q1(3) q1(4) q1(5)],'workspace',[-180, 180 -180 180 -7 100]);
    pause(0.05)
end
pause(1)
for th6 = q1(2):0.05:q2(2)
    Robot.plot([q2(1) th6 q1(3) q1(4) q1(5)],'workspace',[-180, 180 -180 180 -7 100]);
    pause(0.05)
end
pause(1)
for th7 = q1(3):0.05:q2(3)
    Robot.plot([q2(1) q2(2) th7 q1(4) q1(5)],'workspace',[-180, 180 -180 180 -7 100]);
    pause(0.05)
end
pause(1)
for th8 = q1(4):0.05:q2(4)
    Robot.plot([q2(1) q2(2) q2(3) th8 q1(5)],'workspace',[-180, 180 -180 180 -7 100]);
    pause(0.05)
end
pause(1)
for d2 = q1(5):0.05:q2(5)
    Robot.plot([q2(1) q2(2) q2(3) q2(4) d2],'workspace',[-180, 180 -180 180 -7 100]);
    pause(0.05)
end
w = waitforbuttonpress;
if w == 0
    disp('Full simulation for the process')
else
    disp('Key press')
end
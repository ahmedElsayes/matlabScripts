%% this script to plot all figures in all Questions
close all; clc;
 
%% figure defining and sensitivity calculations
sensetivity = 0.1;
displace_open_sine = Oy1(:,3)*0.1*1000;  % the third column in matrix express sensor output in volt
displace_close_sine = yc4(:,2)*0.1*1000; % the second column in matrix express sensor output in volt
displace_open_step = Oy3(:,3)*0.1*1000; 
displace_close_step = yc6(:,2)*0.1*1000;
out1_PI = yc1(:,2)*0.1*1000;
out2_PI = yc2(:,2)*0.1*1000;
out3_PI = yc3(:,2)*0.1*1000;
 
f1 = figure('Name', 'Comparing plots in Q2');
f2 = figure('Name', 'Comparing plots in Q3 all in one plot for (a) and (b)');
f3 = figure('Name', 'Comparing outputs of PI controller in Q4');
f4 = figure('Name', 'Comparing Hysteresis values in Q4');
f5 = figure('Name', 'Defining offset from step response');
f6 = figure('Name', 'Showing the drift in output response');
f7 = figure('Name', 'Step response');
% closed  loop
legs_closed={'Set Point','Output - Offset Decreased','Saturated Output From Controller',...
'Switch To Output','Offset','Laser - No Offset Correction'};
% open loop
legs_open={'Set Point','Saturated input','Output'};
 
%% Q2 figures in subplot
figure(f1);
subplot(2,2,1);
plot(Ot1,Oy1), legend(legs_open,'Location','Best','FontSize',8)
title('Open loop with 1 Hz freq')
xlim([1 3])
xlabel('Time \itt \rm(s)')
ylabel('Voltage \itU \rm(V)')
 
subplot(2,2,2);
plot(Ot2,Oy2), legend(legs_open,'Location','Best','FontSize',8)
title('Open loop with 50 Hz freq')
xlim([11.7 11.9])
xlabel('Time \itt \rm(s)')
ylabel('Voltage \itU \rm(V)')
 
subplot(2,2,3);
plot(tc4,yc4(:,1:3)), legend(legs_closed([1,2,3]),'Location','Best','FontSize',8)
title('Closed loop with 1 Hz freq')
xlim([1 3])
xlabel('Time \itt \rm(s)')
ylabel('Voltage \itU \rm(V)')
 
subplot(2,2,4); 
plot(tc5,yc5(:,1:3)), legend(legs_closed([1,2,3]),'Location','Best','FontSize',8)
title('Closed loop with 50 HZ freq')
xlim([0.6 0.8])
xlabel('Time \itt \rm(s)')
ylabel('Voltage \itU \rm(V)')
 
print(f1, 'Q2 figures-skip transient period', '-dpng', '-r1200')
 
%% Q3 figures in one figure
 
figure(f2);
subplot(2,1,1);
plot(Ot1, displace_open_sine, tc4, displace_close_sine)
legend('OL at 1 Hz sine wave input','CL at 1 Hz sine wave input')
title('OL and CL with 1 Hz freq')
xlabel('Time \itt \rm(s)')
ylabel('Displacement \rm(um)')
xlim([1 5])
 
subplot(2,1,2);
plot(Ot3, displace_open_step, tc6, displace_close_step)
legend('OL at step input','CL at step input')
title('Open- and closed-loop with unity step input')
xlabel('Time \itt \rm(s)')
ylabel('Displacement \rm(um)')
xlim([1 5])
print(f2, 'Q3 figures in one figure', '-dpng', '-r1200')
 
%% Q4 figures all in one plot
figure(f3);
plot(tc1, out1_PI, tc2, out2_PI, tc3, out3_PI)
legend('p=2 & I=0', 'p=2 & I=1000', 'p=2 & I=100')
title('Step response with different values for PI controller')
xlabel('Time \itt \rm(s)')
ylabel('Displacement \rm(um)')
xlim([1 3])
print(f3, 'Q4 figures all in one plot', '-dpng', '-r1200')
 
%% Q5 for defining Hysteresis
 
Max1 = max(yc4(350:500,2));
Min1 = min(yc4(350:500,2));
 
hyst_diff = abs(yc4(350:500,2) - yc4(350:500,1));
Hysteresis_perc = (max(hyst_diff)*100) / (Max1-Min1);
 
Max2 = max(Oy1(350:500,3));
Min2 = min(Oy1(350:500,3));
 
hyst_diff2 = abs(Oy1(350:500,3) - Oy1(350:500,1));
Hysteresis_perc2 = (max(hyst_diff2)*100) / (Max2-Min2);
 
figure(f4);
subplot(3,1,1);
plot(Oy1(350:end,1),Oy1(350:end,3))
title('Open-loop with 1 Hz freq')
xlabel('Input')
ylabel('Output')
 
subplot(3,1,2); 
plot(yc4(350:end,1),yc4(350:end,2))
title('Closed-loop with 1 HZ freq')
xlabel('Input')
ylabel('Output')
 
subplot(3,1,3);
plot(yc4(350:500,1),hyst_diff)
title('Hysteresis variation')
xlabel('Input')
ylabel('Difference between input/output')
print(f4, 'Q5 for defining Hysteresis', '-dpng', '-r1200')
%% Q6 for defining offset value from step response
figure(f5);
subplot(2,2,1);
plot(tc6,yc6(:,2))
title('CL Step response')
xlabel('Time \itt \rm(s)')
ylabel('Voltage \itU \rm(V)')
xlim([0.5 3])
% from the figure it can be seen that the system response starts at the
% timepoint 1 second, thus, take values from 0.5 to 1
iii = find((0.5<=tc6) & (tc6<=1));
offset = mean(yc6(iii,2));
 
subplot(2,2,2);
plot(tc6(iii),yc6(iii,2))
title('CL Offset')
xlabel('Time \itt \rm(s)')
ylabel('Voltage \itU \rm(V)')
 
subplot(2,2,3);
plot(Ot3,Oy3(:,3))
title('OL Step response')
xlabel('Time \itt \rm(s)')
ylabel('Voltage \itU \rm(V)')
xlim([0.5 3])
 
ii = find((0.5<=Ot3) & (Ot3<=1));
offset2 = mean(Oy3(ii,3));
 
subplot(2,2,4);
plot(Ot3(ii),Oy3(ii,3))
title('OL Offset')
xlabel('Time \itt \rm(s)')
ylabel('Voltage \itU \rm(V)')
 
print(f5, 'Q6 for defining offset value from step response', '-dpng', '-r1200')
%% Q7 to get the RMS value fro noise 
noise = yc6(iii,2)-mean(yc6(iii,2));
noise_rms = rms(noise);
 
noise2 = Oy3(ii,3)-mean(Oy3(ii,3));
noise_rms2 = rms(noise2);
 
%% Q8 to get the drift in percentage when the system is stabilized
iii2 = find((20<=tc6));
figure(f6);
subplot(2,1,1);
plot(Ot3(iii2),Oy3(iii2:end,3))
legend('OL at 1 Hz sine wave input','CL at 1 Hz sine wave input')
title('Open-loop with stabile output')
xlabel('Time \itt \rm(s)')
ylabel('Voltage \itU \rm(V)')
 
 
subplot(2,1,2);
plot(tc6(iii2),(yc6(iii2:end,2)))
legend('OL at step input','CL at step input')
title('Closed-loop with stabile output')
xlabel('Time \itt \rm(s)')
ylabel('Voltage \itU \rm(V)')
 
iii3 = find(tc6 == 120);
iii4 = find(tc6 == 20);
iii5 = find(Ot3 == 120);
iii6 = find(Ot3 == 20);
drift_closed = (yc6(iii3,2)-yc6(iii4,2))*100 / (120 - 20);
drift_open = (Oy3(iii5,3)-Oy3(iii6,3))*100 / (120 - 20);
print(f6, 'Q8 to get the drift in percentage', '-dpng', '-r1200')
%% Q9 Step response with calculating overshoot, rise-time and settling-time
figure(f7);
subplot(2,1,1);
plot(Ot4,Oy4(:,3))
title('Step response at sampling freq of 10 kHz');
xlabel('Time \itt \rm(s)');
ylabel('Voltage \itU \rm(V)');
 
subplot(2,1,2);
plot(Ot4,Oy4(:,3))
title('Zooming to see overshoot, rise time and settling time');
xlabel('Time \itt \rm(s)');
ylabel('Voltage \itU \rm(V)');
xlim([1 1.2])
 
iii7 = find((1.2<=Ot4) & (Ot4<=2));
steady_state_O = mean(Oy4(iii7,3));
 
System_info = stepinfo(Oy4(:,3),Ot4,steady_state_O);
print(f7, 'Q9 Step response with calculating overshoot', '-dpng', '-r1200')

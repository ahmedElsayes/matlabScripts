%% this script to plot parameters from lab 3
close all; clc;
 
%% figures and defining resistance
f1 = figure('Name', 'step signal fan on & off');
f2 = figure('Name', 'sin signal fan on & off');
f3 = figure('Name', 'comparing supplied voltage displacement at fan off');
f4 = figure('Name', 'comparing supplied voltage displacement at fan on');
f5 = figure('Name', 'manual variation at 5v.fan-off and 5v.fan-off');
f6 = figure('Name', 'Hysteresis for sinusoidal input with fan on & off');
f7 = figure('Name', 'displacement versus current all cases');
f8 = figure('Name', 'displacement in response to sin input with different time cycles');
f9 = figure('Name', 'all cycles in one figure');
f10 = figure('Name', 'displacement-force');
 
% with wave form inputs
step_fanoff = readtable('step signal100sec response-fanoff');
step_fanon = readtable('step signal100sec response-fanon');
sin_fanoff = readtable('sin signal response-fanoff');
sin_fanon = readtable('sin signal response-fanon');
 
% sinwave different cycles
sin4sec_cycle_fanoff = readtable('sin4sec_cycle_fanoff');
sin4sec_cycle_fanon = readtable('sin4sec_cycle_fanon');
sin8sec_cycle_fanoff = readtable('sin8sec_cycle_fanoff');
sin8sec_cycle_fanon = readtable('sin8sec_cycle_fanon');
sin15sec_cycle_fanoff = readtable('sin15sec_cycle_fanoff');
sin15sec_cycle_fanon = readtable('sin15sec_cycle_fanon');
 
% manual controlled values
vfrom_ontoff5 = readtable('5 fan from on to off');
fanoff_5v = readtable('5v fan off');
fanon_5v = readtable('5v fan on');
vfrom_ontoff25 = readtable('25 fan from on to off');
fanoff_25v = readtable('25v and fan off');
fanon_25v = readtable('25v fan on');
 
Resistance_V_measurement = 0.8;
K_spring = 1.6;
I_sin15_fanoff = sin15sec_cycle_fanoff.Var2 / Resistance_V_measurement;
I_sin15_fanon = sin15sec_cycle_fanon.Var2 / Resistance_V_measurement;
I_sin8_fanoff = sin8sec_cycle_fanoff.Var2 / Resistance_V_measurement;
I_sin8_fanon = sin8sec_cycle_fanon.Var2 / Resistance_V_measurement;
I_sin4_fanoff = sin4sec_cycle_fanoff.Var2 / Resistance_V_measurement;
I_sin4_fanon = sin4sec_cycle_fanon.Var2 / Resistance_V_measurement;
 
 
t_sin = (0:.0112:90)';
t_step = (0:.01:300)';
%% reading step tables and plot versus time
 
figure(f1);
plot(t_step(1:30000),step_fanoff.Var1(1:30000))
% legend('without cooling')
hold on
plot(t_step(1:30000),step_fanon.Var1(1:30000))
% legend('with active cooling')
xlabel('Time \rm(s)')
ylabel('displacement \rm(mm)')
xlim([200 300])
legend('without cooling','with active cooling','Location','Best')
% print(f1, 'step signal fan on & off', '-dpng', '-r1200')
 
%% variation in resistance due to step inputs
 
R1 = ((step_fanoff.Var3*0.6)-(0.6*step_fanoff.Var2))./step_fanoff.Var2;
R2 = ((step_fanon.Var3*0.6)-(0.6*step_fanon.Var2))./step_fanon.Var2;
 
plot(t_step(1:20:30000),R1(1:20:30000))
% legend('without cooling')
hold on
plot(t_step(1:20:30000),R2(1:20:30000))
% legend('with active cooling')
xlabel('Time \rm(s)')
ylabel('actuator resistance \rm(Ohms)')
% xlim([100 200])
legend('without cooling','with active cooling','Location','Best')

%% reading sin tables and plot versus time
 
figure(f2);
plot(t_sin(1:2250),sin_fanoff.Var1)
% legend('without cooling')
hold on
plot(t_sin(1:5000),sin_fanon.Var1(1:5000))
% legend('with active cooling')
xlabel('Time \rm(s)')
ylabel('displacement \rm(mm)')
legend('without cooling','with active cooling')
% print(f2, 'sin signal fan on & off', '-dpng', '-r1200')
 
%% reading sin tables and plot versus time the supplied votage and displacement
%when fan off
figure(f3);
plot(t_sin(1:2250),sin_fanoff.Var1)
xlabel('Time \rm(s)')
ylabel('displacement \rm(mm)')
% legend('without cooling')
hold on
yyaxis right 
plot(t_sin(1:2250),sin_fanoff.Var3)
xlabel('Time \rm(s)')
ylabel('voltage \rm(v)')
% legend('with active cooling')
legend('displacement','voltage')
% print(f3, 'comparing supplied voltage displacement at fan off', '-dpng', '-r1200')
 
 
%% reading sin different cycles
% ***********************************
 
% plot versus supplied volt 4 sec
figure(f8);
subplot(3,1,1);
plot(t_sin(1:4140),sin4sec_cycle_fanoff.Var1(1:4140),'r')
hold on
plot(t_sin(1:4140),sin4sec_cycle_fanon.Var1(1:4140),'b')
xlabel('Time \rm(s)')
ylabel('displacement \rm(mm)')
% legend('without cooling')
hold on
yyaxis right 
plot(t_sin(1:4140),sin4sec_cycle_fanon.Var3(1:4140),'k')
xlabel('Time \rm(s)')
ylabel('voltage \rm(v)')
% legend('with active cooling')
legend('\fontsize{7} displacement with fan off','\fontsize{7} displacement with fan on','\fontsize{7} voltage','Location','Best')
 
% ************************
subplot(3,1,2);
plot(t_sin(1:4140),sin8sec_cycle_fanoff.Var1(1:4140),'r')
hold on
plot(t_sin(1:4140),sin8sec_cycle_fanon.Var1(1:4140),'b')
xlabel('Time \rm(s)')
ylabel('displacement \rm(mm)')
ylim([0 4])
% legend('without cooling')
hold on
yyaxis right 
plot(t_sin(1:4140),sin8sec_cycle_fanoff.Var3(1:4140),'k')
xlabel('Time \rm(s)')
ylabel('voltage \rm(v)')
% legend('with active cooling')
legend('\fontsize{7} displacement with fan off','\fontsize{7} displacement with fan on','\fontsize{7} voltage','Location','Best')
 
% ************************
subplot(3,1,3);
plot(t_sin(1:4140),sin15sec_cycle_fanoff.Var1(1:4140),'r')
hold on
plot(t_sin(1:4140),sin15sec_cycle_fanon.Var1(1:4140),'b')
xlabel('Time \rm(s)')
ylabel('displacement \rm(mm)')
% legend('without cooling')
hold on
yyaxis right 
plot(t_sin(1:4140),sin15sec_cycle_fanon.Var3(1:4140),'k')
xlabel('Time \rm(s)')
ylabel('voltage \rm(v)')
% legend('with active cooling')
legend('\fontsize{7} displacement with fan off','\fontsize{7} displacement with fan on','\fontsize{7} voltage','Location','Best')
 
% print(f8, 'sin signal fan on & off compared to voltage', '-dpng', '-r1200')
 
%% reading sin different cycles
% ************************
figure(f9);
subplot(2,1,1);
plot(t_sin(1:4140),sin4sec_cycle_fanoff.Var1(1:4140),'r')
hold on
plot(t_sin(1:4140),sin8sec_cycle_fanoff.Var1(1:4140),'b')
hold on
plot(t_sin(1:4140),sin15sec_cycle_fanoff.Var1(1:4140),'k')
xlabel('Time \rm(s)')
ylabel('displacement \rm(mm)')
legend('\fontsize{7} 4sec cycle fan off','\fontsize{7} 8sec cycle fan off','\fontsize{7} 15sec cycle fan off','Location','Best')
 
subplot(2,1,2);
plot(t_sin(1:4140),sin4sec_cycle_fanon.Var1(1:4140),'r')
hold on
plot(t_sin(1:4140),sin8sec_cycle_fanon.Var1(1:4140),'b')
hold on
plot(t_sin(1:4140),sin15sec_cycle_fanon.Var1(1:4140),'k')
 
 
xlabel('Time \rm(s)')
ylabel('displacement \rm(mm)')
legend('\fontsize{7} 4sec cycle fan on','\fontsize{7} 8sec cycle fan on','\fontsize{7} 15sec cycle fan on','Location','Best')
 
% print(f9, 'sin signal fan on & off different cycles', '-dpng', '-r1200')
 
%% reading tables recorded from manual variation and plot versus time
figure(f5);
t_15sec = (0:.006:15)';
t_15sec_25v = (0:.003:15)';
 
subplot(2,1,1);
plot(t_15sec,vfrom_ontoff5.Var1(1:2501))
hold on
plot(t_15sec,fanoff_5v.Var1(1:2501))
hold on
plot(t_15sec,fanon_5v.Var1(1:2501))
xlabel('Time \rm(s)')
ylabel('displacement \rm(mm)')
legend('fan on to off variation','fan off 5v','fan on 5v','Location','Best')
 
subplot(2,1,2);
plot(t_15sec_25v(1:4756),vfrom_ontoff25.Var1(1:4756))
hold on
plot(t_15sec_25v(1:2290),fanoff_25v.Var1(1:2290))
hold on
plot(t_15sec_25v(1:2290),fanon_25v.Var1(1:2290))
xlabel('Time \rm(s)')
ylabel('displacement \rm(mm)')
legend('fan on to off variation','fan off 2.5v','fan on 2.5v','Location','Best')
 
% print(f5, 'manual variation at 5vfan-off and 5vfan-off', '-dpng', '-r1200')
 
%% Hysteresis 
figure(f6);
subplot(2,1,1);
plot(sin_fanon.Var3(1000:5000),sin_fanon.Var1(1000:5000))
title('Hysteresis for sinusoidal input with active cooling')
xlabel('Input')
ylabel('Output')
 
subplot(2,1,2); 
plot(sin_fanoff.Var3(1500:end),sin_fanoff.Var1(1500:end))
title('Hysteresis for sinusoidal input without cooling')
xlabel('Input')
ylabel('Output')
% print(f5, 'manual variation at 5v.fan-off and 5v.fan-off')
% for calculating hysteresis
% fan on
Max1 = max(sin_fanon.Var1(1000:5000));
Min1 = min(sin_fanon.Var1(1000:5000));
 
iii9 = find(sin_fanon.Var3(1000:5000) == 2);
hhh3 = diff(sin_fanon.Var1(iii9));
 
Hysteresis_perc = (max(hhh3)*100) / (Max1-Min1);
% print(f6, 'Hysteresis for sinusoidal input with fan on & off', '-dpng', '-r1200')
 
%% Displacement as function of supply current with longest cycle time
figure(f7);
subplot(3,1,1); 
plot(I_sin15_fanoff(100:20:end),sin15sec_cycle_fanoff.Var1(100:20:end));
hold on;
plot(I_sin15_fanon(100:20:end),sin15sec_cycle_fanon.Var1(100:20:end));
xlabel('current \rm(A)')
ylabel('displacement \rm(mm)')
legend('sin without cooling','sin with cooling','Location','Best')
title('cycle of 15 sec')
% ***8sec
subplot(3,1,2); 
plot(I_sin8_fanoff(100:20:end),sin8sec_cycle_fanoff.Var1(100:20:end));
hold on;
plot(I_sin8_fanon(100:20:end),sin8sec_cycle_fanon.Var1(100:20:end));
xlabel('current \rm(A)')
ylabel('displacement \rm(mm)')
legend('sin without cooling','sin with cooling','Location','Best')
title('cycle of 8 sec')
% **** 4 sec
subplot(3,1,3); 
plot(I_sin4_fanoff(100:20:end),sin4sec_cycle_fanoff.Var1(100:20:end));
hold on;
plot(I_sin4_fanon(100:20:end),sin4sec_cycle_fanon.Var1(100:20:end));
xlabel('current \rm(A)')
ylabel('displacement \rm(mm)')
legend('sin without cooling','sin with cooling','Location','Best')
title('cycle of 4 sec')
 
%% force as function in displacement
figure(f10);
force = K_spring * sin_fanon.Var1;
% subplot(2,1,1); 
plot(sin_fanon.Var1(1:20:end),force(1:20:end));
xlabel('displacement \rm(mm)')
ylabel('force \rm(N)')
xlim([0 3])
% title('cycle of 15 sec')
% ***8sec
% subplot(2,1,2); 
% plot(force(1:20:end),sin_fanon.Var1(1:20:end));
% ylabel('displacement \rm(mm)')
% xlabel('force \rm(N)')
% title('cycle of 8 sec')
% **** 4 sec
%% drift calculation
i1 = find(t_step == 300);
i2 = find(t_step == 220);
drift_fan_off = (step_fanoff.Var1(i1)-step_fanoff.Var1(i2))*100 / (300 - 220);
drift_fan_on = (step_fanon.Var1(i1)-step_fanon.Var1(i2))*100 / (300 - 220);

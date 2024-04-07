%% Load data
load('data/I1_mod_high.mat');
load('data/I1_mod_low.mat');
load('data/I1_mod_med.mat');
load('data/I1_strong_high.mat');
load('data/I1_strong_low.mat');
load('data/I1_strong_med.mat');
load('data/I2_mod_high.mat');
load('data/I2_mod_low.mat');
load('data/I2_mod_med.mat');
load('data/I2_strong_high.mat');
load('data/I2_strong_low.mat');
load('data/I2_strong_med.mat');
load('data/V_mod_high.mat');
load('data/V_mod_low.mat');
load('data/V_mod_med.mat');
load('data/V_strong_high.mat');
load('data/V_strong_low.mat');
load('data/V_strong_med.mat');
load('data/Vdm_mod.mat');
load('data/Vdm_strong.mat');
%% P1: Current vs V_dm
% plot showing I1, I2, I1 - I2, and I1 + I2, as a function of V1-V2 for all three values of V2
% that you used. Yes, we are really asking you to plot 12 curves on the same plot—the point is
% to be able to visually compare the characteristics to see just how much they shift with V2

plot_1 = figure; % Create a new figure
hold on; % Hold on to plot multiple curves

% I_1 Plots
scatter(Vdm_mod, I1_mod_high, '.', 'MarkerEdgeColor', [1, 0, 0], 'DisplayName', 'I_1 High');
scatter(Vdm_mod, I1_mod_med, '.', 'MarkerEdgeColor', [0, 1, 0], 'DisplayName', 'I_1 Med');
scatter(Vdm_mod, I1_mod_low, '.', 'MarkerEdgeColor', [0, 0, 1], 'DisplayName', 'I_1 Low');

% I_2 Plots
scatter(Vdm_mod, I2_mod_high, '.', 'MarkerEdgeColor', [1, 0, 0], 'DisplayName', 'I_2 High');
scatter(Vdm_mod, I2_mod_med, '.', 'MarkerEdgeColor', [0, 1, 0], 'DisplayName', 'I_2 Med');
scatter(Vdm_mod, I2_mod_low, '.', 'MarkerEdgeColor', [0, 0, 1], 'DisplayName', 'I_2 Low');
 
% I_1 - I_2 Plots
scatter(Vdm_mod, I1_mod_high - I2_mod_high, '.', 'MarkerEdgeColor', [1, 0, 0], 'DisplayName', 'I_1-I_2 High');
scatter(Vdm_mod, I1_mod_med - I2_mod_med, '.', 'MarkerEdgeColor', [0, 1, 0], 'DisplayName', 'I_1-I_2 Med');
scatter(Vdm_mod, I1_mod_low - I2_mod_low, '.', 'MarkerEdgeColor', [0, 0, 1], 'DisplayName', 'I_1-I_2 Low');

% I_1 + I_2 Plots
scatter(Vdm_mod, I1_mod_high + I2_mod_high, '.', 'MarkerEdgeColor', [1, 0, 0], 'DisplayName', 'I_1+I_2 High');
scatter(Vdm_mod, I1_mod_med + I2_mod_med, '.', 'MarkerEdgeColor', [0, 1, 0], 'DisplayName', 'I_1+I_2 Med');
scatter(Vdm_mod, I1_mod_low + I2_mod_low, '.', 'MarkerEdgeColor', [0, 0, 1], 'DisplayName', 'I_1+I_2 Low');

% Annotations
text(-0.25, 0.2e-6, 'I_1', 'FontSize', 12);
text(0.01, 0.95e-6, 'I_1+I_2', 'FontSize', 12);
text(0.25, 0.2e-6, 'I_2', 'FontSize', 12); 
text(-0.25, -0.9e-6, 'I_1-I_2', 'FontSize', 12);  

x=linspace(-0.3,0.3);
y=linspace(0,0);
plot(x,y,'color', [.5 .5 .5]);
plot(y,x,'color', [.5 .5 .5]);
ylim([-1.15e-6 1.15e-6])
xlim([-0.3 0.3])

hold off;
xlabel('V_{dm} (V)'); % Differential voltage V1-V2
ylabel('Current (A)');
title('Current vs V_{dm} with MI bias');
lgd = legend('4.5', '3.5', '2.5');
title(lgd,'V_2 (V)');
legend('show');
%% P2: V vs V_dm
plot_2 = figure;
hold on;

scatter(Vdm_mod, V_mod_high, '.', 'MarkerEdgeColor', [1, 0, 0]);
scatter(Vdm_mod, V_mod_med, '.', 'MarkerEdgeColor', [0, 1, 0]);
scatter(Vdm_mod, V_mod_low, '.', 'MarkerEdgeColor', [0, 0, 1]);

hold off;

xlabel('V_{dm} (V)'); % Differential voltage V1-V2
ylabel('V (V)');
title('Common-source node voltage vs V_{dm} with MI bias');
lgd = legend('4.5', '3.5', '2.5');
title(lgd,'V_2 (V)');
legend('show');
%% P3: I1 − I2 as a function of V1 − V2
% Fit a straight line to the plot around the region where V1 ~= V2 (i.e., where V1=V2=0 V).
plot_3 = figure; % Create a new figure
hold on; % Hold on to plot multiple curves
% I_1 - I_2 Plots
scatter(Vdm_mod, I1_mod_high - I2_mod_high, '.', 'MarkerEdgeColor', [1, 0, 0], 'DisplayName', 'I_1-I_2 High');
scatter(Vdm_mod, I1_mod_med - I2_mod_med, '.', 'MarkerEdgeColor', [0, 1, 0], 'DisplayName', 'I_1-I_2 Med');
scatter(Vdm_mod, I1_mod_low - I2_mod_low, '.', 'MarkerEdgeColor', [0, 0, 1], 'DisplayName', 'I_1-I_2 Low');

x=linspace(-0.3,0.3);
y=linspace(0,0);
plot(x,y,'color', [.5 .5 .5]);
plot(y,x,'color', [.5 .5 .5]);
ylim([-1.15e-6 1.15e-6])
xlim([-0.3 0.3])

% Line of best fits

fit_idx = Vdm_mod >= -0.04 & Vdm_mod <= 0.04;

[first_h, last_h, mmax_h, bmax_h, Nmax_h] = linefit(Vdm_mod(fit_idx), I1_mod_high(fit_idx) - I2_mod_high(fit_idx), 6e-4);
[first_m, last_m, mmax_m, bmax_m, Nmax_m] = linefit(Vdm_mod(fit_idx), I1_mod_med(fit_idx) - I2_mod_med(fit_idx), 7e-4);
[first_l, last_l, mmax_l, bmax_l, Nmax_l] = linefit(Vdm_mod(fit_idx), I1_mod_low(fit_idx) - I2_mod_low(fit_idx), 5e-4);

fit_x = -0.15:0.01:0.15;
plot(fit_x, mmax_h*fit_x + bmax_h, 'r--');
plot(fit_x, mmax_m*fit_x + bmax_m, 'g--');
plot(fit_x, mmax_l*fit_x + bmax_l, 'b--');
hold off;
xlabel('V_{dm} (V)'); % Differential voltage V1-V2
ylabel('I_1 - I_2 (A)');
title('Differential Current vs V_{dm}');
lgd = legend('4.5', '3.5', '2.5');
title(lgd,'V_2 (V)');
legend('show');
%% Strong Inversion: IV characteristics

plot_4 = figure; % Create a new figure
hold on; % Hold on to plot multiple curves

% I_1 Plot
scatter(Vdm_strong, I1_strong_high, '.', 'MarkerEdgeColor', [0, 0.4470, 0.7410], 'DisplayName', 'I_1');

% I_2 Plot
scatter(Vdm_strong, I2_strong_high, '.', 'MarkerEdgeColor', [0.8500, 0.3250, 0.0980], 'DisplayName', 'I_2');
 
% I_1 - I_2 Plot
scatter(Vdm_strong, I1_strong_high - I2_strong_high, '.', 'MarkerEdgeColor', [0.9290, 0.6940, 0.1250], 'DisplayName', 'I_1-I_2');

% I_1 + I_2 Plot
scatter(Vdm_strong, I1_strong_high + I2_strong_high, '.', 'MarkerEdgeColor', [0.4940, 0.1840, 0.5560], 'DisplayName', 'I_1+I_2');

x=linspace(-0.7,0.7);
y=linspace(0,0);
plot(x,y,'color', [.5 .5 .5]);
plot(y,x,'color', [.5 .5 .5]);
hold off;
ylim([-8.5e-5 8.5e-5])
xlim([-0.7 0.7])

xlabel('V_{dm} (V)'); % Differential voltage V1-V2
ylabel('Current (A)');
title('Current vs V_{dm} with SI bias');
lgd = legend('I_1', 'I_2', 'I_1-I_2', 'I_1+I_2');
title(lgd,'Current');
legend('show');
%% Strong Inversion: V vs V_dm
plot_5 = figure; % Create a new figure
hold on; % Hold on to plot multiple curves

scatter(Vdm_strong, V_strong_high, '.', 'MarkerEdgeColor', [0, 0.4470, 0.7410]);

hold off;

xlabel('V_{dm} (V)'); % Differential voltage V1-V2
ylabel('V (V)');
title('Common-source node voltage vs V_{dm} with SI bias');
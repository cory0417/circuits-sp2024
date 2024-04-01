epsilon = 5e-4;
n_transistor=4;
Is_vec = zeros(n_transistor, 1);
VT_vec = zeros(n_transistor, 1);
kappa_vec = zeros(n_transistor, 1);
Vg_combined = zeros(100 * n_transistor, 2);

for i = 1:1:n_transistor
    path = ['data/exp1/data_', num2str(i), '.mat'];
    dataStruct = load(path);
    
    % Assume 'I_in' is constant, and find the variable for Vg dynamically
    Isat = dataStruct.I_in; % Assuming 'I_in' is known and constant
    
    % Dynamically find the V_in variable
    fieldNames = fieldnames(dataStruct);
    VgFieldName = fieldNames{~strcmp(fieldNames, 'I_in')}; % Assume the other field is Vg
    Vg = dataStruct.(VgFieldName); % Use dynamic fieldnames to access the variable
    Vg_combined(1 + (i-1)*100:i*100, 1) = Vg;
    Vg_combined(1 + (i-1)*100:i*100, 2) = i;

    [Is, VT, kappa]=ekvfit(Vg, Isat, epsilon);
    Is_vec(i) = Is;
    VT_vec(i) = VT;
    kappa_vec(i) = kappa;
end

ekv_params = table(Is_vec, VT_vec, kappa_vec);
%% 


clear figure;

exp1_p1 = figure;
marker_styles = ['o', '+', 'x', 'square'];
for i = 1:n_transistor
    idx = Vg_combined(:, 2) == i;
    Vg = Vg_combined(idx, 1);
    semilogx(Isat, Vg, 'LineStyle', 'none', 'Marker', marker_styles(i), 'DisplayName', sprintf('Transistor %d', i));
    hold on;
end

U_T =0.0258;
x = Isat;
y = 2*U_T/kappa * log(exp(sqrt(Isat/Is))-1) + VT;
semilogx(x, y, '--', 'DisplayName', 'Transistor 4 EKV Fit');

hold off;
ylim([0.37 2.6]);
ylabel('V_g (V)');
xlabel('I_{in} (A)'); 
title('VI Characteristics of Transistor Array');
legend('Location', 'southeast');
legend show; 

dim = [0.4 0.3 0.3 0.3]; % Adjust these values as needed [x y width height]
str = '$$V_g = \frac{2U_{T}}{\kappa} \log(\exp(\sqrt{\frac{I_{in}}{I_{s}}}) - 1)) + V_{T0}$$';
annotation('textbox', dim, 'String', str, 'FitBoxToText', 'on', 'Interpreter', 'latex', 'EdgeColor', 'none', 'FontSize', 13);

% save plot
print(exp1_p1, '-depsc', 'exp1_p1.eps');
%% 
exp1_p2 = figure;
Vg_avg = zeros(100, 1);
for i = 1:100
    Vg_avg(i) = mean(Vg_combined([i i+100 i+200 i+300], 1));
end

for i = 1:n_transistor
    idx = Vg_combined(:, 2) == i;
    Vg = Vg_combined(idx, 1);
    semilogx(Isat, abs(Vg-Vg_avg), 'LineStyle', 'none', 'Marker', marker_styles(i), 'DisplayName', sprintf('Transistor %d', i));
    hold on;
end
% ylim([0 0.4]);
hold off;
ylabel('|V_G-V_{avg}| (V)');
xlabel('I_{in} (A)'); 
title('|V_G-V_{avg}| vs I_{in}');
legend('Location', 'southeast');
legend show; 
% print(exp1_p2, '-depsc', 'exp1_p2.eps');
%% Plot 3: incremental transconductance gain (log-log g_m vs I_in) + theoretical fit
exp1_p3 = figure;
path = 'data/exp1/data_4.mat';
load(path);

V_g = V_in4;

g_m = diff(I_in) ./ diff(V_g);

loglog(I_in(1:99), g_m, 'LineStyle', 'none', 'Marker', '.', 'DisplayName', 'Incremental transductance gain');
hold on;
U_T =0.0258;
x = I_in;
y = kappa/U_T .* sqrt(I_in.*Is) .* (1 - exp(-sqrt(I_in./Is)));

loglog(x, y, '--', 'DisplayName', 'Theoretical Fit');

ylabel('g_m (S)');
xlabel('I_{in} (A)'); 
title('Incremental transconductance gain of the transistor');
legend('Location', 'southeast');
legend show; 

dim = [0.2 0.5 0.3 0.3]; % Adjust these values as needed [x y width height]
str = '$$g_m = \frac{\kappa}{U_{T}} \sqrt{I_{in} I_{s}} (1 - \exp(-\sqrt{\frac{I_{in}}{I_{s}}}))$$';
annotation('textbox', dim, 'String', str, 'FitBoxToText', 'on', 'Interpreter', 'latex', 'EdgeColor', 'none', 'FontSize', 13);
hold off;
print(exp1_p3, '-depsc', 'exp1_p3.eps');
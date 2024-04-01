exp2_p1 = figure;
path = 'data/exp2/data.mat';
load(path);

loglog(I_in, I_out, 'LineStyle', 'none', 'Marker', '.', 'DisplayName', 'Experiment data');
hold on;
plot(I_in, I_in, '--', 'DisplayName', 'Theoretical Fit')

ylabel('I_{out} (A)'); 
xlabel('I_{in} (A)'); 
title('Current Transfer Characteristic of Current Mirror');
legend('Location', 'southeast');
legend show; 
xlim([5e-9 1e-3]);
dim = [0.7 0.2 0.3 0.3]; % Adjust these values as needed [x y width height]
str = '$$I_{out} = I_{in}$$';
annotation('textbox', dim, 'String', str, 'FitBoxToText', 'on', 'Interpreter', 'latex', 'EdgeColor', 'none', 'FontSize', 13);
hold off;
print(exp2_p1, '-depsc', 'exp2_p1.eps');
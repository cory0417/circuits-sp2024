load("data_weak.mat");
load("data_mod.mat");
load("data_strong.mat");

ohmic_idx = Vd <= 0.1;
saturation_idx = Vd > 0.1;

[first, last, mmax, bmax, Nmax] = linefit(Vd(ohmic_idx), Id_weak(ohmic_idx), 8e-3);
r_on_weak = 1/mmax;
[first, last, mmax, bmax, Nmax] = linefit(Vd(saturation_idx), Id_weak(saturation_idx), 2e-2);
r_o_weak = 1/mmax;
V_A_weak = bmax/mmax;


[first, last, mmax, bmax, Nmax] = linefit(Vd(ohmic_idx), Id_mod(ohmic_idx), 8e-3);
r_on_mod = 1/mmax;
[first, last, mmax, bmax, Nmax] = linefit(Vd(saturation_idx), Id_mod(saturation_idx), 8e-3);
r_o_mod = 1/mmax;
V_A_mod = bmax/mmax;

[first, last, mmax, bmax, Nmax] = linefit(Vd(ohmic_idx), Id_strong(ohmic_idx), 8e-3);
r_on_strong = 1/mmax;
[first, last, mmax, bmax, Nmax] = linefit(Vd(saturation_idx), Id_strong(saturation_idx), 8e-3);
r_o_strong = 1/mmax;
V_A_strong = bmax/mmax;

r_on = [r_on_weak; r_on_mod; r_on_strong];
r_o = [r_o_weak; r_o_mod; r_o_strong];
I_in = [I_weak; I_mod; I_strong];
gain = r_o./r_on;
V_A = [V_A_weak; V_A_mod; V_A_strong];

extracted = table(I_in, r_on, r_o, V_A, gain);

exp3_p1 = figure;

semilogy(Vd, Id_weak, '.', 'DisplayName', 'I_{in} = 100nA, Weak inversion')
hold on;
semilogy(Vd, Id_mod, '.', 'DisplayName', 'I_{in} = 1\muA, Moderate inversion')
semilogy(Vd, Id_strong, '.', 'DisplayName', 'I_{in} = 100\muA, Strong inversion')

xlabel('V_d (V)')
ylabel('I_d (A)')

legend('Location', 'southeast');
legend show;

title('IV Characteristics for nMOS Current Mirror')

hold off

print(exp3_p1, '-depsc', 'exp3_p1.eps');


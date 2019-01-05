plot(pa,ca)
hold on
plot(x_linear,fx_linear)
xlabel('pressure Kpa')
ylabel('1/m')
title('pressure/curvature')
legend('expermintal results','linear regressed value')
hold off
print('Pressure-curve', '-dpng', '-r1200')

%%
plot(x_poly,fx_poly,'-*')
xlabel('pressure Kpa')
ylabel('1/m')
title('pressure/curvature')
legend('quadratic regressed values')
% print('Pressure-curve wuadratic relation', '-dpng', '-r1200')

%%
sensetivity = (fx_linear(5)-fx_linear(4))/(x_linear(5)-x_linear(4))
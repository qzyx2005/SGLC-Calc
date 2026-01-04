function L_cloud = calc_Cloud_Loss(p, GS)
% CALC_CLOUD_LOSS Calculates cloud attenuation.

H = GS.H / 1000;            
lambda_um = p.lambda * 1e6;

a = (0.000487 * (lambda_um^3)) - (0.002237 * (lambda_um^2)) + ...
    (0.003864 * lambda_um) - 0.004442;

b = (-0.00573 * (lambda_um^3)) + (0.02639 * (lambda_um^2)) - ...
    (0.04552 * lambda_um) + 0.05164;

c = (0.02565 * (lambda_um^3)) - (0.1191 * (lambda_um^2)) + ...
    (0.20385 * lambda_um) - 0.216;

d = (-0.0638 * (lambda_um^3)) + (0.3034 * (lambda_um^2)) - ...
    (0.5083 * lambda_um) + 0.425;

mieER = a*(H^3) + b*(H^2) + c*(H) + d;

L_cloud = (4.3429 * mieER) ./ sind(p.theta_el);

end
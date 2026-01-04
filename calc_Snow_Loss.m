function L_snow = calc_Snow_Loss(p, GS)
% CALC_SNOW_LOSS Calculates snow attenuation.

S = p.Weather_Parameters;   
lambda_nm = p.lambda * 1e9; 
H_GS_km = GS.H * 1e-3;      
if S <= 0, L_snow = 0; return; end

if isfield(p, 'isWetSnow') && p.isWetSnow == true
    % Wet Snow Model
    a = 1.023e-4 * lambda_nm + 3.7855466;
    b = 0.72;
else
    % Dry Snow Model
    a = 5.42e-5 * lambda_nm + 5.4958776;
    b = 1.38;
end

gamma_snow = a * (S ^ b);

h_SnowTop = 2.0; 

if H_GS_km >= h_SnowTop
    L_snow = 0;
    return;
end

l_snow = (h_SnowTop - H_GS_km) ./ sind(p.theta_el);

L_snow = gamma_snow * l_snow;
end
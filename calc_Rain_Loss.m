function L_rain = calc_Rain_Loss(p, GS)
% CALC_RAIN_LOSS Calculates rain attenuation.

rainRate_mmhr = p.Weather_Parameters;

if rainRate_mmhr <= 0
    L_rain = 0;
    return;
end

alpha_rain = 1.076 * (rainRate_mmhr ^ 0.67);

h_rain_top = 3000; 

if GS.H >= h_rain_top
    L_rain = 0;
    return;
end

L_path_km = (h_rain_top - GS.H) / 1000 ./ sind(p.theta_el);

L_rain = alpha_rain * L_path_km;
end
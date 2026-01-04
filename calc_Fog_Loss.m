function L_Fog = calc_Fog_Loss(p, GS)
% CALC_FOG_LOSS Calculates fog attenuation.

GS_H_km = GS.H * 1e-3;
h_Fogtrop = 1.0; 
lambda_nm = p.lambda * 1e9; 

if GS_H_km >= h_Fogtrop
    L_Fog = 0;
    return;
end


dT_km = (h_Fogtrop - GS_H_km) ./ sind(p.theta_el);

visibility = p.Weather_Parameters; 
if visibility <= 0, L_Fog = 0; return; end

if visibility <= 0.5
    delta = 0;
elseif visibility <= 1
    delta = visibility - 0.5;
elseif visibility <= 6
    delta = 0.16 * visibility + 0.34;
elseif visibility <= 50
    delta = 1.3;
else
    delta = 1.6;
end

geoCoeff = (3.91 / visibility) * ((lambda_nm / 550)^-delta);

L_Fog = geoCoeff * dT_km;
end
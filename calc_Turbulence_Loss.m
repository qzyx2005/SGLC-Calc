function L_turb = calc_Turbulence_Loss(p, GS)
% CALC_TURBULENCE_LOSS Calculates atmospheric scintillation loss.

lambda_m = p.lambda;             
lambda_um = p.lambda * 1e6;      

k = 2 * pi / lambda_m;

sin_el = sind(p.theta_el);
if sin_el < 0.1, sin_el = 0.1; end 

C0 = 1.7e-14;

Cn2_profile = @(h) ...
    8.148e-56 * (p.v_rms^2) * (h.^10) .* exp(-h/1000) + ...
    2.7e-16 * exp(-h/1500) + ...
    C0 * exp(-h/100);

Z = 20000; 

if GS.H >= Z
    L_turb = 0; return;
end

integrand = @(h) Cn2_profile(h) .* ((h - GS.H).^(5/6));

try
    val_int = integral(integrand, GS.H, Z);
catch
    val_int = 0;
end

numerator = 3.622e9 * val_int;
denominator = (lambda_um^(7/6)) * (sind(p.theta_el)^(11/6));
sigma_dBN_sq = numerator / denominator;

isUplink = false;
if isfield(p, 'LinkType') && strcmpi(p.LinkType, "Uplink (Ground-to-Sat)")
    isUplink = true;
end

if isUplink
    
    L_turb = sqrt(sigma_dBN_sq);

else
    
    D_rx = GS.D;

    term_inner = (D_rx^2 * sind(p.theta_el)) / (Z * lambda_um);
    A = 1 / (1 + 1.1e7 * (term_inner^(7/6)));

    sigma_down_sq = A * sigma_dBN_sq;

    L_turb = sqrt(sigma_down_sq);
end
end
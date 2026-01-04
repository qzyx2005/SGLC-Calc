function res = calc_SLC_LinkBudget(p, GS, Sat)
% CALC_SLC_LINKBUDGET Core engine for Satellite-Ground optical link budget.

L_Fog = 0;
L_rain = 0;
L_Cloud = 0;
L_snow = 0;
L_clearsky = 0;

if strcmpi(p.LinkType, "Downlink (Sat-to-Ground)")
    tx = Sat;
    rx = GS;
elseif strcmpi(p.LinkType, "Uplink (Ground-to-Sat)")
    tx = GS;
    rx = Sat;
else
    error('Unknown LinkType: %s', p.LinkType);
end


try
   
    d_slant = slantRangeCircularOrbit(p.theta_el, Sat.H, GS.H);
catch ME
    
    error('Failed to calculate Slant Range. Ensure Satellite Communications Toolbox is installed. Error: %s', ME.message);
end


gain_tx = (pi * tx.D / p.lambda)^2;
G_tx = 10 * log10(gain_tx);

gain_rx = (pi * rx.D / p.lambda)^2;
G_rx = 10 * log10(gain_rx);

L_fspl = 20 * log10(4 * pi * d_slant / p.lambda);
L_point_tx = 4.3429 * gain_tx * (tx.gamma)^2;
L_point_rx = 4.3429 * gain_rx * (rx.gamma)^2;
L_point_total = L_point_tx + L_point_rx;
L_opt_tx = -10 * log10(tx.eta);
L_opt_rx = -10 * log10(rx.eta);
L_abs = 0.01;


switch p.WeatherType
    case 'Fog'
        L_Fog = calc_Fog_Loss(p, GS);
    case 'Rain'
        L_rain = calc_Rain_Loss(p, GS);
    case 'Clouds'
        L_Cloud = calc_Cloud_Loss(p, GS);
    case 'Snow'
        L_snow = calc_Snow_Loss(p, GS);
    case 'Clear Sky'
        L_clearsky = p.Weather_Parameters;
    otherwise
end

L_atm = L_Fog + L_rain + L_Cloud + L_snow + L_clearsky;

if isfield(p, 'isTurbulenceEnabled') && p.isTurbulenceEnabled == true
    L_turb = calc_Turbulence_Loss(p, GS);
else
    L_turb = 0;
end

P_rx_dBm = p.P_tx + G_tx + G_rx ...
    + L_opt_tx + L_opt_rx ...
    - L_fspl - L_point_total - L_abs - L_atm - L_turb;

Link_Margin = P_rx_dBm - p.sensitivity;

res.SlantRange_km = d_slant / 1000;
res.FSPL_dB = L_fspl;
res.TotalPointingLoss_dB = L_point_total;
res.ReceivedPower_dBm = P_rx_dBm;
res.LinkMargin_dB = Link_Margin;
res.LossBreakdown.FSPL = L_fspl;
res.LossBreakdown.Fog = L_Fog;
res.LossBreakdown.Rain = L_rain;
res.LossBreakdown.Cloud = L_Cloud;
res.LossBreakdown.Snow = L_snow;
res.LossBreakdown.Turbulence = L_turb;
res.TxGain_dB = G_tx;
res.RxGain_dB = G_rx;
end
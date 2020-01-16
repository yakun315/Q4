x = load("x");
y= load("y");
data = firmSpecific.firmSpecific;
varcol = firmSpecific.varCol;

data(end, end+1, end) = NaN;  % â€œDTD_median_Finâ€?
data(end, end+1, end) = NaN;  % â€œDTD_median_nonFinâ€?

mask_fin = data(:, 1, :) == 73684000;
mask_fin_non = data(:, 1, :) != 73684000;

fin_mask = sum(mask_fin, 1) > 1;   % get the corresponding mask of FIN 35
non_fin_mask = (fin_mask != 1) == 0;

fin_values = data(:, 6, fin_mask);  % 365
non_fin_values = data(:, 6, non_fin_mask);

%% fin_non_nan_mask = isnan(fin_values) == 0;  % some values contains NaN
%% non_fin_non_nan_mask = isnan(non_fin_values) == 0;

fin_median = nanmedian(fin_values);  % ignore Nan
non_fin_median = nanmedian(non_fin_values);

data(:, end-2, mask_fin) = fin_median;
data(:, end-1, mask_fin_non) = non_fin_median;

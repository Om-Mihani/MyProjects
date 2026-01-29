function [X_smooth] = local_smoothing(t, X, k)
    %Smoothing function
    % note that k is the span here unlike the lecture
    
    n = length(t);
    X_smooth = zeros(n,1);
    weights_all = zeros(n, k);
    
    for i = 1:n

        ts = t(i);
        
        % Find k closest neighbors (including self)
        distances = abs(t - ts);
        [~, idx] = sort(distances);
        neighbors_idx = idx(1:k);  % indices of k nearest (this is automatically symmetric due to the nature of the time data)
        t_neigh = t(neighbors_idx);
        X_neigh = X(neighbors_idx);
        
        % Weights tricubic
        dist_neigh = abs(t_neigh - ts);
        max_dist = max(dist_neigh);
        u = dist_neigh/max_dist;
        w = (1- (u.^3)).^3;
        weights_all(i,1:k) = w';
        
        % Weighted quadratic fit: polyval form, order 2
        ft = fittype('poly2');
        opts = fitoptions('poly2', 'Weights', w', 'Normalize', 'on');
        p = fit(t_neigh, X_neigh, ft, opts);
        
        % Evaluate at ts
        X_smooth(i) = p(ts);
    end
end


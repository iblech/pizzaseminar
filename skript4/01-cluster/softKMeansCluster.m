function [r, m, Sigma, pr] = softKMeansCluster(x, numClusters) 
% x should be of form 
%   x_1^(1) ... x_d^(1)
%   x_1^(2)
%   ...
%   x_1^(N)
% where N is the number of data points and d is their dimension


N_sim = 100;	% number of iterations

% Initialization

[N, d] = size(x);
K = numClusters;
m = zeros(K, d);
Sigma = zeros(d, d, K);
r = zeros(K, N);	% responsibility matrix: between each of K clusters and each of N data points
R = zeros(K, 1);	% R(j) is the total responsibility of cluster j
pr = 1/K*ones(K, 1);	% pr is the scaled version of R
threshold = 0.0001;
threshbreak = 0.000001;

% construct random initial mean points
for l=1:numClusters
m(l, :) = unifrnd(min(x)-(max(x)-min(x)), max(x)+(max(x)-min(x)));
end

% initial covariance is assumed to be identity
for k=1:K
    Sigma(:, :, k) = eye(d, d);  % covariance matrix
end


% Iteration
for curr = 1:N_sim
	% assignment step
    xrange = 1/100*1:100*(10);
    yrange = 1/100*1:100*(10);

    figure(2);
    clf();
    hold on;
    cmap = hsv(6);
    for n=1:N
        maxRespIndex = find(r(:, n) == max(r(:, n)), 1);
        if (r(maxRespIndex, n) >= .8)
            plot(x(n, 1), x(n, 2), 's', 'Color', cmap(maxRespIndex, :));
        else
            plot(x(n, 1), x(n, 2), 'x', 'Color', 'blue');
        end
    end
    for k=1:numClusters
        [ev, l] = eig(Sigma(:, :, k));
        ri1 = sqrt(l(1, 1))*ev(:, 1)./norm(ev(:, 1));
        ri2 = sqrt(l(2, 2))*ev(:, 2)./norm(ev(:, 2));
        hold on;
        plot([m(k, 1)-ri1(1), m(k, 1)+ri1(1)], [m(k, 2)-ri1(2), m(k, 2)+ri1(2)])
        plot([m(k, 1)-ri2(1), m(k, 1)+ri2(1)], [m(k, 2)-ri2(2), m(k, 2)+ri2(2)])
    end
    pause(0.2);
	% do this for every data point individually: less messy notation
	% cycle through data points	
    resp_relative = zeros(K, N);
    for k_cluster = 1:K
        m_current = m(k_cluster, :);
        Sigma_current = Sigma(:, :, k_cluster);
        dist = (repmat(m_current, N, 1)-x)'; % every column contains the difference vecor
        % ... m_current - z_n, where n is the nth row
        Sig_inv = inv(Sigma_current);
        exp_factor = -1/2*Sig_inv*dist;
        for n_data=1:N
            exp_entry = dist(:, n_data)'*exp_factor(:, n_data);
            exp_term(1, n_data)=exp(exp_entry);
        end
        % now exp_term contains exp(-1/2*(x(n)-m(k))*Sigma*(x(n)-m(k)))
        resp_relative(k_cluster, :) = exp_term * pr(k_cluster)/((sqrt(2*pi))^d * sqrt(det(squeeze(Sigma_current))));
    end
	% assignment complete
	% now do update:
    r = resp_relative;
    r = r./(repmat(sum(r, 1), K, 1));
    R = sum(r, 2);
    pr = R./(sum(R));
	% share of individual distribution has been updated
    m_new = r*x./(repmat(R, 1, d));


    if(norm(m-m_new)/norm(m) < threshbreak)
	break;
    else
        m = m_new;
    end

	% cluster centers have been updated
    Sigma_new = zeros(d, d, K);
    for k_cluster = 1:K
        m_current = m(k_cluster, :);
        Sigma_current = Sigma(:, :, k_cluster);
        dist = (repmat(m_current, N, 1)-x)';
        Sigma_new_k = (repmat(r(k_cluster, :), d, 1).*dist)*dist'./(R(k_cluster));
        for n1=1:d
            for n2=1:d
                Sigma_new(n1, n2, k_cluster) = Sigma_new_k(n1,n2);
            end
        end
    end
    Sigma = Sigma_new;
	% covariance matrices have been updated
end
end



    
        

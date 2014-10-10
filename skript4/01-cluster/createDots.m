function [x, y] = createDots(xrange, yrange)    
% creates an amount of dots with x- and y-coordinates
% by clicking on the canvas 
% teminate by right-click

N_max = 500;    % max number of points

figure(1);
clf(1);
xlim(xrange);
ylim(yrange);
x = zeros(N_max, 1);
y = zeros(N_max, 1);
for k=1:N_max
    [X, Y, button] = ginput(1);
    if (button == 3)            % terminate procedure on right click
        break;
    else
        hold on;
        x(k) = X;
        y(k) = Y;
        plot(X, Y, 's');        % plot instantly
    end
end

x = x(1:k-1);   % delete unused elements
y = y(1:k-1);
end
function field_lines()
    q1 = input('Enter q1 (e.g., 1 or -1): ');
    while q1 == 0
        disp('q1 cannot be zero. Please enter a nonzero value.');
        q1 = input('Enter q1 (e.g., 1 or -1): ');
    end

    q2 = input('Enter q2 (e.g., 1 or -1): ');
    while q2 == 0
        disp('q2 cannot be zero. Please enter a nonzero value.');
        q2 = input('Enter q2 (e.g., 1 or -1): ');
    end

    numLines = input('Enter the number of field lines (positive integer): ');
    while ~isscalar(numLines) || numLines <= 0 || floor(numLines) ~= numLines
        disp('Number of field lines must be a positive integer.');
        numLines = input('Enter the number of field lines (positive integer): ');
    end

    d = input('Enter the distance between charges d (positive number): ')/2;
    
    while ~isscalar(d) || d <= 0
        disp('Distance d must be a positive number.');
        d = input('Enter the distance between charges d (positive number): ');
    end

    xspan = [-2*d, 2*d];
    y_max = 1.5 * d;
    options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);

    dydx = @(x, y) field_dydx(x, y, q1, q2, d);

    figure;
    hold on;
    colors = lines(numLines);

    initialYs = linspace(-y_max, y_max, numLines);

    for k = 1:numLines
        y0 = initialYs(k);

        [xsol1, ysol1] = ode45(dydx, xspan, y0, options);
        plot(xsol1, ysol1, 'Color', colors(mod(k-1, size(colors,1)) + 1, :), 'LineWidth', 1.5);

        [xsol2, ysol2] = ode45(dydx, fliplr(xspan), y0, options);
        plot(xsol2, ysol2, 'Color', colors(mod(k-1, size(colors,1)) + 1, :), 'LineWidth', 1.5);
    end

    plot(-d, 0, 'ro', 'MarkerFaceColor', getChargeColor(q1), 'MarkerSize', 10);
    plot(d, 0, 'ro', 'MarkerFaceColor', getChargeColor(q2), 'MarkerSize', 10);

    xlabel('x');
    ylabel('y');
    title(sprintf('Electric Field Lines: q1 = %.1f, q2 = %.1f, d = %.2f', q1, q2, d));
    axis equal;
    grid on;
    hold off;
end

function dy = field_dydx(x, y, q1, q2, d)
    r1 = ((x + d).^2 + y.^2).^(3/2);
    r2 = ((x - d).^2 + y.^2).^(3/2);

    E_x = q1 * (x + d) ./ r1 + q2 * (x - d) ./ r2;
    E_y = q1 * y ./ r1 + q2 * y ./ r2;

    dy = E_y ./ E_x;
end

function c = getChargeColor(q)
    if q > 0
        c = [1, 0, 0];
    else
        c = [1, 1, 1];
    end
end

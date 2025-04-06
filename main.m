Seg1 = 0.5; 
Seg2 = 0.3; 
Seg3 = 0.2;

Angle1_range = linspace(-pi/3, pi/3, 3);
Angle2_range = linspace(-2*pi/3, 2*pi/3, 3);
Angle3_range = linspace(-pi/2, pi/2, 3);

fine1 = linspace(-pi/3, pi/3, 50);
fine2 = linspace(-2*pi/3, 2*pi/3, 50);
fine3 = linspace(-pi/2, pi/2, 50);

[T1, T2, T3] = ndgrid(fine1, fine2, fine3);
X = Seg1*cos(T1) + Seg2*cos(T1 + T2) + Seg3*cos(T1 + T2 + T3);
Y = Seg1*sin(T1) + Seg2*sin(T1 + T2) + Seg3*sin(T1 + T2 + T3);

figure; set(gcf, 'Position', [100, 100, 800, 400]);

subplot(1,2,1); hold on; axis equal; grid on;
title('Reachable Workspace', 'color', 'b');
xlabel('X'); ylabel('Y');

draw_arc(0, 0, Seg1, min(Angle1_range), max(Angle1_range));
draw_arc(0, 0, Seg1 + Seg2, min(Angle1_range), max(Angle1_range));
draw_arc(0, 0, Seg1 + Seg2 + Seg3, min(Angle1_range), max(Angle1_range));

for a1 = Angle1_range
    x1 = Seg1 * cos(a1);
    y1 = Seg1 * sin(a1);
    draw_arc(x1, y1, Seg2, min(Angle2_range) + a1, max(Angle2_range) + a1);
    
    for a2 = Angle2_range
        x2 = x1 + Seg2 * cos(a1 + a2);
        y2 = y1 + Seg2 * sin(a1 + a2);
        draw_arc(x2, y2, Seg3, min(Angle3_range) + a1 + a2, max(Angle3_range) + a1 + a2);
        draw_arc(x1, y1, Seg2 + Seg3, min(Angle2_range) + a1, max(Angle2_range) + a1);
    end
end

subplot(1,2,2); hold on; axis equal; grid on;
title('Validation Plot');
scatter(X(:), Y(:), 0.2, 'r');
hold off;

function draw_arc(x0, y0, r, t1, t2)
    theta = linspace(t1, t2, 100);
    plot(x0 + r*cos(theta), y0 + r*sin(theta), 'k-', 'LineWidth', 2);
end

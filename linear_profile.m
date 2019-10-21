SCREENSHOT = false;

a = 1;
T = 100;
p0 = 50;
pc = 20;

FigHandle = figure();
set(FigHandle, 'Position', [100, 100, 1049, 205]);

p = [];
for t=1:T
    if(t<30)
        p(t) = p0 - a*t;        
    elseif(t<70)
        p(t) = pc;
    else    
        p(t) = -50 + a*t;        
    end
end
subplot(151);
plot(p,'LineWidth',2.0);
title('p');

ts = [p(1)];
xs = [1];
for i=1:length(p)
  ts(i+1) = ts(i) + p(i);
  xs(i+1) = i+1;
end
subplot(152);
plot(xs,ts,'LineWidth',2.0);
title('x');

subplot(153);
dx = diff(xs);
dt = diff(ts);
v = dx./dt;
plot(v,'LineWidth',2.0);
title('v');
% vmax = max(v);
% ylim([0 vmax*1.1]);

dv = diff(v);
dtt = dt(1:end-1);
a = dv./dtt;
subplot(154);
plot(a,'LineWidth',2.0);
title('a');

da = diff(a);
dttt = dt(1:end-2);
jerk = da./dttt;
subplot(155);
plot(jerk,'LineWidth',2.0);
title('jerk');

if(SCREENSHOT)
    fig = gcf;
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0 0 6 3];
    fig.PaperPositionMode = 'manual';
    print('susu_accel.png','-dpng');
end




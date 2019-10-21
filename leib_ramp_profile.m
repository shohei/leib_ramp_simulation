SCREENSHOT = false;

FigHandle = figure();
set(FigHandle, 'Position', [100, 100, 1049, 205]);

p = [];

[p,v,xs,ts] = leib_ramp(150,10,2000,25,5,false);

% for t=1:T
%     if(t<30)
%         p(t) = p0 - a*t;        
%     elseif(t<70)
%         p(t) = pc;
%     else    
%         p(t) = -50 + a*t;        
%     end
% end
subplot(151);
plot(p,'LineWidth',2.0);
title('p');

% ts = [p(1)];
% xs = [1];
% for i=1:length(p)
%   ts(i+1) = ts(i) + p(i);
%   xs(i+1) = i+1;
% end
subplot(152);
plot(ts,xs(1:end-1),'LineWidth',2.0);
title('x');

subplot(153);
% dx = diff(xs);
% v = dx./dt;
plot(ts,v,'LineWidth',2.0);
title('v');
% vmax = max(v);
% ylim([0 vmax*1.1]);

dt = diff(ts);
dv = diff(v);
a = dv./dt;
subplot(154);
plot(ts(1:end-1),a,'LineWidth',2.0);
title('a');

da = diff(a);
dt = dt(1:end-1);
jerk = da./dt;
subplot(155);
plot(ts(1:end-2),jerk,'LineWidth',2.0);
title('jerk');

if(SCREENSHOT)
    fig = gcf;
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0 0 6 3];
    fig.PaperPositionMode = 'manual';
    print('susu_accel.png','-dpng');
end



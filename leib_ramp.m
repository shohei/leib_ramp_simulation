function [p,v,x,t] = leib_ramp(totalsteps,a,F,v,v0,standalone_flag)

format compact;

%% for debugging
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
STANDALONE = false;
CAPTURE = false;
SCREENSHOT = false;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if(STANDALONE)
%     clear all;
%     close all;
% end

if standalone_flag==true
  STANDALONE=true;
end

if(STANDALONE)
    FigHandle = figure;
    set(FigHandle, 'Position', [100, 100, 1000, 300]);
end


%% given parameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(STANDALONE)
    totalsteps = 150; %total steps
    a = 10; %steps per sec^2
    F = 2000; %Hz
    v = 25;% (steps/s): slew speed: max feedrate
    v0 = 5;%(steps/s): base speed
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(CAPTURE)
    writerObj = VideoWriter('newfile.avi');
    open(writerObj);
end


%% main computation
S = (v^2-v0^2) / (2*a);
p1 = F/sqrt(v0^2+2*a);
ps = F/v;
R = a/F^2;


p(1) = p1;
x(1) = 0;
t(1) = 0;
for i=1:totalsteps
    x(end+1) = i;
    t(end+1) = t(end) + p(end);
    v = horzcat(abs(diff(x)./diff(t)));
    
    if(i<S)
        m = -R;
    elseif(i<totalsteps-S)
        m = 0;
    else
        m = R;
    end
    
    p(i+1) = p(i) * (1 + m*p(i)*p(i));
    if p(i+1) < ps
        p(i+1) = ps;
    elseif p(i+1) > p1
        p(i+1) = p1;
    end
    
    if(STANDALONE)
        subplot(131);
        plot(p);
        title('delay');
        
        subplot(132);
        plot(t,x,'r');
        title('x');
        
        subplot(133);
        plot(t(1:end-1),v,'b');
        title('v');
        
        drawnow;
        
        if(CAPTURE)
            frame = getframe(gcf);
            writeVideo(writerObj, frame);
        end
        
    end
end
t = t(1:end-1);

if(CAPTURE)
    close(writerObj);
end

if(SCREENSHOT)
    fig = gcf;
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0 0 6 3];
    fig.PaperPositionMode = 'manual';
    print('leib_ramp_screenshot.png','-dpng');
end


end

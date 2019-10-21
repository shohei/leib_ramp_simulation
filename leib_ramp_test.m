clear all; close all;
totalsteps = 150; %total steps
a = 10; %steps per sec^2
F = 2000; %Hz
v = 25;% (steps/s): slew speed: max feedrate
v0 = 5;%(steps/s): base speed
standalone_flag=true;

leib_ramp(totalsteps,a,F,v,v0,standalone_flag);

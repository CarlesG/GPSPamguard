%% click trigger calculation 
noise=0.6;
sR=500000;

porp_click=makeClick(130000, 140000, 0.00015, noise, sR, true);
plot(porp_click);
 
click_noise=(rand(256,1)-0.5)*noise;

click_wav=[click_noise; porp_click; click_noise(1:128)];

plot(click_wav)

plot()


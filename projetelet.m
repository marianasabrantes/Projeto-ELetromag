%Item 1 - Criando a antena:

narms=1
turns=5
inr=.4
outr=.5
tilt=90

antena_1 = spiralArchimedean('NumArms', narms, 'Turns', turns, 'InnerRadius', inr, 'OuterRadius', outr, 'Tilt', tilt, 'TiltAxis', 'Y');
figure
show(antena_1);
%%
% Item 2 - Calculando a impedância:
freq = linspace(1*1e6, 10*1e6, 200);
figure
Z=impedance(antena_1, freq)
Zimag=imag(Z)
plot(freq,Zimag)
ylim([-100 100])

%%

% Item 3 - Antena receptora e array das antenas:
antena_2 = spiralArchimedean('NumArms', 1, 'Turns', 5, 'InnerRadius', .4, 'OuterRadius', .5, 'Tilt', 90, 'TiltAxis', 'Y');
antenas = linearArray('Element', [antena_1 antena_2]);
antenas.ElementSpacing=.4;
figure;
show(antenas);
%%
% Item 5 - Simulando Acoplamento e visualizar grafico:
ganhos = sparameters(antenas, freq);
figure;
rfplot(ganhos,2,1,'abs');
%%

% Item 6 - Visualização 3D:

dist=linspace(0.05,0.5,25)
ganhos_3d=zeros(length(dist),length(freq))
for i=1:length(dist)
    antenas.ElementSpacing=dist(i)
    ganhos = sparameters(antenas, freq)
    ganhos_3d(i,:) = rfparam(ganhos,2,1);
end

figure;
Z=abs(ganhos_3d)
[X,Y]=meshgrid(freq/1e6,dist);
surf(X,Y,Z,'EdgeColor','none');
view(150,20);
shading(gca,'interp');
axis tight;
xlabel('Frequency [MHz]');
ylabel('Distance [m]');
zlabel('S_{21} Magnitude');
%%
% Item 7 - Corrente:
freq_ress=8.1e6
figure;
current(antena_1,freq_ress)
%%
%item9
freq_ress=8.1e6
dist=linspace(0.05,0.5,25)
ganhos_3d(:)=zeros
for i=1:length(dist)
    antenas.ElementSpacing=dist(i)
    ganho=sparameters(antenas,freq_ress)
    ganhos_3d(i,:) = rfparam(ganho,2,1)
end
   
plot(dist, abs(ganhos_3d))
xlabel('Distancia [m]');
ylabel('Ganhos');
%%%%%%%%%Gyanajyoti Routray%%%%%%%%%
%This program gives the spherical harmonic matrix 
%Inputs : 'order': order of ambisonics, 'spk_no': number of speakers  


function [coef_sp_array, pos] = G_Yspk_coef_sp_array(order,spk_no)

[V,Tri,~,Ue]=ParticleSampleSphere('N',spk_no);
figure('color','w')
subplot(1,2,1)
plot(0:numel(Ue)-1,Ue,'.-')
set(get(gca,'Title'),'String','Optimization Progress','FontSize',20)
xlabel('Iteration #','FontSize',15)
ylabel('Reisz s-enrgy','FontSize',15)
subplot(1,2,2)
h=patch('faces',Tri,'vertices',V); 
set(h,'EdgeColor','b','FaceColor','w')
axis equal vis3d
view(3)
grid on
set(gca,'XLim',[-1.1 1.1],'YLim',[-1.1 1.1],'ZLim',[-1.1 1.1])
set(get(gca,'Title'),'String','Final Mesh','FontSize',20)
[N M]=size(V);

[azimuth,elevation,r] = cart2sph(V(:,1),V(:,2),V(:,3));
 
pos=[azimuth,elevation];
azimuth_degree=radtodeg(azimuth);
elevation_degree=radtodeg(elevation);
figure ('color','w')
AMplot(azimuth_degree,elevation_degree,1);

figure ('color','w')
AMplot_radian(azimuth,elevation,1);

for position=1:N
coef_sp_array(:,position)= AMbisonicsCF(elevation_degree(position),azimuth_degree(position),order);
end
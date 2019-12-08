% SIMPLE CONVOLUTION FUNCTION conv(x,h) 
% Lucas Emanuel Batista dos Santos 
% - 
% Receive two vectors and show on screen a new vector resultant of 
% convolution operation 
function C = convindex(f, g, index)

% Transform the vectors f and g in new vectors with the same length 
F = [f,zeros(1,length(g))]; 
G = [g,zeros(1,length(f))];

% FOR Loop to put the result of convolution between F and G vectors 
% in a new vector C. According to the convolution operation characteristics, 
% the length of a resultant vector of convolution operation between two vector 
% is the sum of vectors length minus 1 
i = index;
% Create a new vector C 
C = 0; 
% FOR Loop to walk through the vector F and G 
for j=1:length(f) 
    if(i-j+1>0) 
    C = C + F(j) * G(i-j+1); 
    end 
end 
end
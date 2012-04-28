function [delta] = evolve_vector_ENO3(phi, dx, dy, dz, u_ext, v_ext, w_ext)
%
% Finds the amount of evolution under a vector field
% based force and using 3rd order accurate ENO scheme
%
% Adapted by Mark Brophy (mbrophy5@csd.uwo.ca)
% from the work of Baris Sumengen  sumengen@ece.ucsb.edu
% http://vision.ece.ucsb.edu/~sumengen/
%

delta = zeros(size(phi)+6);
data_ext = zeros(size(phi)+6);
data_ext(4:end-3,4:end-3,4:end-3) = phi;

% scan the depth
for k = 1:size(phi,3) % can do k+3 because of the extended delta above
    % scan the rows
    for i=1:size(phi,1)
        delta(i+3,:,k+3) = delta(i+3,:,k+3) + upwind_ENO3(data_ext(i+3,:,k+3), u_ext(i+3,:,k+3), dx);
    end
end

% scan the depth
for k = 1:size(phi,3)
    % scan the columns
    for j=1:size(phi,2)
        delta(:,j+3,k+3) = delta(:,j+3,k+3) + upwind_ENO3(data_ext(:,j+3,k+3), v_ext(:,j+3,k+3), dy);
    end
end

% scan the columns
for i = 1:size(phi,1)
    % scan the rows
    for j = 1:size(phi,2)
        delta(i+3,j+3,:) = delta(i+3,j+3,:) + upwind_ENO3(data_ext(i+3,j+3,:), w_ext(i+3,j+3,:), dz);
    end
end

delta = delta(4:end-3,4:end-3,4:end-3);
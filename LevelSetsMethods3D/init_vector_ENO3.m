function [u_ext, v_ext,w_ext] = init_vector_ENO3(u,v,w)
%
% Extends boundaries of u and v
%
% Author: Baris Sumengen  sumengen@ece.ucsb.edu
% http://vision.ece.ucsb.edu/~sumengen/
%

u_ext = zeros(size(u)+6);
v_ext = zeros(size(v)+6);
w_ext = zeros(size(w)+6);
u_ext(4:end-3,4:end-3,4:end-3) = u;
v_ext(4:end-3,4:end-3,4:end-3) = v;
w_ext(4:end-3,4:end-3,4:end-3) = w;

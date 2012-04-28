function [ d1,d1_x,d1_y,d1_z] = getDistanceFunctionFromPoints( X1,X2,X3,x,y,z )
%UNTITLED Summary of this function goes here
%   y,x,z = meshgrid(yrange,xrange,zrange)

EPS_VAL = 1e-7;

d1 = ones(size(x));
d1_size = size(d1(:));
d1_x = ones(size(x));
d1_y = ones(size(x));
d1_z = ones(size(x));

count = 1;
d_size = size(d1,1) * size(d1,2) * size(d1,3);

%for i = 1:size(d1,1)
%    for j = 1:size(d1,2)
%        for k = 1:size(d1,3)
for i = 1:d1_size
	if mod( count, 500 ) == 0
                sprintf( '%f of dist function calc completed', ...
                    count/d_size*100. )
    end
            % d is the minimum distance to a back-projected point
            % now using L1-distance 
            norm_val_1 = sqrt( (x(i) - X1).^2 + (y(i) - X2).^2 + (z(i) - X3).^2 );
            [d1(i),idx2] = min( norm_val_1 );
            d1(i) = max( abs(d1(i)),EPS_VAL );
            d1_x(i) = ( x(i) - X1(idx2) ) / ( 1. + (d1(i) ) );%double(d1(i,j,k)==0));
            d1_y(i) = ( y(i) - X2(idx2) ) / ( 1. + (d1(i) ) ); %double(d1(i,j,k)==0));
            d1_z(i) = ( z(i) - X3(idx2) ) / ( 1. + (d1(i) ) );% double(d1(i,j,k)==0));
            
            %{
            min_norm = 100;
            min_norm_x = 100; min_norm_y = 100; min_norm_z = 100;
            for idx = 1:size(X1,2)
                norm_val = norm([x(i,j,k) - X1(idx), y(i,j,k) - X2(idx), z(i,j,k) - X3(idx)],1 );
                if( norm_val < min_norm )
                    min_norm = norm_val;
                    min_norm_x = ( x(i,j,k) - X1(idx) ) / (norm_val + double(norm_val==0));
                    min_norm_y = ( y(i,j,k) - X2(idx) ) / (norm_val + double(norm_val==0));
                    min_norm_z = ( z(i,j,k) - X3(idx) ) / (norm_val + double(norm_val==0));
                end
            end
            
            d(i,j,k) = min_norm;
            d_x(i,j,k) =  -min_norm_x;
            d_y(i,j,k) =  -min_norm_y;
            d_z(i,j,k) =  -min_norm_z;
            if( d1(i,j,k) ~= d(i,j,k) )
                sprintf( 'd1(%d,%d,%d) is unequal to d',i,j,k )
                d1(i,j,k)
                d(i,j,k)
                
            end
             if( d1_x(i,j,k) ~= d_x(i,j,k) )
                sprintf( 'd1_x(%d,%d,%d) is unequal to d',i,j,k  )
             end
             if( d1_y(i,j,k) ~= d_z(i,j,k) )
                sprintf( 'd1_y(%d,%d,%d) is unequal to d',i,j,k  )
             end
             if( d1_z(i,j,k) ~= d_z(i,j,k) )
                sprintf( 'd1_z(%d,%d,%d) is unequal to d',i,j,k  )
            end
            %}
            count = count + 1;
     %   end
    %end
end

end
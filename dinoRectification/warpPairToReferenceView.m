function [ T_ref,TL] = warpPairToReferenceView( I_ref,pm_ref,IL,pml )%IR,pmr )
%WARPPAIRTOREFERENCEVIEW Warps a stereo pair to a common reference view
    
    [T_ref,TL,pm_ref1,pml1] = rectify(pm_ref,pml);
    % centering REF image
    p = [size(I_ref,1)/2; size(I_ref,2)/2; 1];
    px = T_ref * p;
    d_ref = p(1:2) - px(1:2)./px(3) ;
    % centering LEFT image
    p = [size(IL,1)/2; size(IL,2)/2; 1];
    px = TL * p;
    dR = p(1:2) - px(1:2)./px(3) ;

    % vertical diplacement must be the same
    dR(2) = d_ref(2);
    %  rectification with centering
    [T_ref,TL,pm_ref1,pml1] = rectify(pm_ref,pml,d_ref,dR);
    
    
    
    
    %bb = mcbb(size(I_ref),size(IL), T_ref, TL);

    % warp RGB channels,
    %for c = 1:3
        % Warp LEFT
     %   [JL(:,:,c),bbL,alphaL] = imwarp(IL(:,:,c), TL, 'bilinear', bb);
        % Warp RIGHT
     %   [J_ref(:,:,c),bbR,alphaR] = imwarp(I_ref(:,:,c), T_ref, 'bilinear', bb);
    %end
end
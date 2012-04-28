addpath( '~/Code/third_party/RectifKitE/' );
addpath( '~/Code/file_management/' );
addpath( '~/Code/third_party/stereoflowlinux/' );


IL = imread( '~/Data/dinoRing/dinoR0001.png' );
IR = imread( '~/Data/dinoRing/dinoR0010.png' );

[a,P,numImages] = dinoFileRead( '~/Data/dinoRing/dinoR_par.txt' );

pml = P{1};
pmr = P{10};
ml = [0;0];


% Epipolar geometry
[F,epil,epir] = fund(pml,pmr);
% --------------------  RECTIFICATION
disp('---------------------------------- rectifying...')

%  rectification without centeriing
[TL,TR,pml1,pmr1] = rectify(pml,pmr);
% centering LEFT image
p = [size(IL,1)/2; size(IL,2)/2; 1];
px = TL * p;
dL = p(1:2) - px(1:2)./px(3) ;
% centering RIGHT image
p = [size(IR,1)/2; size(IR,2)/2; 1];
px = TR * p;
dR = p(1:2) - px(1:2)./px(3) ;

% vertical diplacement must be the same
dL(2) = dR(2);
%  rectification with centering
[TL,TR,pml1,pmr1] = rectify(pml,pmr,dL,dR);

disp('---------------------------------- warping...')
% find the smallest bb containining both images
bb = mcbb(size(IL),size(IR), TL, TR);

% warp RGB channels,
for c = 1:3
    % Warp LEFT
    [JL(:,:,c),bbL,alphaL] = imwarp(IL(:,:,c), TL, 'bilinear', bb);
    % Warp RIGHT
    [JR(:,:,c),bbR,alphaR] = imwarp(IR(:,:,c), TR, 'bilinear', bb);
end

% warp tie points
mlx = p2t(TL,ml);

shiftrange = [-45:45];
[bestshiftsL, occlL, bestshiftsR, occlR] = stereoCorrespond(JL, JR, shiftrange);

%{
JL2 = rgb2gray(JL);
JR2 = rgb2gray(JR);
dx = zeros(size(JL)); %,'single');
DbasicSubpixel= zeros(size(JL), 'single');
halfTemplateWidth = 5;  halfTemplateHeight = 5;
template = ones(2*halfTemplateWidth+1,2*halfTemplateHeight+1);
ROI = ones(size(template,1),size(template,2)+2);
% scan over all rows
for i = 20*halfTemplateHeight+1:size(JL,1)-20*halfTemplateHeight
    % scan over all columns
    for j = 20*halfTemplateWidth+1:size(JL,2)-20*halfTemplateWidth
        template(:,:) = JL2(i-halfTemplateHeight:i+halfTemplateHeight, ...
            j-halfTemplateWidth:j+halfTemplateWidth );
        if size( unique(template),1 ) ~= 1 % check template isn't uniform
            ROI(:,:) = JR2( i-halfTemplateHeight:i+halfTemplateHeight, ...
                j-halfTemplateWidth+bestshiftsR(i,j)-1:j+halfTemplateWidth+bestshiftsR(i,j)+1 );
            m = normxcorr2(template,ROI);
            dx(i,j) = bestshiftsR(i,j) + ...
                (  ( m(11,10) - m(11,13) ) / ...
                    2.0*(m(11,11) - m(11,12) + m(11,13)) );
        else
            dx(i,j) = bestshiftsR(i,j);
        end
    end
end

dx2 = dx + abs(min(dx(:)));
dx2_norm = dx2 / max(dx2(:));
imagesc(dx2_norm);
%}
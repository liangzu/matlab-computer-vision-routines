data = open('../../Data/ITV_Workspace.mat')
addpath('../PointCloudGenerator' );
addpath(genpath('../third_party/CPD2/'));
addpath('../plant_registration');
names = data.names_patient002;
segmentation = data.rois_patient002;
num_segmentations = size(segmentation,2);
X = cell(num_segmentations,1);
data = cell(num_segmentations,1);
for i=1:num_segmentations

    b = segmentation{i};
    b_x=[];b_y=[];b_z=[];
    for j = 1:size(b,1)
        b_x = [b_x; b{j}(:,1)];
        b_y = [b_y; b{j}(:,2)];
        b_z = [b_z; b{j}(:,3)];
    end
    
    X{i} = [b_x,b_y,b_z];
    
end
%patient 1
staple_00_percent = 2;
staple_10_percent = 4;
staple_20_percent = 6;
staple_30_percent = 8;
staple_40_percent = 10;
staple_50_percent = 11;
staple_60_percent = 14;
staple_70_percent = 16;
staple_80_percent = 18;
staple_90_percent = 20;

% list of every propagated gtv from patient i to
% register to the 10% staple.
gtvs_to_propagate_to_00_percent_idx = ...
    [40 57 76 94 112 130 148 166 184];
gtvs_to_propagate_to_10_percent_idx = ...
    [22 42 59 96 114 132 150 168 186];
gtvs_to_propagate_to_20_percent = ...
    [24 44 61 78 116 134 152 170 188];
gtvs_to_propagate_to_30_percent = ...
    [25 63 80 98 118 136 154 172 190];
opt.viz = 1;
opt.max_it = 70;
opt.rotation = 1;
opt.scale = 0;
opt.normalize = 1;
opt.fgt = 2; %will be zero
opt.lambda = 3;
opt.method = 'nonrigid_lowrank';
opt.beta = 2; %possible that less than this is too much ram


%wrap in function


end
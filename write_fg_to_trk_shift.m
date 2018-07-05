function write_fg_to_trk_shift( fg, nii_file, trk_file)
% Write fg data into Trackvis format
%
%   write_fg_to_trk(fg, filename)
%
% write_fg_to_trk write fiber group structure fg to trackvis file.
%
% Input:
%       fg: is a mrDiffusion fiber group structure
%       nii_file: the nifti image for reference space of fibers
%       trk_file: Name of trk file to output
%                 Recommended the use of '.trk' extension of file
% Output:
%       
%
% For details about header fields and fileformat see:
% http://www.trackvis.org/docs/?subsect=fileformat
%
% Example;
%
%   write_fg_to_trk(fg, 'dwi.nii.gz', 'csd_life.trk');
%

% Load the header of nifti reference file
hdr_nii = niftiRead(nii_file);

% Dummy empty header
hdr_trk.id_string = 'TRACK';

% The dimensions of the reference nifti file
hdr_trk.dim = hdr_nii.dim(1:3);

% The size of the voxels 
hdr_trk.voxel_size = hdr_nii.pixdim(1:3);

% Apparently not implemented by Trackvis
% hdr_trk.origin = [hdr_nii.qoffset_x, hdr_nii.qoffset_y, hdr_nii.qoffset_z];
hdr_trk.origin = [0.0, 0.0, 0.0];

% Optional features not managed by the current implementation
hdr_trk.n_scalars = 0;
hdr_trk.scalar_name = ['','','','','','','','','',''];
hdr_trk.n_properties = 0;
hdr_trk.property_name = ['','','','','','','','','',''];

% The affine transformation
scale_dim = diag(1 ./ hdr_trk.voxel_size);
affine = hdr_nii.qto_xyz;
% correct displacement of Vistasoft
affine(1,4) = affine(1,4) + affine(1,1);
affine(2,4) = affine(2,4) + affine(2,2);
affine(3,4) = affine(3,4) + affine(3,3);
hdr_trk.vox_to_ras = transpose(affine);
affine(1:3,1:3) = scale_dim .* affine(1:3,1:3);
affine_trackvis = affine;
affine_trackvis(1,4) = affine_trackvis(1,4) + hdr_trk.voxel_size(1)/2;
affine_trackvis(2:3,4) = affine_trackvis(2:3,4) - hdr_trk.voxel_size(1)/2;
nii2trk = inv(affine_trackvis);

hdr_trk.reserved = '';

% Original orientation of Trackvis toolbox
hdr_trk.voxel_order = 'LAS';  

% Orientation of the reference image
hdr_trk.pad2 = '';
hdr_trk.image_orientation_patient = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

hdr_trk.pad1 = '';
hdr_trk.invert_x = '';
hdr_trk.invert_y = '';
hdr_trk.invert_z = '';
hdr_trk.swap_xy = '';
hdr_trk.swap_yz = '';
hdr_trk.swap_zx = '';

% Total number of fibers/streamlines
hdr_trk.n_count = size(fg.fibers,1);

% Version of the current header
hdr_trk.version = 2;

% The size of the header as number of byte 
hdr_trk.hdr_size = 1000;

% Begin writing the trk file
fid = fopen(trk_file , 'w');

% Writing the header of trk file
% (some features are not implemented)
skip = 0;
wb = fwrite(fid,hdr_trk.id_string,'char');
skip = 6-wb*1;
wb = fwrite(fid,hdr_trk.dim,'3*int16',skip);
skip = 6-wb*2 + skip * (1 - sign(wb));
wb = fwrite(fid,hdr_trk.voxel_size,'3*float',skip);
skip = 12-wb*4 + skip * (1 - sign(wb));
wb = fwrite(fid,hdr_trk.origin,'3*float',skip); 
skip = 12-wb*4 + skip * (1 - sign(wb));
wb = fwrite(fid,hdr_trk.n_scalars,'int16',skip); 
skip = 2-wb*2 + skip * (1 - sign(wb));
wb = fwrite(fid,hdr_trk.scalar_name,'200*char',skip);
skip = 200-wb*1 + skip * (1 - sign(wb));
wb = fwrite(fid,hdr_trk.n_properties,'int16',skip);
skip = 2-wb*2 + skip * (1 - sign(wb));
wb = fwrite(fid,hdr_trk.property_name,'200*char',skip);
skip = 200-wb*1 + skip * (1 - sign(wb));
wb = fwrite(fid,hdr_trk.vox_to_ras,'16*float',skip);
skip = 64-wb*4 + skip * (1 - sign(wb));
wb = fwrite(fid,hdr_trk.reserved,'444*char',skip);
skip = 444-wb*1 + skip * (1 - sign(wb));
wb = fwrite(fid,hdr_trk.voxel_order,'4*char',skip);
skip = 4-wb*1 + skip * (1 - sign(wb));
wb = fwrite(fid,hdr_trk.pad2,'4*char',skip);
skip = 4-wb*1 + skip * (1 - sign(wb));
wb = fwrite(fid,hdr_trk.image_orientation_patient,'6*float',skip);
skip = 24-wb*4 + skip * (1 - sign(wb));
wb = fwrite(fid, hdr_trk.pad1,'2*char', skip);
skip = 2-wb*1 + skip * (1 - sign(wb));
wb = fwrite(fid, hdr_trk.invert_x,'1*uchar',skip);
skip = 1-wb*1 + skip * (1 - sign(wb));
wb = fwrite(fid, hdr_trk.invert_y,'1*uchar', skip);
skip = 1-wb*1 + skip * (1 - sign(wb));
wb = fwrite(fid, hdr_trk.invert_z,'1*uchar', skip);skip = 1-wb*1 + skip * (1 - sign(wb));
wb = fwrite(fid, hdr_trk.swap_xy,'1*uchar', skip);
skip = 1-wb*1 + skip * (1 - sign(wb));
wb = fwrite(fid, hdr_trk.swap_yz,'1*uchar', skip);
skip = 1-wb*1 + skip * (1 - sign(wb));
wb = fwrite(fid, hdr_trk.swap_zx,'1*uchar', skip);
skip = 1-wb*1 + skip * (1 - sign(wb));
wb = fwrite(fid, hdr_trk.n_count,'1*int32', skip);
skip = 4-wb*4 + skip * (1 - sign(wb));
wb = fwrite(fid, hdr_trk.version,'1*int32', skip);
skip = 4-wb*4 + skip * (1 - sign(wb));
wb = fwrite(fid, hdr_trk.hdr_size,'1*int32', skip);

% Writing the fibers/streamlines points to trk file
% (currently not supported the optional scalar and track properties)

for t=1:size(fg.fibers,1)
    fwrite(fid, size(fg.fibers{t},2),'int32');
    fpoints = mrAnatXformCoords(nii2trk, transpose(fg.fibers{t}));
    fwrite(fid,reshape(transpose(fpoints),1,numel(fpoints)),'float');    
end
        
fclose(fid)



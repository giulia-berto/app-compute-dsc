function out = afqConverter()

addpath(genpath('/N/u/hayashis/BigRed2/git/vistasoft'));
addpath(genpath('/N/u/brlife/git/jsonlab'));
addpath(genpath('/N/u/brlife/git/o3d-code'));
addpath(genpath('/N/u/brlife/git/encode'));

config = loadjson('config.json');
ref_src_sub1 = fullfile(config.t1_sub1);
ref_src_sub2 = fullfile(config.t1_sub2);

%convert afq to trk
disp('Converting afq to .trk');

%sub1
load(fullfile(config.segmentation1));
fid=fopen('tract_name_list.txt', 'w');

if (config.tract > 0)
    tract_name=strrep(fg_classified(config.tract).name,' ','_');
    write_fg_to_trk(fg_classified(config.tract),ref_src_sub1,sprintf('sub1_%s_tract.trk',tract_name));
	fprintf(fid, [tract_name, '\n']);
else
    for tract=1:20
        tract_name=strrep(fg_classified(tract).name,' ','_');
        write_fg_to_trk(fg_classified(tract),ref_src_sub1,sprintf('sub1_%s_tract.trk',tract_name));
        fprintf(fid, [tract_name, '\n']);  
    end 
end

fclose(fid);

%sub2
load(fullfile(config.segmentation2));

if (config.tract > 0)
    tract_name=strrep(fg_classified(config.tract).name,' ','_');
    write_fg_to_trk(fg_classified(config.tract),ref_src_sub2,sprintf('sub2_%s_tract.trk',tract_name));
else
    for tract=1:20
        tract_name=strrep(fg_classified(tract).name,' ','_');
        write_fg_to_trk(fg_classified(tract),ref_src_sub2,sprintf('sub2_%s_tract.trk',tract_name));
    end 
end

exit;
end
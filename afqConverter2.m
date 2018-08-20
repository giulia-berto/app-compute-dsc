function out = afqConverter2()

if ~isdeployed
	addpath(genpath('/N/u/brlife/git/vistasoft'));
	addpath(genpath('/N/u/brlife/git/jsonlab'));
	addpath(genpath('/N/u/brlife/git/o3d-code'));
end

config = loadjson('config.json');
ref_src_sub1 = fullfile(config.t1_sub1);
ref_src_sub2 = fullfile(config.t1_sub2);
run = config.run;

%convert afq to trk
disp('Converting afq to .trk');

%sub1
load(fullfile(config.segmentation1));
fid=fopen('tract_name_list.txt', 'w');

for tract=1:length(fg_classified)
    tract_name=strrep(fg_classified(tract).name,' ','_');
    write_fg_to_trk_shift(fg_classified(tract),ref_src_sub1,sprintf('%s_tract_%s.trk',tract_name,run));
    fprintf(fid, [tract_name, '\n']);  
end 

fclose(fid);

%sub2
load(fullfile(config.segmentation2));

if (config.tract1 > 0)
    for tract = [config.tract1, config.tract2, config.tract3, config.tract4, config.tract5, config.tract6, config.tract7, config.tract8]
        if (tract > 0)
            tract_name=strrep(fg_classified(tract).name,' ','_');
            write_fg_to_trk_shift(fg_classified(tract),ref_src_sub2,sprintf('%s_tract.trk',tract_name));
        end    
    end
else
    for tract=1:length(fg_classified)
        tract_name=strrep(fg_classified(tract).name,' ','_');
        write_fg_to_trk_shift(fg_classified(tract),ref_src_sub2,sprintf('%s_tract.trk',tract_name));
    end 
end

exit;
end

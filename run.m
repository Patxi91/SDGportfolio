%% Data import
clear all;
cd('C:\Users\Patxi\Desktop\SustainableHackathon');
fn = 'Hack3_1.xlsx';
folder = fileparts(which( fn )) % Determine where demo folder is.
fullFileName = fullfile(folder, fn );
[status, sheetNames] = xlsfinfo(fullFileName)
numSheets = length(sheetNames)
for i=1:size(sheetNames,2)
    if strcmp(sheetNames(1,i),'Client Profile') == 1
        sheet = i;
    end
end
clear T;
T = readtable(fullFileName, 'Sheet', sheet);


%%
client = 3;

% Client Profile
profile_aux = table2array( T(client+1,2:18) );% Data Imput
profile = zeros(1,2);
count=1;
for i=1:size(profile_aux,2)
    if isempty(profile_aux{1,i}) == 0
        profile(1,count) = str2double( cell2mat(profile_aux(1,i)) );
        count = count+1;
    end
end
fields = size(profile,2);

%% SDG ratings
for i=1:size(sheetNames,2)
    if strcmp(sheetNames(1,i),'Portfolio') == 1
        sheet = i;
    end
end
clear T2;
T2 = readtable(fullFileName, 'Sheet', sheet);

sdg_rating_aux = table2array( T2(28,9:25) );% Specific data Imput
sdg_rating = zeros(1,2);
count=1;
for i=1:size(profile_aux,2)
    if isempty(profile_aux{1,i}) == 0
        sdg_rating(1,count) = str2double( cell2mat(sdg_rating_aux(1,i)) );
        count = count+1;
    end
end

%% SDG RGB Colors
clear RGB rgb;
RGB = readtable('SDG Colors.xlsx', 'Sheet', 1);
rgb = table2array( RGB(1:end,2:end) );% Specific data Imput

%%
h = zeros(1,fields);% each arc

figure();
for i=1:fields
    sum = 0;
    for j=1:i
        sum = sum + profile(j);
    end
    h(i) = arcpatch(0,0,sdg_rating(i),3.6*[sum-profile(i) sum]);
end

%rgb colors selection
count = 1;
for i=1:size(profile_aux,2)
    if isempty(profile_aux{1,i}) == 0
        set(h(count),'facecolor',[rgb(i,1) rgb(i,2) rgb(i,3)]/255);
        count = count+1;
    end
end
set(h,'edgecolor','none','facealpha',1)
axis equal off














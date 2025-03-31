function [xsensTable] = processXSENSAllInterventions(xsensConfig, subject_xsens_folder, intervention_folders, mapped_interventions, regexsConfig)

%% PURPOSE: LOAD AND PREPROCESS THE XSENS DATA.
% Inputs:
% xsensConfig: Config struct specifically for XSENS
% subject_xsens_folder: The folder containing the subject's XSENS data
% intervention_folders: Cell array of folder names, one per intervention
% mapped_interventions: The intervention folder names mapped to field names
% regexsConfig: Config struct for regexs
%
% Outputs:
% xsensTable: Table with XSENS data

disp('Preprocessing XSENS');

xsensTable = table;
for i = 1:length(intervention_folders)
    intervention_folder = intervention_folders{i};        
    intervention_folder_path = fullfile(subject_xsens_folder, intervention_folder);
    intervention_field_name = mapped_interventions(intervention_folder);
    tmpTable = loadAndFilterXSENSOneIntervention(xsensConfig, intervention_folder_path, intervention_field_name, regexsConfig);
    xsensTable = addToTable(xsensTable, tmpTable);
end
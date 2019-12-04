function p = PlotCDataSurface(data,parc,hemi,whatView)

% Input:  data = vector of values to plot
%         parc = 'aparc' or 'cust200' or 'HCPMMP1'.
%                Indicates the parcellation used and you
%                want to plot data on
%         hemi = 'l' or 'r'. Hemisphere to use
%
% Example usage: PlotCDataSurface(data,'aparc','l')

if nargin < 4
    whatView = 'medial';
end

load('fsaverage_surface_data.mat')

doInflated = true;

f = figure('color','w');

switch hemi
    case 'l'
        if doInflated
            surface.vertices = lh_verts_inflated;
        else
        	surface.vertices = lh_verts;
        end
    	surface.faces = lh_faces;
        switch parc
            case 'aparc'
                vertdata = lh_aparc;
            case 'cust200'
                vertdata = lh_cust200;
            case {'HCPMMP1','HCP'}
                vertdata = lh_HCPMMP1;
        end

    case 'r'
    	surface.vertices = rh_verts;
    	surface.faces = rh_faces;
        switch parc
            case 'aparc'
                vertdata = rh_aparc;
            case 'cust200'
                vertdata = rh_cust200;
            case {'HCPMMP1','HCP'}
                vertdata = rh_HCPMMP1;
        end
end

cdata = changem(vertdata,data,1:length(data));

% data(data == 0) = 1.0202;
% data(isnan(data)) = 1.0202;

p = patch(surface);
set(p,'FaceVertexCData',cdata,'EdgeColor','none','FaceColor','flat');

if strcmp(whatView,'medial')
    view([90 0])
else
    view([-90 0])
end

camlight('headlight')
material('dull')
colormap([0.5*ones(1,3);flipud(BF_getcmap('redyellowblue',10,0))])
caxisLims = caxis();
unit = diff(caxisLims)/10;
caxis([-unit*0.9,caxisLims(2)])
cB = colorbar;
cB.Limits = caxisLims;

f.Position = [549   819   654   320];

% caxis([-1 1.0202])
% axis off
% axis vis3d
% colormap(cmap)

end

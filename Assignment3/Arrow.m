% https://de.mathworks.com/matlabcentral/fileexchange/68336-simple-cartesian-text-arrow
function Arrow(x,y,str,LengthFac,Rotation,varargin)
%ARROW_ER Draws textarrow annotation to specified point (x,y) with
%specified relative length (LengthFac -> fraction of diagonal axes width)
%and rotation (Rotation - 0deg: left to right, 90deg: top to bottom).
%Handle to arrow can be found in axes user data (UserData.Adata.an).
%Refreshed with zoom callback.
%
%   arrow_er(x,y,str)
%   arrow_er(x,y,str,LengthFac,Rotation)
%   arrow_er(x,y,str,LengthFac,Rotation,___)
%
%   Example:
%   arrow_er(0.5,0.5,'$\mu_{s}$',0.1,45,'Interpreter','latex','Color','r');
%
%   Handle:
%   s = get(gca,'UserData');
%   data = s.Adata;
%   h = data.an;
%
% Author:           Eduard Reitmann
% Version:          1.0 (2018-07-25)
% Original date:    2018-07-25
if nargin < 4
    LengthFac = 0.15;
end
if nargin < 5
    Rotation = 225;
end
ax = gca;
%% Add arrow
if ~isfield(ax.UserData,'Adata')
    ax.UserData.Adata.x = x;
    ax.UserData.Adata.y = y;
    ax.UserData.Adata.str = str;
    ax.UserData.Adata.Rotation = Rotation;
    ax.UserData.Adata.LengthFac = LengthFac;
    ax.UserData.Adata.varargin = varargin;
    ax.UserData.Adata.an = [];
else
    n = numel(ax.UserData.Adata);
    ax.UserData.Adata(n+1).x = x;
    ax.UserData.Adata(n+1).y = y;
    ax.UserData.Adata(n+1).str = str;
    ax.UserData.Adata(n+1).Rotation = Rotation;
    ax.UserData.Adata(n+1).LengthFac = LengthFac;
    ax.UserData.Adata(n+1).varargin = varargin;
    ax.UserData.Adata(n+1).an = [];
end
z = zoom;
set(z,'ActionPostCallback',@drawarrow,'Enable','on');
% set(gcf,'SizeChangedFcn',@drawarrow)
zoom out
end
function drawarrow(f,~)
ax = findobj(f,'Type','axes');
for i = 1:numel(ax)
    for j = 1:numel(ax(i).UserData.Adata)
        %% Convert to unitless values relative to axes position
        % x-coordinate of end-point
        mx = ax(i).Position(3)/diff(ax(i).XLim);
        cx = ax(i).Position(1) - mx*ax(i).XLim(1);
        ax(i).UserData.Adata(j).xu = ax(i).UserData.Adata(j).x.*mx + cx;
        % y-coordinate of end-point
        my = ax(i).Position(4)/diff(ax(i).YLim);
        cy = ax(i).Position(2) - my*ax(i).YLim(1);
        ax(i).UserData.Adata(j).yu = ax(i).UserData.Adata(j).y.*my + cy;
        % Start point
        Ldiag = sqrt(ax(i).Position(3)^2 + ax(i).Position(4)^2);    % Axes diagonal length
        [xc,yc] = pol2cart(deg2rad(ax(i).UserData.Adata(j).Rotation),ax(i).UserData.Adata(j).LengthFac*Ldiag);
        ax(i).UserData.Adata(j).xu = [ax(i).UserData.Adata(j).xu+xc ax(i).UserData.Adata(j).xu];
        ax(i).UserData.Adata(j).yu = [ax(i).UserData.Adata(j).yu+yc ax(i).UserData.Adata(j).yu];
        if min(ax(i).UserData.Adata(j).xu) >= ax(i).Position(1) && min(ax(i).UserData.Adata(j).yu) >= ax(i).Position(2) && ...
                max(ax(i).UserData.Adata(j).xu) <= ax(i).Position(1)+ax(i).Position(3) && max(ax(i).UserData.Adata(j).yu) <= ax(i).Position(2)+ax(i).Position(4)
            if isempty(ax(i).UserData.Adata(j).an)
                ax(i).UserData.Adata(j).an = annotation('textarrow',ax(i).UserData.Adata(j).xu,ax(i).UserData.Adata(j).yu,'String',ax(i).UserData.Adata(j).str,ax(i).UserData.Adata(j).varargin{:});
            else
                dP = [ax(i).UserData.Adata(j).an.X-ax(i).UserData.Adata(j).xu ax(i).UserData.Adata(j).an.Y-ax(i).UserData.Adata(j).yu];
                if any(dP ~= 0)
                    delete(ax(i).UserData.Adata(j).an);
                    ax(i).UserData.Adata(j).an = annotation('textarrow',ax(i).UserData.Adata(j).xu,ax(i).UserData.Adata(j).yu,'String',ax(i).UserData.Adata(j).str,ax(i).UserData.Adata(j).varargin{:});
                end
            end
        else
            if ~isempty(ax(i).UserData.Adata(j).an)
                delete(ax(i).UserData.Adata(j).an);
                ax(i).UserData.Adata(j).an = [];
            end
        end
    end
end
end
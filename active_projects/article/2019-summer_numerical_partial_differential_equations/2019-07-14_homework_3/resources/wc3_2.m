clear; close all;

model = createpde();

dl = get_geometry();
geometryFromEdges(model, dl);
figure;
pdegplot(dl, 'EdgeLabels', 'on', 'SubdomainLabels', 'on');
axis equal;

f = @(location, state) (location.x.^2+location.y.^2+state.time.^2);
specifyCoefficients(model, ...
    'm', 0, ...
    'd', 1, ...
    'c', 1, ...
    'a', 0, ...
    'f', f);

setInitialConditions(model, 0);

u = @(location, state) (location.x*location.y*state.time);
applyBoundaryCondition(model, ...
    'dirichlet', 'Edge', ...
    1 : model.Geometry.NumEdges, 'u', u);

generateMesh(model, 'Hmax', 0.1);

tlist = 0 : 0.2 : 1;
results = solvepde(model, tlist);
for i = 1 : length(tlist)
    figure;
    t = tlist(i);
    pdeplot(model, 'XYData', results.NodalSolution(:, i), ...
        'Title', ['t = ', num2str(t)]);
    axis equal;
end

function dl = get_geometry()
    gd = [1 0 0 1]';
    sf = 'D';
    ns = 'D';
    dl = decsg(gd, sf, ns);
end

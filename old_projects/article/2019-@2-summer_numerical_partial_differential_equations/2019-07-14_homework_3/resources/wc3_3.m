clear; close all;

MAX_ITER = 20; EPS = 1e-6;

model = createpde();

dl = get_geometry();
geometryFromEdges(model, dl);
figure;
pdegplot(dl, 'EdgeLabels', 'on', 'SubdomainLabels', 'on');
axis equal;

%f = @(location, state) (location.x.^2+location.y.^2);
f = 1;
specifyCoefficients(model, ...
    'm', 0, ...
    'd', 0, ...
    'c', 1, ...
    'a', 0, ...
    'f', 1);

%g = @(location, state) (-state.u.^3);
g = @(location, state) (-state.u);
applyBoundaryCondition(model, ...
    'neumann', 'Edge', ...
    1 : model.Geometry.NumEdges, 'g', g);

mesh = generateMesh(model, 'Hmax', 0.1);
nodes = mesh.Nodes;

result = solvepde(model);
noderesult = interpolateSolution(result, nodes(1, :), nodes(2, :));
figure;
pdeplot(model, 'XYData', result.NodalSolution);
axis equal;

for i = 1 : MAX_ITER
    prevnoderesult = noderesult;
    
    setInitialConditions(model, 0.5);

    g = @(location, state) (-interpolateSolution(result, location.x, location.y).^3);
    applyBoundaryCondition(model, ...
        'neumann', 'Edge', ...
        1 : model.Geometry.NumEdges, 'g', g);
    
    mesh = generateMesh(model, 'Hmax', 0.1);
    nodes = mesh.Nodes;
    
    result = solvepde(model);
    noderesult = interpolateSolution(result, nodes(1, :), nodes(2, :));
    figure;
    pdeplot(model, 'XYData', result.NodalSolution);
    axis equal;
    if max(abs(noderesult-prevnoderesult)) < EPS
        break;
    end
end

figure;
pdeplot(model, 'XYData', result.NodalSolution);
axis equal;

% function dl = get_geometry()
%     gd = [[1 0 0.9 1]' [1 0 -0.9 1]'];
%     sf = 'D1*D2';
%     ns = char('D1', 'D2'); ns = ns';
%     dl = decsg(gd, sf, ns);
% end

function dl = get_geometry()
    gd = [1 0 0 1]';
    sf = 'D';
    ns = 'D';
    dl = decsg(gd, sf, ns);
end

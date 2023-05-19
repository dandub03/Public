clear 
rng('default');
load("exampleMaps.mat");
map = occupancyMap(complexMap);
% map = mapClutter(30, ["Box", "Circle"],'MapSize', [100 100], 'MapResolution', 1);
planner = plannerAStarGrid(map);
% show(planner)

start = [39 3];
koniec = [17 38];

sciezka = plan(planner,start,koniec); %Y,X
skoki = diff(sciezka);
koszt = 0;
krok = 1;
idz = 1;
theta = 0;
pozycja = sciezka(krok,:); %ustawienie pozycji

%kalkulacja kosztow
for i = 1:size(skoki,1)
    koszt = koszt + norm(skoki(i,:));
end
disp(koszt)

% initialize figure and plot map and path
figure;
% show(planner);
% hold on;
% plot(sciezka(:,2), sciezka(:,1), 'r', 'LineWidth', 2);

% simulate robot movement
robotSize = 0.5; % size of the robot (square side length)
fluidTurnTime = 0.5; % time to simulate a fluid turn (in seconds)
isgoal = false;
while isgoal == false
    show(planner);
    hold on;
    plot(sciezka(:,2), sciezka(:,1), 'y', 'LineWidth', 2);
    % update position and angle
    pozycja = sciezka(krok,:);
    if idz == 1
        krok = krok + 1;
        if krok <= size(sciezka, 1)
            skok = sciezka(krok,:) - sciezka(krok-1,:);
            targetTheta = atan2(skok(1), skok(2));
            deltaTheta = targetTheta - theta;
            fluidTurnSteps = fluidTurnTime / 0.1; % divide the time into steps
            turnIncrement = deltaTheta / fluidTurnSteps;
            for step = 1:fluidTurnSteps
                theta = theta + turnIncrement;
                % plot robot position
                robotX = pozycja(2);
                robotY = pozycja(1);
                plotSquare(robotX, robotY, robotSize, theta);
                % pause to visualize the movement
                pause(0.1);
            end
        end
    end
    
    % plot robot position
    robotX = pozycja(2);
    robotY = pozycja(1);
    plotSquare(robotX, robotY, robotSize, theta);
    
    if robotX == koniec(2) && robotY == koniec(1);
        isgoal = true;
    end
    
    if idz == 0
    break
    end
    
    % pause to visualize the movement
    pause(0.1);
end

% function to plot a square representing the robot
function plotSquare(x, y, size, angle)
    R = [cos(angle) -sin(angle); sin(angle) cos(angle)]; % rotation matrix
    square = [-1 -1; -1 1; 1 1; 1 -1]; % square vertices
    transformedSquare = (square * R') * size + [x y];
    fill(transformedSquare(:,1), transformedSquare(:,2), 'b');
end

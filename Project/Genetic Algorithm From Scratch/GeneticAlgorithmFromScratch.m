clear all; close all; clc;
dir = [pwd '\Report\'];
if ~exist(dir,'dir' )
    mkdir('Report')
end
%% Initialize Parameters for Genetic Algorithm
numChromosomes = 200;           % Number of Chromosomes in every Population
numGenes = 6;                   % Number of Parameters
numGenerations = 50;            % Number of generation until termination
probCrossover = 0.8;            % Probability for crossover
probMutation = 0.8;             % Probability for mutation
probElitism = 0.01;             % Probability for elitism
FitnessFunction = @(x) FitnessFunction(x); % Fitness Function
lb = [0 0 0 0 0 0];             % Lower bounds
ub = [100 100 10 10 100 100];   % Upper bounds

%% Genetic Algorithm Initialize
population = rand(numChromosomes,numGenes).*(ub-lb)+lb; % Population
fitnessValue = zeros(size(population,1),1);             % Fitness values
for i = 1:size(population,1)
    fitnessValue(i) = FitnessFunction(population(i,:));
end
bestChromosome = zeros(numGenerations,1);               % Best chromosome
minFitnessValue = zeros(numGenerations,1);              % Its Fitness value

[bestChromosome(1),bestIdx] = min(fitnessValue);
optimalChromosome = population(bestIdx,:);
minFitnessValue(1) = FitnessFunction(optimalChromosome);

%% Genetic Algorithm
generation = 1;
f = waitbar(0,'1','Name','Please wait','CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
while generation <= numGenerations  
    waitbar(generation/numGenerations,f,sprintf(' Generation %12.0f',generation))
    prevPopulation = population;
    population = Selection(population,fitnessValue);
    population = Crossover(population,probCrossover);
    population = Mutation(population,probMutation,lb,ub);
    population = Elitism(population,prevPopulation,fitnessValue,probElitism);
    fitnessValue = zeros(size(population,1),1);
    for i = 1:size(population,1) % Calculate Fitness Value
        fitnessValue(i) = FitnessFunction(population(i,:));
    end
    [bestChromosome(generation),bestIdx] = min(fitnessValue); % Best chromosome of current Generation
    optimalChromosome = population(bestIdx,:);
    minFitnessValue(generation) = FitnessFunction(optimalChromosome);
    generation = generation + 1;    
end
delete(f); clc;
disp('Optimal Chromosome');
disp(optimalChromosome');
disp(['Fitness value: ', num2str(FitnessFunction(optimalChromosome))])

figure
plot(1:numGenerations,bestChromosome,'--o')
xlabel('Generation'); ylabel('Fitness value'); saveas(gcf,[dir 'ga_scratch.png'])

%% Check results
x = optimalChromosome;
T = 20;
yd1 = @(t) 90*pi/180 + (30*pi/180)*cos(t);
yd2 = @(t) 90*pi/180 + (30*pi/180)*sin(t);
kp1 = x(1); kp2 = x(2); ki1 = x(3); ki2 = x(4);  kd1 = x(5); kd2 = x(6);
[x,t,u] = simclosedloop(kp1,kp2,ki1,ki2,kd1,kd2,T);
x1 = x(:,1); x2 = x(:,2); x3 = x(:,3); x4 = x(:,4);
u1 = u(:,1); u2 = u(:,2);
y1 = x1; y2 = x3;
figure
plot(y1); hold on; plot(yd1(t)); legend('Plant Output','Desired Output');
title('Output y_1'); saveas(gcf,[dir 'y1_scratch.png'])
figure
plot(y2); hold on; plot(yd2(t)); legend('Plant Output','Desired Output');
title('Output y_2'); saveas(gcf,[dir 'y2_scratch.png'])
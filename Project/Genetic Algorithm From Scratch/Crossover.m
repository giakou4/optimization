function newPopulation = Crossover(population,probCrossover)
% function newPopulation = Crossover(population,probCrossover)
% CROSSOVER
%
% Inputs:
% population         : initial population
% probCrossover      : probability for crossover
%
% Outputs:
% newPopulation      : population after crossover

children = population;
counter = 1;
while counter <= size(population,1)
    prob = rand;
    if prob < probCrossover
        parents = population(randi([1,size(population,1)],2,1),:); % Choose 2 parent-chromosomes
        pos = randi([1,size(population,2)-1]); % Choose position of gene exchange randomly
        children(counter,:) = [parents(1,1:pos),parents(2,pos+1:end)];
        children(counter+1,:) = [parents(2,1:pos),parents(1,pos+1:end)];       
    end
    counter = counter + 2;   
end
idx = randperm(size(population,1)); % Shuffle
newPopulation = children(idx,:);

end
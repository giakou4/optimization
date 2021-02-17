function newPopulation = Elitism(population,prevPopulation,fitnessValue,probElitism)
% function newPopulation = Elitism(population,prevPopulation,fitnessValue,probElitism)
% ELITISM
%
% Inputs:
% population         : current population
% prevPopulation     : previous population
% fitnessValue       : values of fitness function
% probElitism        : probability for elitism
%
% Outputs:
% newPopulation      : population after elitism

newPopulation = population;
[~,idx] = sort(fitnessValue,'ascend');
for i = 1 : ceil(probElitism*size(population,1))
    newPopulation(idx(end+1-i),:)= prevPopulation(idx(i),:);
end

end
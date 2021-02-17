function newPopulation = Selection(population,fitnessValue)
% function newPopulation = Selection(population,fitnessValue)
% SELECTION
%
% Inputs:
% population         : initial population
% fitnessValue       : values of fitness function
%
% Outputs:
% newPopulation      : population after selection

newPopulation = zeros(size(population));
counter = 1;
while counter <= size(newPopulation,1)
    prob = length(fitnessValue);
    for i = 1:length(fitnessValue)
        prob(i) = sum(fitnessValue(1:i))/sum(fitnessValue);
    end
    numRand = rand;
    for i = 1 : length(fitnessValue) % Choose which chromosome survives
        if prob(i)>=numRand
            break;
        end
    end
    newPopulation(counter,:) = population(i,:);
    counter = counter + 1;    
end

end
function newPopulation = Mutation(population,probMutation,lb,ub)
% function newPopulation = Mutation(population,probMutation,lb,ub)
% MUTATION
%
% Inputs:
% population         : initial population
% probMutation       : probability for mutation
% lb                 : lower bounds for problem
% ub                 : upper bounds for problem
%
% Outputs:
% newPopulation      : population after mutation

newPopulation = population;
counter = 1;
while counter <= size(population,1)
    prob = rand;
    if prob < probMutation
        pos = randi([1,size(population,2)]); % random gene position
        newGene = rand*(ub(pos)-lb(pos))+lb(pos); % new gene
        newPopulation(counter,pos) = newGene'; % mutation
    end
    counter = counter + 1;   
end


end
%Funzione peso: data una parola binaria 
%la funzione calcola il numero di '1' 
function [ weight ] = compute_weight( s )
    weight=0;
    for x=1:numel(s)
        if(s(x)==1)
            weight = weight+1;
        end
    end
end


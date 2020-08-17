clear
clc

%Convert structure to cell array.
amino_acid = struct2cell(fastaread('amino_acid.txt'));

% A For loop, for every element of the amino_acid.txt .
for a = 1:length(amino_acid)

% Foot-and-mouth disease virus Example.      
infected_seq  = cell2mat(aa2nt(amino_acid(2,a))); 

% Exercise's Example.
% infected_seq  = ('AAATAAAGGGGCCCCCTTTTTTTCC'); 

% Initialize original_seq array, as an empty one.
original_seq   = [];

% Initialze counter 1-D array with zeros.
counter = [0 0 0 0];
% Gets the initial (first) infected sequence.
current = infected_seq (1); 
for i=2:length(infected_seq )
    % Gets foreach loop the infected sequence.
    next = infected_seq (i);
    if next ~= current 
        % If next is different from the next one.
        original_seq   = [original_seq   current];
        counter = resetCounts(next,counter);
        current = next;
    else
        % If next is equal to the next infected sequence.
        [counter,maxed,original_seq  ] = checkNext(next,counter,original_seq,current);
        if ~maxed && (i == length(infected_seq))
            original_seq   = [original_seq   current];
        end
    end   
end
end

% Display the results.
disp("Below follows the bacterial DNA sequence after being infected by the virus : ");
disp(infected_seq );
disp("Below follows the bacterial DNA sequence before being infected by the virus :");
disp(original_seq );

% Counter Function.
function countAGCT = resetCounts(next,counts) 
letters = ['A' ,'C', 'G', 'T'];
for k = 1:length(letters)
    if next == letters(k) % If match. 
       counts(k) = 1;
    else
       counts(k) = 0;
    end
end
countAGCT = [counts(1),counts(2),counts(3),counts(4)];

end

% Check next - limits function.
function [countAGCT,maxed,infected_seq] = checkNext(next,counts,infected_seq ,current)
letters = ['A' ,'C', 'G', 'T'];
for k = 1:length(letters)
    % Set multiplication limits (A: 5 + 1 C: 10 + 1 etc.).
    limits = [6, 11, inf, inf]; 
    if next == letters(k)
       counts(k) = counts(k) + 1;
       if counts(k) == limits(k) 
           % If the multiplication by the virus process has reach its limit, then 
           infected_seq  = [infected_seq  current];
           counts(k) = 0; % Set the counter to 0
           maxed = true;
       else
           maxed = false;
       end
    end
end
countAGCT = [counts(1),counts(2),counts(3),counts(4)];
end
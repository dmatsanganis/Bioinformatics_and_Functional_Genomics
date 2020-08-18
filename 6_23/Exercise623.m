clear
clc
lysozyme = fastaread('lysozyme.txt');
a_lactalbumin = fastaread('a-lactalbumin.txt');

% Program's sequences.
seq1 = lysozyme.Sequence;
seq2 = a_lactalbumin.Sequence;

% Test "Smaller" sequences.
% seq1= 'CGTATATAGCTTA';
% seq2= 'CATGTA'; 


scoring_matrix = [1 -1 -1 -1;
                 -1  1 -1 -1;
                 -1 -1  1 -1;
                 -1 -1 -1  1];

%---------------------------------------------------------
% scoring_matrix form, for each Nucleobase (A, C, G ,T): |
%                    A C G T                             | 
%                  A                                     |
%                  C                                     |
%                  G                                     |
%                  T                                     |                
%---------------------------------------------------------

% Time counter. 
tic; 
count = 0;

% Add 1 to each of the dimensions because the first block is empty.
m = strlength(seq1)+1; 
n = strlength(seq2)+1;

% Max time calculation.
max_time = ((n-1) * (m-1));

% Initialize our 2-D matrix with zeros.
F = zeros(m,n);

% Initialize empty matrix, blocks.
blocks = [];

% Initialize the first row and first column with 
% the scores based on the empty block.
for j = 0:n-1
    F(1,j+1) = -j;
end
for j = 0:m-1
    F(j+1,1) = -j;
end

% A for loop statement, which compares the top left, 
% (top and left cells of each cell) and assigns the one 
% with the maximum score of similarity.
for i = 2:m
    for j = 2:n
        match = F(i-1,j-1)+scoring_matrix(nt2int(seq1(i-1)),nt2int(seq2(j-1)));
        delete = F(i-1,j) - 1;
        insert = F(i,j-1) - 1;
        max_blocks = [match,insert,delete];
        F(i,j) = max(max_blocks);
        count = count+1;
        disp("Completed: "+count+"/"+max_time)
    end
       
end

% Time counter stops, end of matrix initialization procedure..
toc

% Finds the  sequence with the highest score. 
% New time counter starts.
tic
% Initialize 3 empty matrices.
MatrixA = []; % First sequence matrix.
MatrixB = []; % Second sequence matrix.
MatrixC = []; % Matching symbols sequence matrix (|,:).
[score,index] = max(F(:,n));
i = max(find(F(:,n)==score));
score = 0;

while (j > 1)
    
  if (i > 1 && j > 1 && (F(i,j) == F(i-1,j-1) + scoring_matrix(nt2int(seq1(i-1)),nt2int(seq2(j-1)))))
    MatrixA = [seq1(i-1) MatrixA];
    MatrixB = [seq2(j-1) MatrixB];
    if (seq1(i-1) == seq2(j-1))
        MatrixC = ['|' MatrixC];
    else
        MatrixC = [':' MatrixC];
    end
    score = score + F(i,j);
    i = i - 1;
    j = j - 1;
    
  
  elseif (j > 1 && i > 1 && ((F(i,j) == F(i-1,j) - 1)))
  
    MatrixA = [seq1(i-1) MatrixA];
    MatrixB = ['-' MatrixB];
    MatrixC = [' ' MatrixC];
    score = score + F(i,j);
    i = i - 1;
    
  
  elseif (j > 1 && ((F(i,j) == F(i,j-1) - 1)))
  
    MatrixA = ['-' MatrixA];
    MatrixB = [seq2(j-1) MatrixB];
    MatrixC = [' ' MatrixC];
    score = score + F(i,j);
    j = j - 1;
    
  end
end

% Time counter stops.
toc

while MatrixB(i) == '-'
    i = i+1;
end
 
final =[MatrixA(i:end);MatrixC(i:end);MatrixB(i:end)];
disp("The best sequence alignment is the following: ");
disp(final);
disp("With score of: "+score);

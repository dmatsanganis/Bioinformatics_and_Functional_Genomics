clear
clc

disp("1. PYGL glycogen phosphorylase L (liber.txt)");
disp("2. PYGM glycogen phosphorylase, muscle associated (muscle.txt)");
disp("3. PYGB glycogen phosphorylase B (brain.txt)");

prompt1 = "Select the first out of the 3 following Isoenzymes to implement it's sequence (ex. 3):";
isoenzyme_choice1 = input(prompt1);

% While Statement for unexpected and/or unorthodox answer.
while (isoenzyme_choice1 ~= 1 ) && (isoenzyme_choice1 ~= 2) && (isoenzyme_choice1 ~= 3)
    isoenzyme_choice1 = input(prompt1);
    % Repeat the process.
end

prompt2 = "Select the second out of the 3 following Isoenzymes to implement it's sequence (ex. 2):";
isoenzyme_choice2 = input(prompt2);

% While Statement for unexpected and/or unorthodox answer.
while (isoenzyme_choice2 ~= 1 ) && (isoenzyme_choice2 ~= 2) && (isoenzyme_choice2 ~= 3) 
    isoenzyme_choice2 = input(prompt2);
    % Repeat the process.
end

% While Statement matching-answers error.
while (isoenzyme_choice1 == isoenzyme_choice2)
    isoenzyme_choice1 = input(prompt1); 
    isoenzyme_choice2 = input(prompt2);
    % Repeat the process.
end

% Isoenzymes Texts Initialization Properly(Read FASTA Files).
% For the first Isoenzyme.
if (isoenzyme_choice1 == 1) 
    nucleo1 = fastaread('liver.txt');
elseif (isoenzyme_choice1 == 2)
    nucleo1 = fastaread('muscle.txt');   
elseif (isoenzyme_choice1 == 3)
    nucleo1 = fastaread('brain.txt');      
end
  
% And for the second Isoenzyme (must be different from the first one).
if (isoenzyme_choice2 == 1)
    nucleo2 = fastaread('liver.txt');
elseif (isoenzyme_choice2 == 2)
    nucleo2 = fastaread('muscle.txt'); 
else
    nucleo2 = fastaread('brain.txt');    
end

% Get FASTA selected files sequences.
seq1 = nucleo1.Sequence; 
seq2 = nucleo2.Sequence;

% Get their's length.
n = strlength(seq1);
m = strlength(seq2);

disp("Game starts with /n Player 1 (Random Player) and Player 2 (Tactic Player)");
prompt3 = "Please select who plays first, please type the player number (1/2): ";
player_choice = input(prompt3);

% While Statement for unexpected and/or unorthodox answer.
while (player_choice ~= 1 ) && (player_choice ~= 2)
    player_choice = input(prompt3);
    % Repeat the process.
end

disp("Initial sequences : " +newline+ seq1 +newline+ seq2+newline);

% While loop statement, fpr each of the Players moves.
while (m~=0) && (n~=0)
    if player_choice == 1
        disp("Player 1 made a move");
        [seq1,seq2] = Player1(seq1,seq2,m,n);
        disp("New sequences: "+newline+ seq1 +newline+ seq2 +newline);
        player_choice = 2;
    else
        disp("Player 2 made a move");
        [seq1,seq2] = Player2(seq1,seq2,m,n);
        disp("New sequences: "+newline+ seq1 +newline+ seq2+newline);
        player_choice = 1;
    end
    m = strlength(seq1);
    n = strlength(seq2);
end

% Last move, winner, if statement.
if player_choice == 1
    disp("Player 2 made the last move and won the game!");
elseif player_choice ==2 
    disp("Player 1 made the last move and won the game!");
end

% move1 subtracts nucleotides from one sequence 
% move2 subtracts nucleotides from both sequences

% Player1 "playbook" (random playstyle).
function [new_seq1,new_seq2] = Player1(seq1,seq2,m,n)
    if m == n                   % Win by subtract nucleotides from both sequences(Move2). 
        for i = 1:m    
            seq1 = seq1(2:end); 
            seq2 = seq2(2:end);
        end
    elseif n == 0               % n is row. 
        for i = 1 :n            % If row is zero.
            seq2 = seq2(2:end); % Win by subtract nucleotides from one sequence(Move1). 
        end
    elseif m == 0               % m is column. 
        for i = 1 :m            % If row is zero.
            seq1 = seq1(2:end); % Win by subtract nucleotides from one sequence(Move1).
        end
    else
        c = randi([1 3],1);     % Random choose of movement.
        if c == 1               % Move2.
            num = randi([1 min(m,n)],1); %Random number of nucleotides. 
            for i = 1:num         
                seq1 = seq1(2:end);  % Will be deleted.
                seq2 = seq2(2:end);
            end
        elseif c == 2               % Move1.
            num = randi([1 m],1);   % Random number of nucleotides. 
            for i = 1:num           % Will be deleted
                seq1 = seq1(2:end);
            end
        else                        % Random number of nucleotides will be deleted
            num = randi([1 n],1);
            for i = 1:num
                seq1 = seq2(2:end);
            end
        end
    end
    
new_seq1 = seq1;
new_seq2 = seq2;
end

% Player2 "playbook" (tactical playstyle).
function [new_seq1,new_seq2] = Player2(seq1,seq2,m,n)
    if m == n                   % Win by subtract nucleotides from both sequences(Move2). 
        for i = 1:m    
            seq1 = seq1(2:end); 
            seq2 = seq2(2:end);
        end
    elseif n == 0               % n is row. 
        for i = 1 :n            % If row is zero.
            seq2 = seq2(2:end); % Win by subtract nucleotides from one sequence(Move1). 
        end
    elseif m == 0               % m is column. 
        for i = 1 :m            % If row is zero.
            seq1 = seq1(2:end); % Win by subtract nucleotides from one sequence(Move1).
        end
    else
        c = randi([1 3],1);     % Random choose of movement.
        if c == 1               % Move2.
            num = randi([1 min(m,n)],1); %Random number of nucleotides. 
            for i = 1:num         
                seq1 = seq1(2:end);  % Will be deleted.
                seq2 = seq2(2:end);
            end
        elseif c == 2               % Move1.
            num = randi([1 m],1);   % Random number of nucleotides. 
            for i = 1:num           % Will be deleted
                seq1 = seq1(2:end);
            end
        else                        % Tactical Play: Not winning position. Drive opponent to losing position if it's possible.
            if(losePosi(m-1,n))     % check for the "bad - losing" position (row-1, column).
                seq1 = seq1(2:end);
            elseif(losePosi(m,n-1)) % check for the "bad - losing" position (row, column-1).
                seq2 = seq2(2:end);
            else                    % Else, execute Move2.
                seq1 = seq1(2:end);
                seq2 = seq2(2:end);
            end
        end
    end
    
new_seq1 = seq1;
new_seq2 = seq2;
end

%A Function, which checks if the position(m,n) is a losing position based
%on the tactic (used by the Player 2 playstyle).
function losing_position = losePosi(m,n) 
    if m == n
        losing_position = 0;
    elseif m ==0 && n>0
        losing_position = 0;
    elseif n == 0 && m >0
        losing_position = 0;
    else
        losing_position = 1;
    end
end
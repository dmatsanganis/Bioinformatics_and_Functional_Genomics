clear 
clc

    A = [0.9 0.1; 0.1 0.9];  
    % Transition Matrix, A.
    
    B = [0.4 0.1 0.4 0.1; 0.2 0.3 0.2 0.3;]';
    % Emission Matrix, B.
    
    states = ['a','b'] ;
    % State Space (state a or state b).
    
    prob_init = [0.5; 0.5];
    % Initial Probabilities (50% - 50%).

    x = nt2int('GGCT');
    % State's Sequence path to numbers, via library.
    
    %Help-purposes Matrixes.
    N = size(A,1);
    T = length(x);
    C = zeros(N,T);
    pred = size(N,T);
    
    % Log the data.
    prob_init = log2(prob_init);
    A = log2(A);
    B = log2(B);
    
    for i=1:N
        C(i,1) = prob_init(i);  
        % Loop for Log-probabilities calculation,first column of matrix C.
    end
    
    vp = zeros(T,N,2);
    % 2D - Zero Matrix.
    
    % For - Loop statement for the 4 elements of the state's sequence.
    for t = 1:T 
        for i = 1:N % For - Loop statement for the 2 States (a or b).
            v = zeros(1,N); % Zero Matrix.
            for p = 1:N % A For - Loop which is executed twice.
                v(p)= C(p,t)+A(p,i)+B(x(t),p);
                vp(t,p,i) = v(p);      
            end
            [C(i,t+1),index] = max(v);
            pred(i,t) = index;
        end
    end
      
    % Viterbi Score Calculation.
    [maximum,index] = max((C(:,T+1)));
    best_path = [index];  % Finds Best path.
    
    % Display properly Trellis' Diagram.
    C = C(:,2:end); 
    disp("Trellis' Diagram:")
    disp("State b: ")
    disp(C(2,:))
    disp("State a: ")
    disp(C(1,:))
    
    % A While - Loop Statement, for finding the best path.
    while T~=0
        [~,index] = max(vp(T,:,index));
        best_path = [index best_path];
        T = T-1;
        if T == 0
            break
        end
    end
   
disp("Best score for the sequence 'GGCT' is: "+maximum) % Display the best score.
final = '';

% A For - Loop, which calculates the best path of the current problem.
for i=1:size(x,2)
    final = [final  states(best_path(i))];
end
disp("Best path for the sequence 'GGCT' is: "+final) % Display the best path.

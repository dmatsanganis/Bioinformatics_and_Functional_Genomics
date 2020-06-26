function [maximum,best_path] = viterbi(prob_init,A,B,x)

    N = size(A,1);
    T = length(x);
    C = zeros(N,T);
    pred = size(N,T);
    prob_init = log2(prob_init);
    A = log2(A);
    B = log2(B);
    
    for i=1:N
        C(i,1) = prob_init(i);  %1h sthlh logarithmimeni.
    end
    
    vp = zeros(T,N,2); %2D zeros
    for t = 1:T %4 loops, 4 stoixeia 
        for i = 1:N %2 katastaseis 2 loop
            v = zeros(1,N); %[0,0]
            for p = 1:N %2loops
                v(p)= C(p,t)+A(p,i)+B(x(t),p);
                vp(t,p,i) = v(p);      
            end
            [C(i,t+1),index] = max(v);
            pred(i,t) = index;
        end
    end
      
    %viterbi score
    [maximum,index] = max((C(:,T+1)));
    best_path = [index];
    C
    while T~=0
        [~,index] = max(vp(T,:,index));
        best_path = [index best_path];
        T = T-1;
        if T == 0
            break
        end
    end
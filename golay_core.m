%Cuore dell'algoritmo:
%presa una parola c, viene effettuata la codifica nel codice
%successivamente viene inserito un errore random (da 1 a 3)
%e viene provata la correzione e la decodifica.

function [ result ] = golay_core( c )
B =[1 1 0 1 1 1 0 0 0 1 0 1
    1 0 1 1 1 0 0 0 1 0 1 1
    0 1 1 1 0 0 0 1 0 1 1 1
    1 1 1 0 0 0 1 0 1 1 0 1
    1 1 0 0 0 1 0 1 1 0 1 1
    1 0 0 0 1 0 1 1 0 1 1 1
    0 0 0 1 0 1 1 0 1 1 1 1
    0 0 1 0 1 1 0 1 1 1 0 1
    0 1 0 1 1 0 1 1 1 0 0 1
    1 0 1 1 0 1 1 1 0 0 0 1
    0 1 1 0 1 1 1 0 0 0 1 1
    1 1 1 1 1 1 1 1 1 1 1 0];

    %disp('B = ');
    %disp(B);

    I12 = eye(12);
    %disp('I12 = ');
    %disp(I12);

    G = [I12 B];
    %disp('G = ');
    %disp(G);

    H = [I12 
        B];
    %disp('H = ');
    %disp(H);

    distance = 8;
    %disp('distance');
    %disp(distance);

    word = de2bi(double(c),12);
    %disp('word = ')
    %disp(word);

    sent = mod(double(word)*double(G),2);
    disp('Parola inviata = ');
    disp(sent);

    %randomic error
    received = sent;
    j = randi([1,3]);
    i = randi([1,24],1,j);

    
    for x=1:numel(i)
        received(i(x)) = mod(received(i(x))+1,2);
    end
    disp('Parola ricevuta: ');
    disp(received);

    s = mod(received*H,2);
    %disp('s1= ');
    %disp(s);
    u=zeros(1,24);
    weight = compute_weight(s);
    found = 0;
    
    if(weight<=3)
        u = [s 0 0 0 0 0 0 0 0 0 0 0 0];
        found=1;
    else
    for x=1:12
        sum = mod(B(x,:)+s,2);
        weight = compute_weight(sum);
        if(weight<=2)
           u=[sum I12(x,:)];
           found = 1;
           break;
        end
    end
    end

    s = mod(s*B,2);
    weight = compute_weight(s);
    %disp(s);
    if (found == 0)
        if(weight<=3)
        u = [0 0 0 0 0 0 0 0 0 0 0 0 s];
        else
        for x=1:12
            sum = mod(B(x,:)+s,2);
            weight = compute_weight(s);
            if(weight<=2)
                u=[I12(x,:) sum];
                break;
            end
        end
        end
    end

    disp('Pattern d''errore: ')
    disp(u);
    correction = mod(u+received,2);
    disp('La parola corretta è: ')
    disp(correction);
    disp('Decodicficata con ');
    result = char(bi2de(correction(1,1:12)))

end


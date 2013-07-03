
str = input('Inserisci la parola da inviare: ','s')
res = zeros(1,numel(str));
for x=1:numel(str)
    res(x) = golay_core(str(x));
end

disp('La parola inviata e'' stata ricevuta e provata a correggere con: ');
disp(char(res));



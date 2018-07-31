function print_intro_to_term(header)

    fprintf('\n\n*******************************************\n');
    fprintf('***** ');  fprintf(header); fprintf(' *****');
    fprintf('\n*******************************************\n\n');

    format shortg;
    c = clock;
    fix(c);
    
    year =  c(1);
    month = c(2);
    day =   c(3);
    hh =    c(4);
    mm =    c(5);
     
    fprintf('%d/%d/%d   %d:%d\n', month, day, year, hh, mm);
    fprintf('\n-------------------------------------------\n\n');
    
    
end
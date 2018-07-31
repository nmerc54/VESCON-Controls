function saveWorkspace()
    
    format shortg;
    c = clock;
    fix(c);
    
    year =  c(1);
    month = c(2);
    day =   c(3);
    hh =    c(4);
    mm =    c(5);
    
    filename = sprintf('rascalmagnetics_workspace_%d-%d-%d_%d-%d\n', month, day, year, hh, mm);

    save(filename);
    
end
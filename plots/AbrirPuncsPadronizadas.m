%Abre todos os arquivos nas pastas especificadas, separando em
%especialistas e n�o especialistas, para as pun��es 


pastaesp = 'C:\Users\samsung\Desktop\IC\Dados\Pun��es Bauru\Especialistas';
pastanesp = 'C:\Users\samsung\Desktop\IC\Dados\Pun��es Bauru\N�o Especialistas';
mat = dir(pastaesp); 

for q = 3:length(mat) 
    if (q == 3)
        dadosesp = dlmread(strcat(pastaesp,'\', mat(q).name)); 
    else
        dadosesp = cat(3, dadosesp, dlmread(strcat(pastaesp,'\', mat(q).name)));
    end
    
end

mat = dir(pastanesp); 

for q = 3:length(mat) 
    if (q == 3)
        dadosnesp = dlmread(strcat(pastanesp,'\', mat(q).name)); 
    else
        dadosnesp = cat(3, dadosnesp, dlmread(strcat(pastanesp,'\', mat(q).name)));
    end
    
end

clear mat q pastaesp pastanesp unir;
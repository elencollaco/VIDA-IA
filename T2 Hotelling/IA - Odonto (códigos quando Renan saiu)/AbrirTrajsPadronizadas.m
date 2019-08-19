%Abre todos os arquivos nas pastas especificadas, separando em
%especialistas e não especialistas, para as trajetórias 


pastaesp = 'C:\Users\samsung\Desktop\IC\Dados\Trajetorias Bauru\Alunos';
%pastanesp = 'C:\Users\samsung\Desktop\IC\Dados\Trajetorias Bauru\Não Especialistas';
mat = dir(pastaesp); 
%str2num(mat(3).name(7:8))

for q = 3:length(mat) 
    dados(q - 2).dados = dlmread(strcat(pastaesp,'\', mat(q).name)); 
    dados(q - 2).nome = str2num(mat(q).name(7:8));
    
end

%mat = dir(pastanesp);

%for q = 3:length(mat) 
%    if (q == 3)
%        dadosnesp = dlmread(strcat(pastanesp,'\', mat(q).name)); 
%    else
 %       dadosnesp = cat(3, dadosnesp, dlmread(strcat(pastanesp,'\', mat(q).name)));
%    end
    
%end

clear mat q pastaesp pastanesp unir;

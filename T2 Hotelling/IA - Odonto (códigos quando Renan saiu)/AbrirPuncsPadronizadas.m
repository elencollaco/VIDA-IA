%Abre todos os arquivos nas pastas especificadas, separando em
%especialistas e não especialistas, para as punções 


pastaProf = 'C:\Users\samsung\Desktop\IC\Dados\Punções Bauru\Professores';
pastaAl1 = 'C:\Users\samsung\Desktop\IC\Dados\Punções Bauru\Alunos1';
pastaAlG = 'C:\Users\samsung\Desktop\IC\Dados\Punções Bauru\AlunosDemais';

mat = dir(pastaProf); 
%str2num(mat(3).name(7:8))

for q = 3:length(mat) 
    dadosProf(q - 2).dados = dlmread(strcat(pastaProf,'\', mat(q).name)); 
    dadosProf(q - 2).nome = mat(q).name(7:8);    
end

mat = dir(pastaAl1); 
%str2num(mat(3).name(7:8))

for q = 3:length(mat) 
    dados1(q - 2).dados = dlmread(strcat(pastaAl1,'\', mat(q).name)); 
    dados1(q - 2).nome = mat(q).name(7:8);
end

mat = dir(pastaAlG); 
%str2num(mat(3).name(7:8))

for q = 3:length(mat) 
    dadosG(q - 2).dados = dlmread(strcat(pastaAlG,'\', mat(q).name)); 
    dadosG(q - 2).nome = mat(q).name(7:8);
end

clear mat q pastaAl1 pastaAlG pastaProf unir;
use sprint3;
-- listar os alunos, seu curso, quais materias ele cursa e suas notas
create view vw_nota
as
select a.nome nome_aluno, a.ra, c.curso, s.descricao sprint, 
       av.descricao avaliacao, m.nome materia, n.nota
from nota n
inner join aluno a on a.id = n.fkaluno
inner join materia m on m.id = n.fkmateria
inner join curso c on c.id = n.fkcurso
inner join sprint s on s.id = n.fksprint
inner join avaliacao av on av.id = n.fkavaliacao;

-- calcular a nota media dos alunos em cada uma das materias e das sprints
select nome_aluno, ra, sprint, materia, avg(nota) nota 
from vw_nota
group by nome_aluno, ra, sprint, materia
order by 1, sprint, materia;

-- calcular a nota media dos alunos em cada uma das materias 
--  no semestre e informar quem foi aprovado ou reprovado, abaixo de 6
select nome_aluno, ra, curso, materia, avg(nota) nota,
       case when avg(nota) >= 6 then 'APROVADO'
            else 'REPROVADO' end situacao
from vw_nota
group by nome_aluno, ra, curso, materia
order by 1, materia;

-- identificar o aluno q conseguiu nota media acima da media geral
select nome_aluno, ra, avg(nota) nota
from vw_nota
group by nome_aluno, ra
having avg(nota) >= (select avg(nota) from vw_nota);

-- listar aluno, curso, materia e avaliações que estajam 
-- acima da media geral
select nome_aluno, ra, curso, sprint, materia, avaliacao, nota
from vw_nota
where nota < (select avg(nota) from vw_nota);







-- identificar o aluno q conseguiu nota media de cada curso
select nome_aluno, med.nota
from (select nome_aluno, curso, round(avg(nota),1) nota 
      from vw_nota group by nome_aluno, curso) as vw
inner join (select curso, round(avg(nota),1) nota
            from vw_nota group by curso) as med
on med.curso = vw.curso and med.nota = vw.nota;









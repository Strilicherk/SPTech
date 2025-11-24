-- exibir os dados dos alunos e dos cursos correspondentes
select a.*, c.*
from aluno as a
inner join aluno_curso ca on ca.fkaluno = a.ra
inner join curso as c on c.id = ca.fkcurso;

-- exibir os dados dos alunos, mas somente de um curso
select a.*, c.*
from aluno as a
inner join aluno_curso ca on ca.fkaluno = a.ra
inner join curso as c on c.id = ca.fkcurso
where c.nome = 'ADS';

-- exibir os dados de um aluno e os dados dos cursos deste aluno
select a.*, c.*
from aluno as a
inner join aluno_curso ca on ca.fkaluno = a.ra
inner join curso as c on c.id = ca.fkcurso
where a.nome = 'RODRIGO';

-- exibir a soma das medias e a media das medias
select sum(media) soma_media,
       avg(media) media_da_media
from aluno_curso;

-- exibir a maior e a menor media
select max(media) maior_media,
       min(media) menor_media
from aluno_curso;

-- exibir a maior e a menor media agrupada por curso
select c.nome,
       max(media) maior_media,
       min(media) menor_media
from aluno_curso ac
inner join curso c on c.id = ac.fkcurso
group by c.nome;
 
-- exibir a maior e a menor media agrupada por aluno
select a.nome,
       max(media) maior_media,
       min(media) menor_media
from aluno_curso ac
inner join aluno a on a.ra = ac.fkaluno
group by a.nome;

-- exibir apenas as medias da tabela aluno curso
select media
from aluno_curso;

-- exibir as medias distintas da tabela aluno curso
select distinct media
from aluno_curso;

-- exibir a quantidade de medias tabela aluno curso
select count(media)
from aluno_curso;

-- exibir a quantidade de medias distintas da tabela aluno curso
select count(distinct media)
from aluno_curso;
 

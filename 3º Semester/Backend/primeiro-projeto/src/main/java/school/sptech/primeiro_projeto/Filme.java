package school.sptech.primeiro_projeto;

public class Filme {
    private String nome;
    private String diretor;
    private Integer ano;

    public Filme(String nome, String diretor, Integer ano) {
        this.nome = nome;
        this.diretor = diretor;
        this.ano = ano;
    }

    public Filme() {
    }

    public String getNome() {
        return nome;
    }

    public String getDiretor() {
        return diretor;
    }

    public Integer getAno() {
        return ano;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setDiretor(String diretor) {
        this.diretor = diretor;
    }

    public void setAno(Integer ano) {
        this.ano = ano;
    }

    @Override
    public String toString() {
        return "Filme{" +
                "nome='" + nome + '\'' +
                ", diretor='" + diretor + '\'' +
                ", ano=" + ano +
                '}';
    }
}

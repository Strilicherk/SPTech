package school.sptech.primeiro_projeto;

import org.springframework.web.bind.annotation.*;

import java.awt.image.FilteredImageSource;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/filmes")
public class FilmeController {
    private List<Filme> filmes;

    public FilmeController() {
        filmes = new ArrayList<>();
        filmes.add(new Filme("Omiranha", "Eu", 1933));
        filmes.add(new Filme("Bastardos Inglórios", "Tu", 1945));
        filmes.add(new Filme("Hulk", "Nois", 1999));
    }

    @GetMapping()
    public List<Filme> getAll() {
        return filmes;
    }

    @GetMapping("/{id}")
    public Filme getById(@PathVariable Integer id) {
        return filmes.get(id);
    }

//    @PostMapping("/cadastrar")
//    public List<Filme> postFilme(@RequestBody Filme filme) {
//        if (filme.getNome() == null || filme.getNome().isBlank()) {
//            throw new RuntimeException();
//        }
//        filmes.add(filme);
//        return filmes;
//    }

    @PostMapping("/cadastrar")
    public String postFilme(@RequestBody Filme filme) {
        if (filme.getNome() == null || filme.getNome().isBlank()) {
            return "Erro: nome inválido";
        }
        filmes.add(filme);
        return "Sucesso";
    }

}

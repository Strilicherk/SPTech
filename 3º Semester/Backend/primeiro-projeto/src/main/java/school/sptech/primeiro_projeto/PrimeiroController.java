package school.sptech.primeiro_projeto;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

// Controller -> Classe que responde as reqs HTTP
@RestController
public class PrimeiroController {
    @GetMapping
    public String frase() {
        return "Hello World";
    }

    @GetMapping("/frases")
    public String frase2() {
        return "Bom dia";
    }

    @GetMapping("/frases/{nome}")
    public String frase2(@PathVariable String nome) {
        return "Bom dia, " + nome ;
    }


}

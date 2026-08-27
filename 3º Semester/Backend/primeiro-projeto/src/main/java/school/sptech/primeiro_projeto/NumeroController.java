package school.sptech.primeiro_projeto;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/numeros")
public class NumeroController {
    private int contador;

    @GetMapping("/contar")
    public Integer contar() {
        return ++contador;
    }

    @GetMapping("/somar/{numero1}/{numero2}")
    public Integer somar(@PathVariable int numero1, @PathVariable int numero2) {
        return numero1+numero2;
    }

    @GetMapping("/subtrair/{numero1}/{numero2}")
    public Integer subtrair(@PathVariable int numero1, @PathVariable int numero2) {
        return numero1-numero2;
    }

    @GetMapping("/multiplicar/{numero1}/{numero2}")
    public Integer multiplicar(@PathVariable int numero1, @PathVariable int numero2) {
        return numero1*numero2;
    }

    @GetMapping("/dividir/{numero1}/{numero2}")
    public Integer dividir(@PathVariable int numero1, @PathVariable int numero2) {
        return numero1/numero2;
    }

    @GetMapping("/somar-todos/{numeros}")
    public Integer somar(@PathVariable int[] numeros) {
        Integer resultado = 0;
        for (int i = 0; i < numeros.length; i++) {
            resultado += numeros[i];
        }
        return resultado;
    }

    @GetMapping("/single/{nums}")
    public Integer duplicado(@PathVariable Integer[] nums) {
        Integer numero = 0;
        for (int i = 0; i < nums.length; i++) {
            if (i < nums.length -1) {
                for (int i1 = i++; i1 < nums.length; i1++) {
                    if (nums[i].equals(nums[i1])) {
                        break;
                    } else {
                        numero = nums[i];
                    }
                }
            }
        }

        return numero;
    }
}

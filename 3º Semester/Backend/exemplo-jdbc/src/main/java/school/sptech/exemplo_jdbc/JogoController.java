package school.sptech.exemplo_jdbc;

import org.apache.coyote.Response;
import org.jspecify.annotations.Nullable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.web.bind.annotation.*;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/jogos")
public class JogoController {

    private final JdbcTemplate jdbcTemplate;

    public JogoController(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private ResponseEntity<Void> ValidaExistencia(Integer id) {
        String sqlId = "SELECT COUNT(*) FROM jogo WHERE id = ?";
        Integer idExiste = jdbcTemplate.queryForObject(sqlId, Integer.class, id);

        if (idExiste == null || idExiste == 0) {
            return ResponseEntity.status(404).build();
        }
        return null;
    }

    @GetMapping()
    public ResponseEntity<List<Jogo>> GetAllJogos() {
        String sql = "SELECT * FROM jogo;";
        List<Jogo> jogos = jdbcTemplate.query(sql,
                new BeanPropertyRowMapper<>(Jogo.class));
        return ResponseEntity.status(200).body(jogos);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Jogo> GetJogoById(@PathVariable Integer id) {
        String sql = "SELECT * FROM JOGO WHERE id = ?";
        try {
            Jogo jogo = jdbcTemplate.queryForObject(
                    sql,
                    new BeanPropertyRowMapper<>(Jogo.class),
                    id);
            return ResponseEntity.status(200).body(jogo);
        } catch (EmptyResultDataAccessException e) {
            return ResponseEntity.status(404).build();
        }
    }

    @PostMapping()
    public ResponseEntity<Jogo> PostJogo(@RequestBody Jogo jogo) {
        if (jogo.getNome() == null || jogo.getNome().isBlank()) {
            return ResponseEntity.status(400).build();
        }

        String sql = "INSERT INTO JOGO(nome, genero) VALUES (?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update( con -> {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, jogo.getNome());
            ps.setString(2, jogo.getGenero());
            return ps;
        }, keyHolder);

        jogo.setId(keyHolder.getKeyAs(Integer.class));
        return ResponseEntity.status(201).body(jogo);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> DeleteJogoById(@PathVariable Integer id) {
        ResponseEntity<Void> build = ValidaExistencia(id);
        if (build != null) return build;

        String sql = "DELETE FROM jogo WHERE id = ?";
        jdbcTemplate.update(sql, id);
        return ResponseEntity.status(204).build();
    }

    @PutMapping("/{id}")
    public ResponseEntity<Jogo> PutJogoById(@PathVariable Integer id, @RequestBody Jogo jogo) {
        ResponseEntity<Void> existe = ValidaExistencia(id);
        if (existe != null)
    }

    @PatchMapping("/{id}")
    public ResponseEntity<Jogo> PatchJogoById(@PathVariable Integer id, @RequestBody Jogo jogo) {
        ResponseEntity<Void> existe = ValidaExistencia(id);
    }

}

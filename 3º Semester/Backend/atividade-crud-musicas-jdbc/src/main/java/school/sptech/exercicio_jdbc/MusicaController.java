package school.sptech.exercicio_jdbc;

import org.apache.coyote.Response;
import org.jspecify.annotations.NonNull;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.web.bind.annotation.*;

import java.sql.PreparedStatement;
import java.util.List;

@RequestMapping("/musicas")
@RestController
public class MusicaController {
    private final JdbcTemplate jdbcTemplate;

    public MusicaController(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public Boolean ValidarExistenciaMusicaPorId(Integer id) {
        String sql = "SELECT COUNT(*) FROM Musica WHERE id = ?;";
        Integer existe = jdbcTemplate.queryForObject(
                sql,
                Integer.class,
                id
        );
        return existe != null && existe != 0;
    }

    private Boolean ValidaExistenciaMusicaPorNomeArtista(String nome, String artista) {
        String sql = "SELECT * FROM Musica WHERE nome = ? AND artista = ?;";
        Musica existe = jdbcTemplate.queryForObject(
                sql,
                Musica.class,
                nome,
                artista
        );

        return existe != null;
    }

    @GetMapping()
    public ResponseEntity<List<Musica>> GetAllMusicas() {
        String sql = "SELECT * FROM Musica;";
        List<Musica> musicas = jdbcTemplate.query(
                sql,
                new BeanPropertyRowMapper<>(Musica.class)
        );

        return ResponseEntity.status(200).body(musicas);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Musica> GetMusicaById(@PathVariable Integer id) {
        String sql = "SELECT * FROM Musica WHERE id = ?;";
        Musica musica = jdbcTemplate.queryForObject(
                sql,
                Musica.class,
                id
        );

        if (musica == null) return ResponseEntity.status(404).build();

        return ResponseEntity.status(200).body(musica);
    }

    @PostMapping()
    public ResponseEntity<Musica> PostMusica(@RequestBody Musica musica) {
        if (
            musica.getNome() == null || musica.getNome().isBlank() ||
            musica.getArtista() == null || musica.getArtista().isBlank() ||
            musica.getAlbum() == null || musica.getAlbum().isBlank() ||
            musica.getDuracao() < 0
        ) return ResponseEntity.status(400).build();

        if (!ValidaExistenciaMusicaPorNomeArtista(musica.getNome(), musica.getArtista())) {
            String sql = "INSERT INTO Musica(nome, artista, album, duracao) VALUES (?, ?, ?, ?);";

            KeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(con -> {
                PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
                ps.setString(1, musica.getNome());
                ps.setString(2, musica.getArtista());
                ps.setString(3, musica.getAlbum());
                ps.setInt(4, musica.getDuracao());
                return ps;
            }, keyHolder);

            musica.setId(keyHolder.getKeyAs(Integer.class));
            return ResponseEntity.status(201).body(musica);
        } else {
            return ResponseEntity.status(409).build();
        }
    }

//    @PutMapping("/{id}")
//    public ResponseEntity<Musica> PutMusica(@RequestBody Musica musica, @PathVariable Integer id) {
//
//    }
//
//    @DeleteMapping("/{id}")
//    public ResponseEntity<Musica> DeleteMusica(@PathVariable Integer id) {
//
//    }
}

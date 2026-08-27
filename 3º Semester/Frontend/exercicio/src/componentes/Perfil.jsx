import { useState } from "react"; // importando o useState

function Perfil(props) {
    const [contador, setContador] = useState(0);

    function Incrementar() {
        setContador(contador + 1)
    }

    return (
        <div>
            <h2>{props.nome}</h2>
            <p>{props.profissao}</p>
            <p>Curtidas: {contador}</p>
            <button onClick={Incrementar}>Clique aqui para curtir!</button>
        </div>
    )
}

export default Perfil;
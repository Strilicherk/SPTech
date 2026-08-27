import styles from './App.module.css';
import Perfil from "./componentes/Perfil";

function App() {
  return (
    <div className={styles.container}>
      <Perfil nome="Matheus" profissao="Desenvolvedor"/>
    </div>
  )
}

export default App;
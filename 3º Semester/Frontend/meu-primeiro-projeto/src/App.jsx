import Componente from "./componentes/Componente";
import Card from "./componentes/Card";
import styles from './App.module.css';

function App() {
  return (
    <div className={styles.container}>
      <Card titulo='titulo' paragrafo='pagrafaro' />
      <Card titulo='tutilo' paragrafo='grafaro' />
      <Card titulo='titulo2' paragrafo='dois'>
        <h2>fih</h2>
      </Card>
    </div>
  )
}

export default App;
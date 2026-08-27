import { useState } from 'react'
import heroImg from './assets/hero.png'
import reactLogo from './assets/react.svg'
import viteLogo from './assets/vite.svg'
import './App.css'
import Card from './componentes/Card'

function App() {
  const [count, setCount] = useState(0)

  return (
    <div>
      <p>Olá Mundo!</p>
      <Card />
    </div>
  )
}

export default App

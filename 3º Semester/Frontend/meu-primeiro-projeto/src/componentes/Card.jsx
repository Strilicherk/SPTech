import styles from './Card.module.css'

function Card(props) {
    console.log('props: ', props)
    return (
        <div className={styles.container}>
            <h1>{props.titulo}</h1>
            <p>{props.paragrafo}</p>
            <div>
                {props.children}
            </div>
        </div>
    )
}

export default Card;
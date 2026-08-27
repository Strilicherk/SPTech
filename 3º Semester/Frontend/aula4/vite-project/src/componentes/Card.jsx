function Card({titulo, paragrafo, children}) {
    return (
        <div>
            <h1>{titulo}</h1>
            <p>{paragrafo}</p>
            <>
                {children}
            </>
        </div>
    )
}

export default Card;
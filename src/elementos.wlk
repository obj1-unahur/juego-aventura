import wollok.game.*
import nivel_llaves.*

class Bloque {
	var property position
	const property image = "market.png" 	
	
	method esBloque() { return true }
}

object noBloque {
	method esBloque() { return false }
}

class Llave {
	var property position
	const property image = "llave.png" 	

	method teEncontroElBuscador() {
		nivelLlaves.recogerLlave(self)
	}	
}

class Comida {
	var property position
	const property image = "comida.png"
	var property energia = 10 	

	method teEncontroElBuscador() {
		nivelLlaves.recogerComida(self)
	}	
}

object puertaNivel1 {
	const property position = game.at(7,10)
	const property image = "puertaGris.png" 
	method esBloque() { return false }
}

object puertaNivel2 {
	const property position = game.at(7,10)
	const property image = "puertaGris.png" 

	method teEncontroElBuscador() {	
		nivelLlaves.ganar()
	}	
}
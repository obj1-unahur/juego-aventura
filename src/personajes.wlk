import wollok.game.*
import elementos.*
import juego_aventura.*
import nivel_llaves.*


object empujadorBloques {
	var property position
	const property image = "player.png"	
	var bloque = noBloque
	var i = 0
	
	method esBloque() { return false }
	
	method moverseEnDireccion(direccion) {
		const destino = direccion.siguientePosicion(self.position())
		self.position(destino)
		if (bloque.esBloque()) {
			bloque.position(destino)
		}
//		self.controlarPasoPorPuerta()
	}

	method agarrarBloque() {
		if (bloque.esBloque()) {
			game.errorReporter(self)
			self.error("Ya tengo un bloque")
		}
		const losBloques = game.colliders(self).filter({ obj => obj.esBloque() })
		if (losBloques.isEmpty()) {
			self.error("No hay bloque para agarrar")
		}
		bloque = losBloques.first()
	}
	
	method soltarBloque() {
		if (not bloque.esBloque()) {
			game.errorReporter(self)
			self.error("No hay bloque para soltar")
		}
		bloque = noBloque
	}
	
	method controlarPasoPorPuerta() {
		if (game.colliders(self).contains(puertaNivel1)) {
			self.pasastePorPuertaNivel1()
		}
	}
	
	method pasastePorPuertaNivel1() { 
		if (nivelBloques.bloquesListos()) {
			nivelBloques.terminar()
		} else {
			i = i + 1
			game.say(self, "Falta ubicar bloques - " + i)
		}
	}
	
}


object buscadorDeLlaves {
	var property position = game.at(5,5)
	const property image = "player.png"	
	var property energia = 40

	method moverseEnDireccion(direccion) {
		const destino = direccion.siguientePosicion(self.position())
		self.position(destino)
//		if (game.colliders(self).contains(puertaNivel2)) {
//			if (nivelLlaves.encontroTodasLasLlaves()) {
//				nivelLlaves.ganar()
//			}
//		}
//		game.colliders(self).filter({ obj => obj.esLlave() })
//			.forEach({ llave => nivelLlaves.recogerLlave(llave) })
		energia = energia - 1
		if (energia == 10 or energia == 5) {
			game.say(self, "me quedan " + energia + " unidades de energía")
		}
		if (energia == 0) {
			nivelLlaves.perder()
		}
	}
	
	method aumentarEnergia(cuanto) {
		energia += cuanto
	}
	                                
}
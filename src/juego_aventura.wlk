import wollok.game.*
import geografia.*
import elementos.*
import personajes.*
import nivel_llaves.*

object juego {
	method configurarNivel1() {
		nivelBloques.configurarPersonajes()
		nivelBloques.configurarTeclado()
		nivelBloques.configurarColisiones()
	}
	
	method arrancarNivelLlaves() {
		game.clear()
		nivelLlaves.configurarPersonajes()
		nivelLlaves.configurarTeclado()
		nivelLlaves.configurarColisiones()
	}
	
	method configurarMovimiento(personaje) {
		keyboard.left().onPressDo({ personaje.moverseEnDireccion(oeste) })
		keyboard.right().onPressDo({ personaje.moverseEnDireccion(este) })
		keyboard.up().onPressDo({ personaje.moverseEnDireccion(norte) })
		keyboard.down().onPressDo({ personaje.moverseEnDireccion(sur) })
	}	
	
	method posicionArbitraria() {
		return game.at(0.randomUpTo(game.width()).truncate(0), 0.randomUpTo(game.height()).truncate(0))
	}
}

object nivelBloques {
	const regionPrivilegiada = new Region(inicio=game.at(5,7), fin=game.at(9,12))
	var property bloques = []
	
	method configurarPersonajes() {
		bloques = self.crearBloques()
		bloques.forEach({bl => game.addVisual(bl)})
		empujadorBloques.position(puertaNivel1.position().up(1))
		game.addVisual(puertaNivel1)
		game.addVisual(empujadorBloques)
	}
	
	method configurarTeclado() {
		keyboard.a().onPressDo({ empujadorBloques.agarrarBloque() })
		keyboard.s().onPressDo({ empujadorBloques.soltarBloque() })
		keyboard.n().onPressDo({ empujadorBloques.controlarPasoPorPuerta() })
		keyboard.t().onPressDo({ self.terminar() })
		juego.configurarMovimiento(empujadorBloques)
	}
	
	method configurarColisiones() {
//		game.whenCollideDo(puertaNivel1, { objeto => objeto.pasastePorPuertaNivel1() })
	}
	
	method crearBloques() {
		// 6 bloques, pueden caer dentro o fuera de la región privilegiada
		return (1..6).map({ n =>
			return new Bloque(position=juego.posicionArbitraria())
		})
	}
	
	method bloquesListos() {
		return bloques.all({bl => regionPrivilegiada.incluye(bl.position())})
	}

	method terminar() {
		game.clear()
		game.addVisual(puertaNivel1)
		game.addVisual(empujadorBloques)
		game.schedule(2500, {
			game.clear()
			game.addVisual(new Cartel(image="finNivel1.png"))
			game.schedule(3000, {
				juego.arrancarNivelLlaves()
			})
		})
	}
		
//	method terminar_no_anda() {
//		[keyboard.a(), keyboard.s(), keyboard.left(), keyboard.right(),
//			keyboard.up(), keyboard.down()
//		].forEach({ key => key.onPressDo({})})
//		game.schedule(2000, {
//			game.removeVisual(empujadorBloques)
//			game.removeVisual(puertaNivel1)
//			bloques.forEach({ bl => game.removeVisual(bl) })
//			game.boardGround("finNivel1")
//		})
//	}
}

class Cartel {
	const property position = game.at(0, 0)
	var property image 
}

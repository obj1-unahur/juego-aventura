import wollok.game.*
import personajes.*
import elementos.*
import juego_aventura.*

object nivelLlaves {
	const property llavesEncontradas = []	
	
	method configurarPersonajes() {
		self.crearLlaves().forEach({llave => game.addVisual(llave)})
		self.crearComida().forEach({comida => game.addVisual(comida)})
		game.addVisual(buscadorDeLlaves)
	}

	method configurarTeclado() {
		juego.configurarMovimiento(buscadorDeLlaves)
		keyboard.e().onPressDo({ 
			game.say(buscadorDeLlaves, "mi energía es " + buscadorDeLlaves.energia())
		})
		keyboard.g().onPressDo({ self.ganar() })
		keyboard.p().onPressDo({ self.perder() })
	}
	
	method configurarColisiones() {
		game.whenCollideDo(buscadorDeLlaves, { obj => obj.teEncontroElBuscador() })
	}

	method crearLlaves() {
		// 3 llaves
		return (1..3).map({ n => new Llave(position=juego.posicionArbitraria()) })
	}

	method crearComida() {
		// 3 comidas
		return [
			new Comida(position=juego.posicionArbitraria(), energia = 10),
			new Comida(position=juego.posicionArbitraria(), energia = 20),
			new Comida(position=juego.posicionArbitraria(), energia = 30)
		]
	}

	method recogerLlave(llave) {
		llavesEncontradas.add(llave)
		game.removeVisual(llave)
		if (self.encontroTodasLasLlaves()) {
			game.addVisual(puertaNivel2)
		}
	}
	
	method recogerComida(comida) {
		buscadorDeLlaves.aumentarEnergia(comida.energia())
		game.removeVisual(comida)		
	}
	
	method encontroTodasLasLlaves() {
		return llavesEncontradas.size() == 3 
	}
	
	method terminar(imagenFinal) {
		game.clear()
		game.addVisual(buscadorDeLlaves)
		game.schedule(2500, {
			game.clear()
			game.addVisual(new Cartel(image=imagenFinal))
			game.schedule(3000, { game.stop() })
		})
	}
	
	method perder() { self.terminar("gameOver.png") }
	method ganar() { self.terminar("ganamos.png")}
}

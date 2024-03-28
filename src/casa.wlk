object casaDePepeYJulian {

	var property viveres = 50.00
	var montoReparaciones = 0
	var cuenta = cuentaConGastos
	var estrategiaDeAhorro = minimoIndispensable

	method agregarViveres(_viveres) {
		viveres += _viveres
	}

	method estrategiaDeAhorro(_estrategiaDeAhorro) {
		estrategiaDeAhorro = _estrategiaDeAhorro
	}

	method cuenta(_cuenta) {
		cuenta = _cuenta
	}

	method montoReparaciones() {
		return montoReparaciones
	}

	method hayViveresSuficientes() {
		return self.viveres() >= 40.00
	}

	method enOrden() {
		return self.hayViveresSuficientes() && not self.hayQueReparar()
	}

	method hayQueReparar() {
		return montoReparaciones > 0
	}

	method seRompeAlgo(valor) {
		montoReparaciones += valor
	}

	method seArreglaAlgo(valor) {
		montoReparaciones -= valor
	}

	method gastarDinero(dinero) {
		cuenta.extraer(dinero)
	}

	method consultarSaldo() {
		return cuenta.saldo()
	}

	method extraerSaldo(dinero) {
		return cuenta.extraer(dinero)
	}

	method depositarSaldo(dinero) {
		return cuenta.depositar(dinero)
	}

	method mantenimientoDeLaCasa() {
		estrategiaDeAhorro.mantenerCasa(self)
	}

}

object cuentaCorriente {

	var property saldo = 0

	method depositar(dinero) {
		saldo += dinero
	}

	method extraer(dinero) {
		saldo -= dinero
	}

}

object cuentaConGastos {

	var saldo = 0
	var costoDeOperacion = 0

	method saldo() {
		return saldo
	}

	method costoDeOperacion(_costoDeOperacion) {
		costoDeOperacion = _costoDeOperacion
	}

	method depositar(dinero) {
		saldo += dinero - costoDeOperacion
	}

	method extraer(dinero) {
		saldo -= dinero
	}

}

object cuentaCombinada {

	var property cuentaPrimaria = cuentaConGastos
	var property cuentaSecundaria = cuentaCorriente

	method saldo() {
		return cuentaPrimaria.saldo() + cuentaSecundaria.saldo()
	}

	method depositar(dinero) {
		cuentaPrimaria.depositar(dinero)
	}

	method extraer(dinero) {
		if (cuentaPrimaria.saldo() >= dinero) cuentaPrimaria.extraer(dinero) else cuentaSecundaria.extraer(dinero)
	}

}

object minimoIndispensable {

	var calidad = 0

	method calidad(_calidad) {
		calidad = _calidad
	}

	method mantenerCasa(casa) {
		if (not casa.hayViveresSuficientes()) {
			const viveresFaltantes = 40.00 - casa.viveres()
			casa.gastarDinero(viveresFaltantes * calidad)
			casa.agregarViveres(viveresFaltantes)
		}
	}

}

object full {
	const calidad = 5

	method mantenerCasa(casa) {
		if (casa.enOrden()) {
			const viveresFaltantes = 100.00 - casa.viveres()
			casa.gastarDinero(viveresFaltantes * calidad)
			casa.agregarViveres(viveresFaltantes)
		} else {
			casa.agregarViveres(40)
			casa.gastarDinero(40 * calidad)
		}
		const saldoRestante = casa.consultarSaldo() - casa.montoReparaciones()
		if (saldoRestante > 1000) {
			casa.seArreglaAlgo(casa.montoReparaciones())
			casa.gastarDinero(saldoRestante)
		}
	}

}


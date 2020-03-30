# Practica 7 - Procesamiento de audio

**Hecho por Borja Zarco Cerezo**

## Índice
- [Introducción](#introducción) 
- [Desarrollo](#desarrollo)
- [Uso](#uso)
- [Resultado](#resultado)
- [Referencias](#referencias)

## Introducción

El objetivo de esta práctica consiste en la elaboración de un prototipo que integre gráficos y síntesis de sonido.

## Desarrollo

El prototipo fue elaborar una versión del conocido juego Flappy Bird. En esta ocasión, el jugador tendrá que pasar entre unas columnas. Para controlar el "pajaro" (que estará representado por un cuadrado), tendrá que usar su voz. Cuando el programa detecte sonido, el "pájaro" subirá. Si deja de detectar sonido, descenderá. Además dependiendo de la intensidad del sonido, el pájaro subirá más o menos rápido. A una cierta intensidad baja el pájaro se detendrá. Esto se ha hecho de esta manera para evitar los valores espúreos que pueda capturar el micrófono, pues se ha tenido que aumentar de forma considerable su sensibilidad, haciéndolo más propenso a la captación de sonidos no deseados.

La partida finalizará si el jugador choca con alguna de los muros o si llega a 20 puntos.

## Resultado

Aqui dejo una demo de la aplicación resultante: 

![Demo Aplicación](./assets/sound-animation.gif)

## Referencias

* [Guion de prácticas](https://cv-aep.ulpgc.es/cv/ulpgctp20/pluginfile.php/126724/mod_resource/content/22/CIU_Pr_cticas.pdf)
* [GifAnimation](https://github.com/extrapixel/gif-animation)
* [Documentación Processing](https://processing.org/)

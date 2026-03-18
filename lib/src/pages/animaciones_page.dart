import 'package:flutter/material.dart';
import 'dart:math' as Math;

class AnimacionesPage extends StatelessWidget {
  const AnimacionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CuadradoAnimado(),
      ),
    );
  }
}

class CuadradoAnimado extends StatefulWidget {
  @override
  State<CuadradoAnimado> createState() => _CuadradoAnimadoState();
}

class _CuadradoAnimadoState extends State<CuadradoAnimado> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> rotacion;
  late Animation<double> opacidad;
  late Animation<double> moverDerecha;
  late Animation<double> agrandar;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );
    // rotacion = Tween<double>(begin: 0, end: 2 * Math.pi).animate(controller);
    rotacion = Tween<double>(begin: 0, end: 2 * Math.pi).animate(
      CurvedAnimation(parent: controller, curve: Curves.bounceIn)
    );

    opacidad = Tween(begin: 0.1, end: 1.0).animate(
      // Interval permite definir un intervalo de tiempo para la animacion, en este caso del 0 al 0.5 (50% del tiempo total) el rango es del 0 al 1
      CurvedAnimation(parent: controller, curve: Interval(0, 0.5, curve: Curves.easeOut))
    );

    moverDerecha = Tween(begin: 0.0, end: 200.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut)
    );

    agrandar = Tween(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut)
    );

    controller.addListener(() {
      print('Status: ${controller.status}');
      if(controller.status == AnimationStatus.completed) {
        // controller.reverse();
        controller.reset();
        // controller.repeat();
      }
    });

    // Repetir la animacion
    // controller.repeat(); 
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Play / Reproduccion
    controller.forward();

    return AnimatedBuilder(
      animation: controller, 
      child: _Rectangulo(),
      builder: (context, childRectangulo) {
        print('Rotacion: ${rotacion.value}');
        return Transform.translate(
          offset: Offset(moverDerecha.value, 0),
          child: Transform.rotate(
            angle: rotacion.value,
            child: Opacity(
              opacity: opacidad.value,
              child: Transform.scale(
                scale: agrandar.value,
                child: childRectangulo
                ),
            ),
          ),
        );
      },
    );
  }
}

class _Rectangulo extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
    return Container(
       width: 70,
       height: 70,
       decoration: BoxDecoration(
         color: Colors.blue
       ),
     );
   }
}

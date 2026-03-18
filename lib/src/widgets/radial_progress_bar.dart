import 'dart:math';
import 'package:flutter/material.dart';

class RadialProgressBar extends StatefulWidget {
  final double porcentaje;
  final Color colorPrimario;
  final Color colorSecundario;
  final double grosorPrimario;
  final double grosorSecundario;

  const RadialProgressBar({
    super.key, 
    required this.porcentaje, 
    this.colorPrimario = Colors.blue, 
    this.colorSecundario = Colors.grey,
    this.grosorPrimario = 10,
    this.grosorSecundario = 4,
  });

  @override
  State<RadialProgressBar> createState() => _RadialProgressBarState();
}

class _RadialProgressBarState extends State<RadialProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late double porcentajeAnterior;
  
  @override
  void initState() {
    porcentajeAnterior = widget.porcentaje;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0);
    final diferenciaAnimar = widget.porcentaje - porcentajeAnterior;
    porcentajeAnterior = widget.porcentaje;
    return AnimatedBuilder(
      animation: controller, 
      builder: (context, child) {
        double porcentajeAnimado = ( widget.porcentaje - diferenciaAnimar ) + ( diferenciaAnimar * controller.value );
        return Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(10),
          child: CustomPaint(
            painter: _MiRadialProgress(
              porcentaje: porcentajeAnimado, 
              colorPrimario: widget.colorPrimario, 
              colorSecundario: widget.colorSecundario,
              grosorPrimario: widget.grosorPrimario,
              grosorSecundario: widget.grosorSecundario
            ),
          ),
        );
      }
    );
  }
}


class _MiRadialProgress extends CustomPainter {
  final double porcentaje; // Porcentaje de progreso
  final Color colorPrimario;
  final Color colorSecundario;
  final double grosorPrimario;
  final double grosorSecundario;

  _MiRadialProgress(
    {
      required this.porcentaje,
      required this.colorPrimario,
      required this.colorSecundario,
      required this.grosorPrimario,
      required this.grosorSecundario
    }
  );

  @override
  void paint(Canvas canvas, Size size) {
    // Circulo completo
    final paint = Paint()
      ..color = colorSecundario
      ..strokeWidth = grosorSecundario
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radio = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radio, paint);

    final paintArco = new Paint()
      ..color = colorPrimario
      ..strokeWidth = grosorPrimario
      ..style = PaintingStyle.stroke;

      // Parte que se debera llenando
      double arcAngle = 2 * pi * (porcentaje / 100); // 50% del circulo
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radio), // Rectangulo que define el circulo
        -pi / 2, // Angulo de inicio (en este caso, la parte superior del circulo)
        arcAngle, // Angulo de barrido (en este caso, el 50% del circulo)
        false, // No es un arco cerrado
        paintArco,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
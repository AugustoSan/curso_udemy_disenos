import 'dart:math';

import 'package:flutter/material.dart';


class CircularProgressPage extends StatefulWidget {

  @override
  State<CircularProgressPage> createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends State<CircularProgressPage> {
  double porcentaje = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          padding: const EdgeInsets.all(5),
          // color: Colors.red,
          child: CustomPaint(
            painter: _MiRadialProgress(porcentaje),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            porcentaje += 10;
            if(porcentaje > 100) {
              porcentaje = 0;
            }
          });
        },
      ),
   );
  }
}

class _MiRadialProgress extends CustomPainter {
  final double porcentaje; // Porcentaje de progreso
  _MiRadialProgress(this.porcentaje);

  @override
  void paint(Canvas canvas, Size size) {
    // Circulo completo
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radio = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radio, paint);

    final paintArco = new Paint()
      ..color = Colors.purple
      ..strokeWidth = 10
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
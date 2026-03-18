import 'dart:math';
import 'package:flutter/material.dart';

class RadialProgressBar extends StatefulWidget {
  final double porcentaje;

  const RadialProgressBar({super.key, required this.porcentaje});

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
    controller.addListener(() {
      setState(() {});
    });

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
        return Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(10),
          child: CustomPaint(
            painter: _MiRadialProgress((widget.porcentaje - diferenciaAnimar) + (diferenciaAnimar * controller.value)),
          ),
        );
      }
    );
    // return Container(
    //   width: double.infinity,
    //   height: double.infinity,
    //   padding: const EdgeInsets.all(10),
    //   child: CustomPaint(
    //     painter: _MiRadialProgress(widget.porcentaje),
    //   ),
    // );
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
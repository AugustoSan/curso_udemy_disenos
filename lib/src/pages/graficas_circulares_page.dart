import 'package:flutter/material.dart';
import './../widgets/index.dart';

class GraficasCircularesPage extends StatefulWidget {
  const GraficasCircularesPage({super.key});

  @override
  State<GraficasCircularesPage> createState() => _GraficasCircularesPageState();
}

class _GraficasCircularesPageState extends State<GraficasCircularesPage> {
  double porcentaje = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadialProgress(porcentaje: porcentaje, colorPrimario: Colors.purple, colorSecundario: Colors.purple.withOpacity(0.2), grosorPrimario: 10, grosorSecundario: 5),
              CustomRadialProgress(porcentaje: porcentaje, colorPrimario: Colors.green, colorSecundario: Colors.green.withOpacity(0.2), grosorPrimario: 15, grosorSecundario: 10),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadialProgress(porcentaje: porcentaje, colorPrimario: Colors.blue, colorSecundario: Colors.blue.withOpacity(0.2), grosorPrimario: 5, grosorSecundario: 10),
              CustomRadialProgress(porcentaje: porcentaje, colorPrimario: Colors.orange, colorSecundario: Colors.orange.withOpacity(0.2), grosorPrimario: 2, grosorSecundario: 1),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadialProgress(porcentaje: porcentaje, colorSecundario: Colors.red.withOpacity(0.2), grosorPrimario: 5, grosorSecundario: 5, gradienteColores: [Colors.red, Colors.black, Colors.yellow],),
              CustomRadialProgress(porcentaje: porcentaje, colorPrimario: Colors.yellow, colorSecundario: Colors.yellow.withOpacity(0.2), grosorPrimario: 10, grosorSecundario: 10),
            ],
          ),
        ],
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

class CustomRadialProgress extends StatelessWidget {
  final double porcentaje;
  final Color colorPrimario;
  final Color colorSecundario;
  final double grosorPrimario;
  final double grosorSecundario;
  final List<Color> gradienteColores;

  const CustomRadialProgress({
    super.key,
    required this.porcentaje,
    this.colorPrimario = Colors.blue,
    this.colorSecundario = Colors.grey,
    this.grosorPrimario = 10,
    this.grosorSecundario = 4,
    this.gradienteColores = const [],
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: RadialProgressBar(
        porcentaje: porcentaje, 
        colorPrimario: colorPrimario, 
        colorSecundario: colorSecundario,
        grosorPrimario: grosorPrimario,
        grosorSecundario: grosorSecundario,
        gradienteColores: gradienteColores,
      ),
    );
  }
}
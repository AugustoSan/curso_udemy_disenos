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
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: RadialProgressBar(
            porcentaje: porcentaje, 
            colorPrimario: Colors.red, 
            colorSecundario: Colors.grey,
            grosorSecundario: 20,
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
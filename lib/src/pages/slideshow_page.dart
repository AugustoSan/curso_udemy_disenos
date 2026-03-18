import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:curso_udemy_disenos/src/models/index.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SliderModel(),
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(child: _Slides()),
              _Dots(),
            ],
          )
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Dot(index: 0),
          _Dot(index: 1),
          _Dot(index: 2),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  const _Dot({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final currentPage = Provider.of<SliderModel>(context).currentPage;
    // Determinar si el punto actual es el activo o no, considerando un rango de 0.5 para cada lado del índice
    final isActive = (currentPage >= index - 0.5) && (currentPage < index + 0.5);

    return Container(
      width: isActive ? 20 : 10,
      height: isActive ? 20 : 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    
    pageViewController.addListener(() {
        print('Página actual: ${pageViewController.page}');

        // Actualizar el valor de currentPage en el SliderModel
        Provider.of<SliderModel>(context, listen: false).currentPage = pageViewController.page!;
    });
  }
  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: PageView(
        controller: pageViewController,
        children: [
          _Slide(asset: 'assets/svgs/slide-1.svg'),
          _Slide(asset: 'assets/svgs/slide-2.svg'),
          _Slide(asset: 'assets/svgs/slide-3.svg'),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String asset;
  const _Slide({
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: SvgPicture.asset(asset),
    );
  }
}
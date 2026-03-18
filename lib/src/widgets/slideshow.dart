import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curso_udemy_disenos/src/models/index.dart';

class Slidesshow extends StatelessWidget {
  final List<Widget> slides;
  final bool showDots;
  final bool showDotsTop;
  final Color primaryColor;
  final Color secondaryColor;
  const Slidesshow({
    super.key, 
    required this.slides, 
    this.showDots = true, 
    this.showDotsTop = false,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SliderModel(), 
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              if(showDotsTop && showDots) _Dots(totalSlides: slides.length, primaryColor: primaryColor, secondaryColor: secondaryColor),
              Expanded(child: _Slides(slides: slides)),
              if(!showDotsTop && showDots) _Dots(totalSlides: slides.length, primaryColor: primaryColor, secondaryColor: secondaryColor),
            ],
          )
        ),
      )
    );
  }
}


class _Dots extends StatelessWidget {
  final int totalSlides;
  final Color primaryColor;
  final Color secondaryColor;
  const _Dots({required this.totalSlides, required this.primaryColor, required this.secondaryColor});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSlides, (index) => _Dot(index: index, primaryColor: primaryColor, secondaryColor: secondaryColor)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  final Color primaryColor;
  final Color secondaryColor;
  const _Dot({
    required this.index,
    required this.primaryColor,
    required this.secondaryColor
  });

  @override
  Widget build(BuildContext context) {
    final currentPage = Provider.of<SliderModel>(context).currentPage;
    // Determinar si el punto actual es el activo o no, considerando un rango de 0.5 para cada lado del índice
    final isActive = (currentPage >= index - 0.5) && (currentPage < index + 0.5);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 20 : 10,
      height: isActive ? 20 : 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: isActive ? primaryColor : secondaryColor,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;
  const _Slides({
    required this.slides
  });
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
        children: widget.slides.map((slide) => _Slide(slide: slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;
  const _Slide({
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: slide,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Slidesshow extends StatelessWidget {
  final List<Widget> slides;
  final bool showDots;
  final bool showDotsTop;
  final Color primaryColor;
  final Color secondaryColor;
  final double dotSizeActive;
  final double dotSizeInactive;
  const Slidesshow({
    super.key, 
    required this.slides, 
    this.showDots = true, 
    this.showDotsTop = false,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
    this.dotSizeActive = 20,
    this.dotSizeInactive = 10,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideshowModel(
        currentPage: 0.0,
        primaryColor: primaryColor,
        secondaryColor: secondaryColor,
        dotSizeActive: dotSizeActive,
        dotSizeInactive: dotSizeInactive,
      ), 
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              if(showDotsTop && showDots) _Dots(totalSlides: slides.length),
              Expanded(child: _Slides(slides: slides)),
              if(!showDotsTop && showDots) _Dots(totalSlides: slides.length),
            ],
          ),
        ),
      )
    );
  }
}


class _Dots extends StatelessWidget {
  final int totalSlides;
  const _Dots({required this.totalSlides});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSlides, (index) => _Dot(index: index)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  const _Dot({
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_SlideshowModel>(context);
    final isActive = (model.currentPage >= index - 0.5) && (model.currentPage < index + 0.5);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? model.dotSizeActive : model.dotSizeInactive,
      height: isActive ? model.dotSizeActive : model.dotSizeInactive,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: isActive ? model.primaryColor : model.secondaryColor,
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

        // Actualizar el valor de currentPage en el 
        Provider.of<_SlideshowModel>(context, listen: false).currentPage = pageViewController.page!;
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

class _SlideshowModel with ChangeNotifier {
  double _currentPage = 0.0;
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.grey;
  double _dotSizeActive = 20;
  double _dotSizeInactive = 10;

  _SlideshowModel({
    double currentPage = 0.0,
    Color primaryColor = Colors.blue,
    Color secondaryColor = Colors.grey,
    double dotSizeActive = 20,
    double dotSizeInactive = 10,
  }): _currentPage = currentPage,
      _primaryColor = primaryColor,
      _secondaryColor = secondaryColor,
      _dotSizeActive = dotSizeActive,
      _dotSizeInactive = dotSizeInactive;

  double get currentPage => _currentPage;
  set currentPage(double value) {
    _currentPage = value;
    notifyListeners();
  }

  Color get primaryColor => _primaryColor;
  set primaryColor(Color value) {
    _primaryColor = value;
    notifyListeners();
  }
    
    
  Color get secondaryColor => _secondaryColor;
  set secondaryColor(Color value) {
    _secondaryColor = value;
    notifyListeners();
  }

  double get dotSizeActive => _dotSizeActive;
  set dotSizeActive(double value) {
    _dotSizeActive = value;
    notifyListeners();
  }

  double get dotSizeInactive => _dotSizeInactive;
  set dotSizeInactive(double value) {
    _dotSizeInactive = value;
    notifyListeners();
  }
}
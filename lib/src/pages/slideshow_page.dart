import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _Slides()
      ),
    );
  }
}

class _Slides extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: PageView(
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
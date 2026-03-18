import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:curso_udemy_disenos/src/widgets/index.dart';
import 'package:curso_udemy_disenos/src/models/index.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SliderModel(),
      child: Scaffold(
        body: Slidesshow(
          // showDotsTop: true,
          primaryColor: Colors.red,
          secondaryColor: Colors.black,
          dotSizeActive: 20,
          dotSizeInactive: 5,
          showDots: true,
          slides: [
            SvgPicture.asset('assets/svgs/slide-1.svg'),
            SvgPicture.asset('assets/svgs/slide-2.svg'),
            SvgPicture.asset('assets/svgs/slide-3.svg'),  
            SvgPicture.asset('assets/svgs/slide-4.svg'),  
            SvgPicture.asset('assets/svgs/slide-5.svg'),  
            Center(
              child: Text('Slide 6', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Text('Slide 7', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

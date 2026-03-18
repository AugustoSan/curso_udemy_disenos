import 'package:flutter/material.dart';
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
        body: Slidesshow(),
      ),
    );
  }
}

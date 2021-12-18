import 'package:bombscrypto_simulator/hero/model/hero_model.dart';
import 'package:bombscrypto_simulator/util/image/images.dart';
import 'package:bombscrypto_simulator/util/widget/stat_input_view.dart';
import 'package:flutter/material.dart';

class HeroPage extends StatefulWidget {
  const HeroPage({Key? key}) : super(key: key);

  @override
  State<HeroPage> createState() {
    return _HeroPageState();
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(16), bottom: Radius.circular(16))),
        builder: (_) {
          return const HeroPage();
        });
  }
}

class _HeroPageState extends State<HeroPage> {
  final spaceBetween = const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 0.8,
        child: SingleChildScrollView(
            child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: ProjectImage.card(), fit: BoxFit.fill),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close)),
                          const Text("Hero")
                        ]),
                        spaceBetween,
                        spaceBetween,
                        _buildForm(context)
                      ],
                    )))));
  }

  Widget _buildForm(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: 3,
          child: Column(children: [
            SizedBox(
                height: 160,
                width: 80,
                child: Image.asset(HeroType.legend.icon)),
            Text(
              HeroType.legend.name,
              textAlign: TextAlign.center,
            )
          ])),
      Expanded(
          flex: 7,
          child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(children: [
                StatInputView(stat: Stat.power),
                spaceBetween,
                StatInputView(stat: Stat.speed),
                spaceBetween,
                StatInputView(stat: Stat.stamina),
                spaceBetween,
                StatInputView(stat: Stat.bombCount),
                spaceBetween,
                StatInputView(stat: Stat.bombRange),
              ])))
    ]);
  }
}

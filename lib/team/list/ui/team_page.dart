import 'package:bombscrypto_simulator/util/image/images.dart';
import 'package:flutter/material.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TeamsStatePage();
  }
}

class TeamsStatePage extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teams"),
        centerTitle: true,
      ),
      body: const Center(child: Text("teams")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: ProjectColors.textLightColor,
        onPressed: () {  },
      ),
    );
  }
}

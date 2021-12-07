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
    return const Center(child: Text("TEAMS"));
  }
}

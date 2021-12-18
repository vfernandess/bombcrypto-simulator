import 'package:flutter/material.dart';

class StatInputView extends StatefulWidget {
  final ValueChanged<int>? onChanged;
  final Stat stat;

  const StatInputView({Key? key, this.onChanged, required this.stat})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StatInputState();
  }
}

class Stat {
  final String icon;
  final String name;

  const Stat._(this.icon, this.name);

  static const power = Stat._("assets/images/power.png", "Power");
  static const speed = Stat._("assets/images/speed.png", "Speed");
  static const stamina = Stat._("assets/images/stamina.png", "Stamina");
  static const bombCount = Stat._("assets/images/bomb_count.png", "Bomb Count");
  static const bombRange = Stat._("assets/images/bomb_range.png", "Bomb Range");
}

class _StatInputState extends State<StatInputView> {
  int stat = 0;

  late final TextEditingController _controller =
      TextEditingController(text: stat.toString());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  _increaseStat();
                },
                icon: const Icon(Icons.plus_one)),
            Expanded(
                child: TextField(
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(FocusNode());

                      setStat(_controller.text);
                    },
                    decoration: InputDecoration(
                        labelText: widget.stat.name,
                        icon: Image.asset(widget.stat.icon)),
                    controller: _controller,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number)),
            IconButton(
                onPressed: () {
                  _decreaseStat();
                },
                icon: const Icon(Icons.exposure_minus_1)),
          ],
        )
      ],
    );
  }

  void _increaseStat() {
    setState(() {
      stat += 1;
      _notifyStatChanged();
    });
  }

  void setStat(String stat) {
    setState(() {
      if (stat.isEmpty) {
        this.stat = 0;
      } else {
        this.stat = int.parse(stat);
      }
    });
  }

  void _decreaseStat() {
    setState(() {
      if (stat <= 0) {
        stat = 0;
      } else {
        stat -= 1;
      }
      _notifyStatChanged();
    });
  }

  void _notifyStatChanged() {
    _controller.text = stat.toString();
    widget.onChanged?.call(stat);
  }
}

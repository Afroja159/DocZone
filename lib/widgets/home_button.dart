import 'package:doczone/widgets/custom_widget.dart';
import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: buttonClr,
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Icon(Icons.home),
    );
  }
}

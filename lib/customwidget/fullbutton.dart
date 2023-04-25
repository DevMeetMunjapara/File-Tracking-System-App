import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

Color PrimaryColor = Color.fromARGB(255, 84, 22, 208);
Color SecondaryColor = Color.fromARGB(255, 158, 158, 158);

class FullButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool loading;

  const FullButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.loading = false,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: PrimaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
        onPressed: onPressed,
        child: Center(
          child: loading
              ? CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                )
              : Text(
                  title,
                  style: TextStyle(fontSize: 16),
                ),
        ),
      ),
    );
  }
}

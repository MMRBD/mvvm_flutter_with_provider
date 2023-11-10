import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final bool loading;

  const CustomButton(
      {super.key,
      required this.title,
      required this.onPress,
      required this.loading});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: loading ? null : onPress,
        child: SizedBox(
          height: 40,
          width: 200,
          child: Stack(
            children: [
              if (loading)
                const Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              else
                Center(
                  child: Text(
                    title.toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ));
  }
}

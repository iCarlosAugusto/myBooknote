import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.isLoading = false,
    this.isEnabled = true,
  });

  Function() onPressed;
  String title;
  bool isLoading = false;
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled && isLoading == false ? onPressed : null, 
      child: isLoading 
        ? const CircularProgressIndicator() 
        : const Text('Entrar')
    );
  }
}

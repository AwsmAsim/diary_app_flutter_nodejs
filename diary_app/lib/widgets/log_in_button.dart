import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {

  final String text;
  final void Function()? onPressed;

  const LoginButton({required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        // padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width/2,
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.cyanAccent, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(12.0),),
          ),
          child: Text(text,
            textAlign: TextAlign.center,
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20.0),),
            border: Border.all(color: Colors.white, width: 5.0)
        ),
      ),
    );
  }
}

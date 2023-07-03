import 'package:flutter/material.dart';

class MenuPR extends StatelessWidget {
  const MenuPR({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.greenAccent[400],
        body: SizedBox(
          child: Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

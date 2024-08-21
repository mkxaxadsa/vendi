import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).viewPadding.top,
            // color: const Color(0xff06334D),
            color: Colors.white,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(color: Colors.white),
                body,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

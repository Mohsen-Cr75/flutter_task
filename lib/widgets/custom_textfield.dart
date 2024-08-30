
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_animate_border.dart';


class AnimatedTextField extends StatefulWidget {
  final bool password;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onchange;
  final bool onError ;
  const AnimatedTextField({Key? key, required this.controller, required this.focusNode,  required this.onchange, required this.password,required this.onError, })
      : super(key: key);

  @override
  State<AnimatedTextField> createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField>
  with SingleTickerProviderStateMixin {
  AnimationController? controller;
  late Animation<double> alpha;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    final Animation<double> curve =
        CurvedAnimation(parent: controller!, curve: Curves.easeInOut);
    alpha = Tween(begin: 0.0, end: 1.0).animate(curve);

    
    // controller?.forward();
    controller?.addListener(() {
      setState(() {});
    });
   
    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus) {
        controller?.forward();
      } else {
        controller?.reverse();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:widget.onError?  Border.all(color: Colors.red):  Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey.shade900,  // Darker grey for the top
                Colors.black,  // Black for the bottom
              ],
            ),
          boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.8),  // Darker shadow for depth
                offset: Offset(10, 10),
                blurRadius: 15,
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Colors.grey.shade800.withOpacity(0.5),  // Lighter shadow for contrast
                offset: const Offset(-5, -5),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
      child: Theme(
        data: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Colors.cyan,
                )),
        child: CustomPaint(
          painter: CustomAnimateBorder(alpha.value),
          child: TextField(
            obscureText: widget.password ,
            obscuringCharacter: '*',
            controller: widget.controller,
                    focusNode: widget.focusNode,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 2,
                    textAlign: TextAlign.center,
                    onChanged: widget.onchange ,
                    style: TextStyle(
                      color:widget.focusNode.hasFocus
                      ? Colors.greenAccent :null ,
                      fontSize: 20
                    ),
            decoration:  const InputDecoration(
                      
                      
                      counterText: '',
                      border: InputBorder.none,
                      contentPadding:
                 EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    
                  ),
          ),
        ),
      );
    
  }
}

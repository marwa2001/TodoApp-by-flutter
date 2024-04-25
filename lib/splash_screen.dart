import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:todo_list/todo_layout.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 7),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder:(_) => HomeLayout(),

          ));
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Container(
        width:double.infinity,

child: Padding(
  padding: const EdgeInsets.all(8.0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      Lottie.asset('assets/todoanimation.json',


      ),
      SizedBox(
  height: 20,
      ),
      Container
        (
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: GradientText(
          'Mange your tasks and ideas quickly',
          colors: [
            HexColor("#756AB6"),
            HexColor("#AC87C5"),
            HexColor("#E0AED0"),
            HexColor("#FFE5E5")
          ],
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
      )
    ],
  ),
),

      ),
    );
  }
}

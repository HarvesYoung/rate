import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  bool showButton = false; // whether to show the button
  double buttonOpacity = 0; // the opacity of button
  static const String lottieJsonPath = 'assets/lottie/rate.json';
  static const String firstShowFlag = 'isFirstShow';

  @override
  void initState() async {
    super.initState();
    // verify whether logged in or not
    _verifyIsFirstShow();
  } // initState() end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Lottie.asset(
                lottieJsonPath,
                width: 200,
                height: 200,
                fit: BoxFit.contain,
                onLoaded: _showEnterButtonAfter
              ),
            ),

            // button shows gradually
            if(showButton)
              AnimatedOpacity(
                opacity: buttonOpacity,
                duration: const Duration(milliseconds: 800),
                child: OutlinedButton(
                  onPressed: () {
                    // jump to home page when this button clicked
                    Navigator.pushReplacementNamed(context, 'home');
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12
                    )
                  ),
                  child: const Text('进入应用', style: TextStyle(
                    fontSize: 12
                  ),),
                ),
              ),

            const SizedBox(height: 100,)
          ],
        )
      ),
    );
  } // build() end

  void _verifyIsFirstShow() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstShow = prefs.getBool(firstShowFlag) ?? true;

    if(!isFirstShow && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, 'home');
      });
    } else {
      prefs.setBool(firstShowFlag, false);
    }
  } // _verifyIsFirstShow() end

  void _showEnterButtonAfter(LottieComposition composition) {
    Future.delayed(composition.duration, (){
      if(mounted) {
        setState(() => showButton = true);
      }

      Future.delayed(const Duration(milliseconds: 100), (){
        if(mounted) {
          setState(() => buttonOpacity = 1);
        }
      });
    });
  } // _showEnterButtonAfter() end
}
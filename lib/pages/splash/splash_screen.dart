import 'package:flutter/material.dart';
import 'package:shoppingcart/pages/home/home_screen.dart';
import 'package:shoppingcart/utils/extensions/extension_context.dart';
import 'package:shoppingcart/utils/gen/gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animScale;
  late Animation<double> _opacityAnim;
  bool isActive = false;
  bool isShowButton = false;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animScale = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.ease));
    _opacityAnim = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.ease));
    _animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        context.navigate(const HomeScreen(),
            pushAndRemoveUntil: true, isAnimated: true);
      }
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _opacityAnim,
        child: Stack(
          children: [
            ScaleTransition(
              scale: _animScale,
              child: Center(
                child: Assets.icons.icCartSplash.image(
                    width: context.width < 600 ? context.width / 3 : 200),
              ),
            ),
            Positioned(
                bottom: context.bottomBarHeight + 28,
                right: 16,
                left: 16,
                child: const Center(
                    child: Text('© 2023, QSoft. All rights reserved')))
          ],
        ),
      ),
    );
  }
}

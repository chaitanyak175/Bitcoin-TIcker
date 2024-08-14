import 'package:flutter/material.dart';
import 'package:mesh/mesh.dart';

extension on OVertex {
  OVertex to(OVertex b, double t) => OVertex.lerp(this, b, t);
}

extension on Color? {
  Color? to(Color? b, double t) => Color.lerp(this, b, t);
}

typedef C = Colors;

class Homemeshbackground extends StatefulWidget {
  const Homemeshbackground({super.key});

  @override
  State<Homemeshbackground> createState() => HomemeshbackgroundState();
}

class HomemeshbackgroundState extends State<Homemeshbackground>
    with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(vsync: this)
    ..duration = const Duration(seconds: 5)
    ..forward()
    ..addListener(() {
      if (controller.value == 1.0) {
        controller.animateTo(0, curve: Curves.easeInOutQuint);
      }
      if (controller.value == 0.0) {
        controller.animateTo(1, curve: Curves.easeInOutCubic);
      }
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final dt = controller.value;
          return OMeshGradient(
            tessellation: 12,
            size: Size.infinite,
            mesh: OMeshRect(
              smoothColors: true,
              width: 3,
              height: 4,
              // We have some different color spaces available
              colorSpace: OMeshColorSpace.lab,
              fallbackColor: C.transparent,
              vertices: [
                (0.0, 0.3).v.to((0.0, 0.0).v, dt),
                (0.5, 0.15).v.to((0.5, 0.1).v, dt * dt),
                (1.0, -0.1).v.to((1.0, 0.3).v, dt * dt), //

                (-0.05, 0.68).v.to((0.0, 0.45).v, dt),
                (0.63, 0.3).v.to((0.48, 0.54).v, dt),
                (1.0, 0.1).v.to((1.0, 0.6).v, dt), //

                (-0.2, 0.92).v.to((0.0, 0.58).v, dt),
                (0.32, 0.72).v.to((0.58, 0.69).v, dt * dt),
                (1.0, 0.3).v.to((1.0, 0.8).v, dt), //

                (0.0, 1.2).v.to((0.0, 0.86).v, dt),
                (0.5, 0.88).v.to((0.5, 0.95).v, dt),
                (1.0, 0.82).v.to((1.0, 1.0).v, dt), //
              ],
              colors: [
                null, null, null, //

                C.lightGreen[500]
                    ?.withOpacity(0.8)
                    .to(const Color.fromARGB(251, 147, 15, 15), dt),
                C.lightGreen[200]
                    ?.withOpacity(0.8)
                    .to(const Color.fromARGB(251, 225, 62, 62), dt),
                C.lightGreen[400]
                    ?.withOpacity(0.90)
                    .to(const Color.fromARGB(251, 222, 89, 89), dt), //

                C.green[900].to(const Color.fromARGB(224, 205, 89, 7), dt),
                C.green[800]
                    ?.withOpacity(0.98)
                    .to(const Color.fromARGB(255, 234, 100, 27), dt),
                C.green[900].to(const Color.fromARGB(255, 244, 126, 0), dt), //

                null, null, null, //
              ],
            ),
          );
        },
      ),
    );
  }
}

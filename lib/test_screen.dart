import 'package:flutter/material.dart';

class TestScr extends StatefulWidget {
  const TestScr({super.key});

  @override
  State<TestScr> createState() => _TestScrState();
}

class _TestScrState extends State<TestScr> {
  @override
  Widget build(BuildContext context) {
    void test() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(''),
          shape: CustomShapeBorder(2),
        ),
      );
      print('fon');
    }

    void test1() {
      ScaffoldMessenger(
        child: SnackBar(
          backgroundColor: Colors.red,
          content: Text('afgaglkdfjfiahfopafjdfafaf'),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('data'),
              ElevatedButton(
                onPressed: () {
                  test();
                },
                child: Container(
                  color: Colors.green,
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomShapeBorder extends ShapeBorder {
  final double borderRadius;
  CustomShapeBorder(this.borderRadius);

  @override
  //  implement dimensions
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.symmetric(horizontal: 20, vertical: 10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    //  implement getInnerPath
    return Path()
      ..addPath(
        Path.combine(
          PathOperation.xor,
          Path()
            ..moveTo(20, 20)
            ..lineTo(30, 30)
            ..lineTo(40, 40)
            ..close(),
          Path()
            ..moveTo(40, 40)
            ..lineTo(50, 50)
            ..lineTo(60, 60)
            ..close(),
        ),
        Offset(0, 0),
      );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    //  implement getOuterPath
    throw UnimplementedError();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    //  implement paint
  }

  @override
  ShapeBorder scale(double t) {
    //  implement scale
    throw UnimplementedError();
  }
}

import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OpArt Project'),
      ),
        body: Container(
          child: LayoutBuilder(
            builder: (_, constraints) => Container(
              width: constraints.widthConstraints().maxWidth,
              height: constraints.heightConstraints().maxHeight,
              color: Colors.white,

              child: CustomPaint(painter: OpArtPainter()),

            ),
          ),
        ),
    );
  }
}

class OpArtPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // define the paint object

    double canvasWidth = size.width;
    double canvasHeight = size.height;

    print('width: ${canvasWidth}');
    print('height: ${canvasHeight}');

    double trunkWidth = 40.0;
    double widthDecay = 0.92;
    double segmentLength = 50.0;
    double segmentDecay = 0.92;
    double direction = pi / 2;

    double lineWidth = 2;
    Color trunkColor = Colors.green;

    int maxDepth = 10;

    List treeBaseA = [(canvasWidth-trunkWidth)/2, canvasHeight];
    List treeBaseB = [(canvasWidth+trunkWidth)/2, canvasHeight];

    drawSegment(canvas, treeBaseA, treeBaseB, trunkWidth, widthDecay, segmentLength, segmentDecay, direction, 0, maxDepth, lineWidth, trunkColor);


  }

  drawSegment(
      Canvas canvas,
      List rootA,
      List rootB,
      double width,
      double widthDecay,
      double segmentLength,
      double segmentDecay,
      double direction,
      int currentDepth,
      int maxDepth,
      double lineWidth,
      Color trunkColor,
      )
  {
    List segmentBaseCentre = [(rootA[0] + rootB[0]) / 2, (rootA[1] + rootB[1]) / 2];

    //grow
    List PD = [segmentBaseCentre[0] + segmentLength * cos(direction), segmentBaseCentre[1] - segmentLength * sin(direction)];
    List P2 = [PD[0] + 0.5 * width * widthDecay * sin(direction), PD[1] + 0.5 * width * widthDecay * cos(direction)];
    List P3 = [PD[0] - 0.5 * width * widthDecay * sin(direction), PD[1] - 0.5 * width * widthDecay * cos(direction)];

    // draw the trunk
    drawTheTrunk(canvas, rootB, P2, P3, rootA, 0.0, PaintingStyle.stroke, lineWidth, trunkColor);

    // next
    if (currentDepth < maxDepth) {
      drawSegment(canvas, P3, P2, width * widthDecay, widthDecay, segmentLength * segmentDecay, segmentDecay, direction, currentDepth+1, maxDepth, lineWidth, trunkColor);
    }


  }


  drawTheTrunk(
      Canvas canvas,
      List P1,
      List P2,
      List P3,
      List P4,
      double bulbousness,
      var style,
      double strokeWidth,
      Color color,
      )
  {

    Path trunk = Path();
    trunk.moveTo(P1[0], P1[1]);
    trunk.lineTo(P2[0], P2[1]);
    trunk.lineTo(P3[0], P3[1]);
    trunk.lineTo(P4[0], P4[1]);
    trunk.close();

    canvas.drawPath(
        trunk,
        Paint()
      ..style = style
      ..strokeWidth = strokeWidth
      ..color = color
    );

  }




  @override
  bool shouldRepaint(OpArtPainter oldDelegate) => false;
}
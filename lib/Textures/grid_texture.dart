import 'dart:math';
import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final double cellSize;  // расстояние между параллельными линиями (перпендикуляр)
  final Color lineColor1;
  final Color lineColor2;
  final double lineWidth;
  final int amountBigSquare;
  final int lengthBetweenBS;

  GridPainter({
    this.cellSize = 30,
    this.lineColor1 = Colors.grey,
    this.lineColor2 = Colors.black,
    this.lineWidth = 6,
    this.amountBigSquare = 1,
    this.lengthBetweenBS = 3
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintBackColor = Paint()
      ..strokeWidth = lineWidth * 0.5
      ..color = lineColor1;
    final paintFatLine = Paint()
      ..strokeWidth = lineWidth * 2
      ..color = lineColor2;
    final paintMediumLine = Paint()
      ..strokeWidth = lineWidth
      ..color = lineColor2;
    
    _drawGrid(canvas, size, 2, 25, 0.75, 50, 0, paintBackColor, false);
    _drawGrid(canvas, size, 1, 0, 1.25, 0, 0, paintMediumLine, false);
    _drawGrid(canvas, size, 2, 75, 2, 212, -350, paintFatLine, true);

    
  }

  void _drawGrid(Canvas canvas, Size size, int lines, double distance, double cellMul, double moveX, double moveY, Paint paint, bool fat)
  {
    for (double x = 0; x < size.width; x += cellSize * cellMul)
    {
      if ((!fat || (x > lengthBetweenBS)) && (!fat || (x < cellSize * amountBigSquare * 3 * cellMul)))
      {if (lines == 1)
      {
        canvas.drawLine(Offset(x + moveX, 0), Offset(x + moveX, size.height), paint);
      }
      else
      {
        double realDistance = 0;
        
        for (int i = 0; i < lines; i++)
        {
          canvas.drawLine(Offset(x + realDistance + moveX, 0), Offset(x + realDistance + moveX, size.height), paint);
          realDistance = distance;
        }
      }}
    }

    for (double y = 0; y < size.height; y += cellSize * cellMul)
    {
      if ((!fat || (y > lengthBetweenBS * cellMul)) && (!fat || (y < cellSize * amountBigSquare * 2 * cellMul)))
      {if (lines == 1)
      {
        canvas.drawLine(Offset(0, y + moveY), Offset(size.width, y + moveY), paint);
      }
      else
      {
        double realDistance = 0;
        
        for (int i = 0; i < lines; i++)
        {
          canvas.drawLine(Offset(0, y + realDistance + moveY), Offset(size.width, y + realDistance + moveY), paint);
          realDistance = distance;
        }
      }}
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


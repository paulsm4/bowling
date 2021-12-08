import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import './scoring_engine.dart';

class DisplayScores extends StatelessWidget {
  final ScoringEngine _gameState;

  DisplayScores(this._gameState);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        children: _mkFrames()
      ),
    );
  }

  List<Widget> _mkFrames() {
    List<Widget> frames = [];
    
    for (int i=0, iball=0; i < ScoringEngine.nFrames; i++) {
      String score = 
        (i < _gameState.frameScores.length) ? _gameState.frameScores[i].toString() :  "";
      double w, h= 65.0;
      List<String> balls;
      if (i < ScoringEngine.nFrames-1){
        w = 50.0;
        balls = [_gameState.throws[iball++], _gameState.throws[iball++]];
      } else {
        w = 65.0;
        balls = [_gameState.throws[iball++], _gameState.throws[iball++], _gameState.throws[iball++]];
      }
      frames.add(Container(
        width: w,
        height: h,
        decoration: _CustomDecoration(
          balls,
          score, 
          i+1),
        ),
      );
    }
    return frames;
  }
}

class _CustomDecoration extends Decoration {

  final List<String> _balls;
  final String _score;
  final int _frame;

  _CustomDecoration(this._balls, this._score, this._frame);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomDecorationPainter(_balls, _score, _frame);
  }
}

class _CustomDecorationPainter extends BoxPainter {
  final List<String> _balls;
   final String _score;
  final int _frame;

  _CustomDecorationPainter(this._balls, this._score, this._frame);


  void _paintFrame (Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Size size = configuration.size ?? Size(0,0);
    double topBarHeight = 15.0;
    size = Size(size.width, size.height - topBarHeight);
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw frame border
    Offset offset2 = Offset(offset.dx, offset.dy + topBarHeight);
    canvas.drawRect(offset2 & size, paint);

    // Draw balls border
    Size size2 = Size(size.width * (2.0/3.0), size.height/2.0);
    offset2 = Offset(offset2.dx + (size.width / 3.0), offset2.dy);
    canvas.drawRect(offset2 & size2, paint);
    offset2 = Offset(offset2.dx + (size2.width / 2.0), offset2.dy);
    Offset offset3 = Offset(offset2.dx, offset2.dy+size2.height);
    canvas.drawLine(offset2, offset3, paint);

    // Draw Frame#
    Offset offset4 = Offset(offset.dx + (size.width / 2.0), offset.dy);
    var ts = TextStyle(
      color: Colors.blue,
      fontSize: 14 );
    var tp = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign:TextAlign.center
    );
    tp.text = TextSpan(text: _frame.toString(), style: ts);
    tp.layout();
    tp.paint (canvas, offset4);

    // Draw balls text
    ts = TextStyle(
      color: Colors.red,
      fontSize: 12 );
    tp = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign:TextAlign.center
    );
    offset2 = Offset(offset2.dx, offset.dy + topBarHeight + 5.0);
    tp.text = TextSpan(text: _balls[0].toString(), style: ts);
    tp.layout();
    tp.paint (canvas, new Offset(offset2.dx - (size2.width / 2.0) + 5.0, offset2.dy));
    tp.text = TextSpan(text: _balls[1].toString(), style: ts);
    tp.layout();
    tp.paint (canvas, new Offset(offset2.dx + 5.0, offset2.dy));

    // Draw scores
    ts = TextStyle(
     color: Colors.black,
     fontSize: 18);
    tp.text = TextSpan(text: _score.toString(), style: ts);
    tp.layout();
    tp.paint (canvas, new Offset(offset.dx + 10.0, offset.dy + topBarHeight + 30.0));
  }
  
  void _paint10thFrame (Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Size size = configuration.size ?? Size(0,0);
    double topBarHeight = 15.0;
    size = Size(size.width, size.height - topBarHeight);
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw frame border
    Offset offset2 = Offset(offset.dx, offset.dy + topBarHeight);
    canvas.drawRect(offset2 & size, paint);

    // Draw balls border
    Size size2 = Size(size.width * (2.0/3.0), size.height/2.0);
    offset2 = Offset(offset2.dx + (size.width/ 3.0), offset2.dy);
    canvas.drawRect(offset2 & size2, paint);
    offset2 = Offset(offset2.dx + (size2.width / 3.0), offset2.dy);
    Offset offset3 = Offset(offset2.dx, offset2.dy+size2.height);
    canvas.drawLine(offset2, offset3, paint);
    offset2 = Offset(offset2.dx + (size2.width / 3.0), offset2.dy);
    offset3 = Offset(offset2.dx, offset2.dy+size2.height);
    canvas.drawLine(offset2, offset3, paint);

    // Draw Frame#
    Offset offset4 = Offset(offset.dx + (size.width / 2.0), offset.dy);
    var ts = TextStyle(
      color: Colors.blue,
      fontSize: 14 );
    var tp = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign:TextAlign.center
    );
    tp.text = TextSpan(text: _frame.toString(), style: ts);
    tp.layout();
    tp.paint (canvas, offset4);

    // Draw balls text
    ts = TextStyle(
      color: Colors.red,
      fontSize: 12 );
    offset2 = Offset(offset2.dx + 4.0, offset.dy + topBarHeight + 5.0);
    tp.text = TextSpan(text: _balls[0].toString(), style: ts);
    tp.layout();
    tp.paint (canvas, new Offset(offset2.dx - (2.0 * size2.width / 3.0), offset2.dy));
    tp.text = TextSpan(text: _balls[1].toString(), style: ts);
    tp.layout();
    tp.paint (canvas, new Offset(offset2.dx - (size2.width / 3.0), offset2.dy));
    tp.text = TextSpan(text: _balls[2].toString(), style: ts);
    tp.layout();
    tp.paint (canvas, new Offset(offset2.dx, offset2.dy));

    // Draw scores
    ts = TextStyle(
      color: Colors.black,
      fontSize: 18);
    tp.text = TextSpan(text: _score.toString(), style: ts);
    tp.layout();
    tp.paint (canvas, new Offset(offset.dx + 20.0, offset.dy + topBarHeight + 30.0));
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    if (_frame == ScoringEngine.nFrames)
      _paint10thFrame(canvas, offset, configuration);
    else
      _paintFrame(canvas, offset, configuration);
  }
}

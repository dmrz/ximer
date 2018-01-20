import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProgressCard extends StatefulWidget {
  ProgressCard({Key key, this.loop}) : super(key: key);

  final Map loop;

  @override
  _ProgressCardState createState() => new _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  final int _tick = 10;
  double _progress = 0.0;
  Timer _timer;
//  int _currentLoop = 0;

//  void _startTimerOld() {
//    Duration ms10 = new Duration(milliseconds: _tick);
//    print('Starting timer');
//    num current = 0;
//    _timer = new Timer.periodic(ms10, (timer) {
//      Map loop = _loops[_currentLoop];
//      // print('$_progress, ${loop['delay']}, $current');
//      if (loop['delay'] < current + 1) {
//        current = 0;
//        int nextLoop = _currentLoop < _loops.length - 1 ? _currentLoop + 1 : 0;
//        setState(() {
//          _progress = 0.0;
//          _currentLoop = nextLoop;
//        });
//      } else {
//        current += _tick;
//        setState(() {
//          _progress += _tick / loop['delay'];
//        });
//      }
//    });
//  }

  void _startTimer() {
    Duration ms10 = new Duration(milliseconds: _tick);
    print('Starting timer for ${widget.loop['data']}');
    num current = 0;
    _timer = new Timer.periodic(ms10, (timer) {
      if (widget.loop['delay'] < current + 1) {
        current = 0;
        setState(() {
          _progress = 0.0;
        });
      } else {
        current += _tick;
        setState(() {
          _progress += _tick / widget.loop['delay'];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    int delaySeconds = (widget.loop['delay'] / 1000).toInt();
    return new Card(
      child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
                leading: const Icon(Icons.album),
                title: new Text(widget.loop['data']),
                subtitle: new Text('Progress for $delaySeconds ${Intl.plural(delaySeconds, one: 'second', other: 'seconds')}'),
                trailing: new CircularProgressIndicator(
                    value: _progress,
                    valueColor: new AlwaysStoppedAnimation<Color>(widget.loop['color']),
                    strokeWidth: 7.0
                ),
            ),
            new ButtonTheme.bar(
              child: new ButtonBar(
                children: <Widget>[
                  new FlatButton(
                      child: const Text('Start'),
                      onPressed: () {}
                  ),
                  new FlatButton(
                      child: const Text('Stop'),
                      onPressed: () {}
                  )
                ],
              ),
            )
          ]
      ),
    );
  }
}
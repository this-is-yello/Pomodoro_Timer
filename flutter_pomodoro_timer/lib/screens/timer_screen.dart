import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_pomodoro_timer/main.dart';
import 'package:flutter_pomodoro_timer/tools/utils.dart';


enum TimerStatus { running, paused, stopped, resting }

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}
class _TimerScreenState extends State<TimerScreen> {
  static const WORK_SECONDS = 25; // *60
  static const REST_SECONDS = 5; // *60

  late TimerStatus _timerStatus;
  late int _timer;
  late int _pomodoroCount;

  @override
  void initState() {
    super.initState();
    _timerStatus = TimerStatus.stopped;
    print(_timerStatus.toString());
    _timer = WORK_SECONDS;
    _pomodoroCount = 0;
  }

  void run() {
    setState(() {
      _timerStatus = TimerStatus.running;
      print('[=>]' + _timerStatus.toString());
      runTimer();
    });
  }
  void rest() {
    setState(() {
      _timer = REST_SECONDS;
      _timerStatus = TimerStatus.resting;
      print('[=>]' + _timerStatus.toString());
    });
  }
  void paused() {
    setState(() {
      _timerStatus = TimerStatus.paused;
      print('[=>]' + _timerStatus.toString());
    });
  }
  void resume() {
    run();
  }
  void stop() {
    setState(() {
      _timer = WORK_SECONDS;
      _timerStatus = TimerStatus.stopped;
      print('[=>]' + _timerStatus.toString());
    });
  }
  
  void runTimer() async {
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      switch (_timerStatus) {
        case TimerStatus.paused:
          t.cancel();
          break;
        case TimerStatus.stopped:
          t.cancel();
          break;
        case TimerStatus.running:
          if (_timer <= 0) {
            showToast("작업완료!");
            rest();
          } else {
            setState(() {
              _timer -= 1;
            });
          }
          break;
        case TimerStatus.resting:
          if (_timer <= 0) {
            setState(() {
              _pomodoroCount += 1;
            });
            showToast('오늘 $_pomodoroCount 개의 뽀모도로를 달성했습니다.');
            t.cancel();
            stop();
          } else {
            setState(() {
              _timer -= 1;
            });
          }
          break;
        default:
        break;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final List<Widget> _runningButtons = [
      ElevatedButton(
        child: Text(
          1 == 2 ? '계속하기' : '일시정지',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(primary: Colors.blue),
        onPressed: () {},
      ),
      Padding(
        padding: EdgeInsets.all(20),
      ),
      ElevatedButton(
        child: Text(
          '포기하기',
          style: TextStyle(fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(primary: Colors.grey),
        onPressed: () {},
      ),
    ];
    final List<Widget> _stoppedButtons = [
      ElevatedButton(
        child: Text(
          '시작하기',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          primary: 1 == 2 ? Colors.green : Colors.blue,
        ),
        onPressed: () {},
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('뽀모도로 타이머'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Center(
              child: Text(
                '00:00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: 1 == 2 ? Colors.green : Colors.blue,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: 1 == 2
              ? const[]
              : 1 == 2
                ? _stoppedButtons
                : _runningButtons,
          )
        ],
      ),
    );
  }
}
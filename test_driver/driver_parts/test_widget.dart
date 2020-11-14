import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({
    @required Key key,
    @required this.resultKey,
    @required this.title,
    @required this.onTapTestCase,
  }) : super(key: key);

  final String title;
  final Key resultKey;
  final Future Function() onTapTestCase;

  @override
  _State createState() => _State();
}

class _State extends State<TestWidget> {
  bool _successful;
  Exception _error;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(4)),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              const interactiveStates = <MaterialState>{
                MaterialState.disabled,
              };
              if (states.any(interactiveStates.contains)) {
                return Colors.greenAccent[400];
              }
              return Colors.blue;
            }),
            textStyle: MaterialStateProperty.all(
              const TextStyle(color: Colors.white),
            ),
          ),
          onPressed: _successful == false
              ? () async {
                  try {
                    await widget.onTapTestCase();
                    setState(() {
                      _successful = true;
                    });
                  } on Exception catch (e) {
                    setState(() {
                      _successful = false;
                      _error = e;
                    });
                  }
                  await Future<void>.delayed(
                      const Duration(milliseconds: 3000));
                }
              : null,
          child: Text(
            _successful == null
                ? widget.title
                : _successful == true
                    ? 'OK'
                    : 'NG',
            key: widget.resultKey,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        _error != null
            ? Text(_error.toString(), style: const TextStyle(color: Colors.red))
            : const SizedBox.shrink(),
      ],
    );
  }
}

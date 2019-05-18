# Afghan Datepicker

A Dari/Pashto datepicker package for flutter.

### Installation

Add this to your package's pubspec.yaml file:
```sh 
dependencies: 
    afghan_datepicker: ^0.1.0
```

### Usage

**main.dart**

```sh
import 'package:flutter/material.dart';
import 'package:afghan_datepicker/afghan_datepicker.dart';

void main() {
  runApp(Home());
}

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  final TextEditingController textEditingController = TextEditingController();

  AfghanDatePickerWidget afghanDatePicker;

  @override
  void initState() {
    afghanDatePicker = AfghanDatePicker(
        controller: textEditingController,
        locale: 'fa',
        farsiDigits: true
    ).init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Afghan Datepicker'),
        ),
        body: Builder(builder: (BuildContext context) {
          return Material(
            child: Container(
              child: TextField(
                enableInteractiveSelection: false,
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: afghanDatePicker),
                      );
                    },
                  );
                },
                controller: textEditingController,
              ),
            ),
          );
        }),
      ),
    );
  }
}
```

### HOW IT LOOKS

![](fa.png)

![](ps.png)


### Credits
https://github.com/Ali-Azmoud/persian_datepicker

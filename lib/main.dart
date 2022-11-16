// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  double age = 0.0;
  var selectedyear;
  late Animation animation;
  AnimationController? animationController;
  @override
  void initState() {
    // TODO: implement initState
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animation = animationController!;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController!.dispose();
    super.dispose();
  }

  void _showpicker() {
    showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((DateTime) {
      selectedyear = DateTime?.year;
      calculateAge();
    });
  }

  void calculateAge() {
    setState(() {
      age = (2022 - selectedyear).toDouble();
      animation = Tween<double>(begin: animation.value, end: age).animate(
          CurvedAnimation(
              parent: animationController!, curve: Curves.fastOutSlowIn));
      animation.addListener(() {
        setState(() {});
      });
      animationController!.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("Age Calculator")),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _showpicker();
                    },
                    child: Text(selectedyear != null
                        ? selectedyear.toString()
                        : "Select your year of birth")),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Your age is ${animation.value.toStringAsFixed(0)}",
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

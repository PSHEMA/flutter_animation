import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimationExample(),
    );
  }
}

class AnimationExample extends StatefulWidget {
  @override
  _AnimationExampleState createState() => _AnimationExampleState();
}

class _AnimationExampleState extends State<AnimationExample> with SingleTickerProviderStateMixin{
  
  late AnimationController _controller;
  late Animation<Offset> _movementAnimation;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this
    );

    //Movement along a path
    _movementAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(2.0, 0.0)
    ).animate(
      CurvedAnimation(
      parent: _controller, 
      curve: Curves.easeInOut),
    );

    //Size transformation
    _sizeAnimation = Tween<double>(
      begin: 50,
      end: 150,
    ).animate(
      CurvedAnimation(
      parent: _controller, 
      curve: Curves.easeInOut),
    );

    //Color transitions
    _colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.blue
    ).animate(
      CurvedAnimation(
      parent: _controller, 
      curve: Curves.easeInOut
      ),
    );
}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animate() {
    if(_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Animation'),
      ),
       body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: _movementAnimation.value,
              child: Container(
                width: _sizeAnimation.value,
                height: _sizeAnimation.value,
                color: _colorAnimation.value,
                child: Center(
                  child: Text(
                    'Animate Me!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animate,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
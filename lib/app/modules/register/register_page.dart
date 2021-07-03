import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final String title;
  const RegisterPage({Key? key, this.title = 'RegisterPage'}) : super(key: key);
  @override
  RegisterPageState createState() => RegisterPageState();
}
class RegisterPageState extends State<RegisterPage> {

  late PageController _pageController;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _nameController = TextEditingController();
    _nameController.addListener(() {

    });

    _emailController = TextEditingController();


    _passwordController = TextEditingController();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PageView(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          _FormField(
            controller: _nameController,
            label: 'Qual é o seu nome?',
            showsBackButton: false,
            onNext: () {
              _pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
            },
            onBack: () {
              _pageController.previousPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
            },
          ),
          _FormField(
            controller: _emailController,
            label: '...e seu email?',
            showsBackButton: false,
            onNext: () {
              _pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
            },
            onBack: () {
              _pageController.previousPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
            },
          ),
          _FormField(
            controller: _passwordController,
            label: 'Agora, digite uma senha...',
            showsBackButton: false,
            onNext: () {
              _pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
            },
            onBack: () {
              _pageController.previousPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
            },
          ),
        ],
      ),
    );
  }
}

class _FormField extends StatelessWidget {

  final TextEditingController controller;
  final bool showsBackButton;
  final String label;
  final VoidCallback onNext;
  final VoidCallback onBack;
  _FormField({required this.controller, this.showsBackButton = true, required this.label, required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showsBackButton ? IconButton(
              icon: Icon(Icons.arrow_upward),
              onPressed: () {},
            ) : SizedBox.fromSize(size: Size.zero),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(label, style: TextStyle(fontSize: 22),),
                    TextFormField(
                      controller: controller,
                      onEditingComplete: onNext,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }

}
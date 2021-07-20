import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:samsgram/app/constants.dart';
import 'package:samsgram/app/modules/register/register_store.dart';

class RegisterPage extends StatefulWidget {
  final String title;
  const RegisterPage({Key? key, this.title = 'Tela de Cadastro'}) : super(key: key);
  @override
  RegisterPageState createState() => RegisterPageState();
}
class RegisterPageState extends ModularState<RegisterPage, RegisterStore> {

  late PageController _pageController;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final ReactionDisposer _disposer;

  @override void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _disposer = when(
            (_) => store.user != null,
            () => Modular.to.pushReplacementNamed(Constants.Routes.HOME));
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  late final Widget _form = PageView(
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
          store.registerUser(
              name:_nameController.text,
              email: _emailController.text,
              password:_passwordController.text
          );
        },
        onBack: () {
          _pageController.previousPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(
        builder: (_) {
          if (store.loading) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text ('Aguarde... estamos salvando seu cadastro!')
              ],
            );
          }
          return _form;
        },
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
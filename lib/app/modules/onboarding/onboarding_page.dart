import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:samsgram/app/modules/onboarding/onboarding_store.dart';

import '../../constants.dart';

class OnboardingPage extends StatefulWidget {
  final String title;
  const OnboardingPage({Key? key, this.title = 'Samsgram'}) : super(key: key);
  @override
  OnboardingPageState createState() => OnboardingPageState();
}
class OnboardingPageState extends ModularState<OnboardingPage, OnboardingStore> {

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: [
            _OnboardingItem(
                image: AssetImage('assets/social.png'),
                text: 'Conecte-se com amigos e faça novas amizades!'),
            _OnboardingItem(
                image: AssetImage('assets/notific.png'),
                text: 'Compartilhe suas novidades e...'),
            _OnboardingItem(
              image: AssetImage('assets/login.png'),
              text: '... crie um perfil que seja a sua cara!',
              child: Column(
                children: [
                  ElevatedButton(
                    child: Text('CADASTRE-SE'),
                    onPressed: () {
                      store.markOnboardingDone();
                    Modular.to.pushReplacementNamed(Constants.Routes.REGISTER);
                    },
                  ),
                  TextButton(
                      child: Text('Já possui cadastro?'),
                      onPressed: () {
                        store.markOnboardingDone();
                      Modular.to.pushReplacementNamed(Constants.Routes.LOGIN);
                      }
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _OnboardingItem extends StatelessWidget {

  final ImageProvider image;
  final String text;
  final Widget? child;

  _OnboardingItem({required this.image, required this.text, this.child});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 16,
          bottom: MediaQuery.of(context).padding.bottom + 96
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Image(
                image: image,
                fit: BoxFit.fitWidth),
          ),
          Flexible(
              child: Text(
                text,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),)),
          child ?? SizedBox.fromSize(size: Size.zero),
        ],
      ),
    );
  }

}
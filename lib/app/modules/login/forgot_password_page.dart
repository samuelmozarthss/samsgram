import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:samsgram/app/constants.dart';
import 'package:samsgram/app/modules/login/login_store.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String title;
  const ForgotPasswordPage({Key? key, this.title = 'Esqueceu a senha?'}) : super(key: key);
  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}
class ForgotPasswordPageState extends ModularState<ForgotPasswordPage, LoginStore> {

  late final TextEditingController _emailControler;

  @override
  void initState() {
    super.initState();
    _emailControler = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child:ListView(
            children: <Widget> [
            Text('Não tem problema', style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 32),),
            Image.asset('assets/fpassword.png'),
            Text('Vamos te enviar um link para redefinir...', style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 18),),
            TextFormField(
              controller: _emailControler,
              decoration: InputDecoration(
              labelText: 'Qual é o seu e-mail?'
                ),
              ),
            SizedBox(
              height: 24,
            ),
            ElevatedButton(
                child: Text('REDEFINIR SENHA'),
                onPressed: () {
                  store.resetPassword(withEmail: _emailControler.text)
                      .then((_) {
                        showDialog(context: context, builder: (_) {
                          return AlertDialog(
                            title: Text('E-mail enviado com sucesso!'),
                            content: Text('Siga as instruções que foram enviadas para o seu e-mail.'),
                            actions: [
                              ElevatedButton(
                                 onPressed: () {
                                  Modular.to.pop();
                                  Modular.to.pop();
                                 }, child: Text('OK'))
                            ],
                          );
                        });
                  });
                }),
          ],
        ),
      ),
    );
  }
}
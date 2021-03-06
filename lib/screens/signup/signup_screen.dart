import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/helpers/validators.dart';
import 'package:loja_virtual_pro/models/user.dart';
import 'package:loja_virtual_pro/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final User user = User(email: '', password: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(builder: (_, userManager, __) {
              return ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Nome Completo'),
                    enabled: !userManager.loading,
                    validator: (name) {
                      if (name!.isEmpty)
                        return 'Campo obrigatório';
                      else if (name.trim().split(' ').length <= 1)
                        return 'Preencha seu Nome completo';
                      return null;
                    },
                    onSaved: (name) => user.name = name,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'E-mail'),
                    enabled: !userManager.loading,
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email!.isEmpty)
                        return 'Campo obrigatório';
                      else if (!emailValid(email)) return 'E-mail inválido';
                      return null;
                    },
                    onSaved: (email) => user.email = email!,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Senha'),
                    enabled: !userManager.loading,
                    obscureText: true,
                    validator: (pass) {
                      if (pass!.isEmpty)
                        return 'Campo obrigatório';
                      else if (pass.length < 6) return 'Senha muito curta';
                      return null;
                    },
                    onSaved: (pass) => user.password = pass!,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Repita a Senha'),
                    enabled: !userManager.loading,
                    obscureText: true,
                    validator: (pass) {
                      if (pass!.isEmpty)
                        return 'Campo obrigatório';
                      else if (pass.length < 6) return 'Senha muito curta';
                      return null;
                    },
                    onSaved: (pass) => user.confirmPassword = pass,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        onSurface:
                            Theme.of(context).primaryColor.withAlpha(100),
                        onPrimary: Colors.white,
                        elevation: 5,
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      onPressed: userManager.loading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();

                                if (user.password != user.confirmPassword) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Senhas não coincidem!',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                context.read<UserManager>().signUp(
                                      user: user,
                                      onSuccess: () {
                                        Navigator.of(context).pop();
                                      },
                                      onFail: (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Falha ao cadastrar: $e',
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      },
                                    );
                              }
                            },
                      child: userManager.loading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : const Text(
                              'Criar Conta',
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

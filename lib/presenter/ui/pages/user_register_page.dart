import 'dart:developer';
import 'dart:io';

import 'package:famplay/domain/helper/form_helper.dart';
import 'package:famplay/domain/helper/messages.dart';
import 'package:famplay/presenter/ui/constants/constants.dart';
import 'package:famplay/presenter/ui/famplay_icon.dart';
import 'package:famplay/presenter/ui/widget/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validatorless/validatorless.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final userEC = TextEditingController();
  final passwordEC = TextEditingController();
  File? picture;
  bool obscuredText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.orange,
      appBar: const AppBarWidget(
        title: 'Nova conta',
        showBack: true,
        showLogoff: false,
        color: ColorsConstants.white,
        backgroundColor: ColorsConstants.orange,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: Image.asset(ImageConstants.orangeBg).image,
          ),
        ),
        child: Form(
          key: formKey,
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 30, left: 15, right: 15, top: 15),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nome',
                    style: TextStyle(
                      color: ColorsConstants.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(
                      color: ColorsConstants.brown,
                      fontWeight: FontWeight.w900,
                    ),
                    keyboardType: TextInputType.text,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.deny(
                        RegExp(r'[0-9!@#$%^&*(),.?":{}|<>_+=\\/;]'),
                      ),
                    ],
                    onTapOutside: (_) => unfocus(context),
                    validator: Validatorless.multiple([
                      Validatorless.required('Nome é obrigatório'),
                      Validatorless.regex(
                          RegExp(r"[A-Za-z]",
                              multiLine: true,
                              caseSensitive: false,
                              dotAll: true),
                          'Nome inválido, favor preencher corretamente.'),
                    ]),
                    controller: nameEC,
                    decoration: const InputDecoration(
                      hintText: 'Digite o nome',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintStyle: TextStyle(
                        color: ColorsConstants.wine,
                        fontWeight: FontWeight.w900,
                      ),
                      errorMaxLines: 2,
                      errorStyle: TextStyle(
                        color: ColorsConstants.yellow,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Nome de Usuário',
                    style: TextStyle(
                      color: ColorsConstants.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(
                      color: ColorsConstants.brown,
                      fontWeight: FontWeight.w900,
                    ),
                    onTapOutside: (_) => unfocus(context),
                    validator: Validatorless.multiple([
                      Validatorless.required('Nome de Usuário é obrigatório'),
                      Validatorless.min(4,
                          'Nome de Usuário deve ter pelo menos 4 caracteres'),
                    ]),
                    controller: userEC,
                    decoration: const InputDecoration(
                      hintText: 'Digite o nome de usuário',
                      hintStyle: TextStyle(
                        color: ColorsConstants.wine,
                        fontWeight: FontWeight.w900,
                      ),
                      errorStyle: TextStyle(
                        color: ColorsConstants.yellow,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Senha',
                    style: TextStyle(
                      color: ColorsConstants.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextFormField(
                    obscureText: obscuredText,
                    style: const TextStyle(
                      color: ColorsConstants.brown,
                      fontWeight: FontWeight.w900,
                    ),
                    onTapOutside: (_) => unfocus(context),
                    validator: Validatorless.required('Senha é obrigatória'),
                    controller: passwordEC,
                    decoration: InputDecoration(
                      hintText: 'Digite a senha',
                      hintStyle: const TextStyle(
                        color: ColorsConstants.wine,
                        fontWeight: FontWeight.w900,
                      ),
                      errorStyle: const TextStyle(
                        color: ColorsConstants.yellow,
                        fontWeight: FontWeight.w900,
                      ),
                      suffixIcon: IconButton(
                        padding: const EdgeInsets.only(right: 10),
                        icon: Icon(
                          obscuredText
                              ? FamplayIcons.eye
                              : FamplayIcons.eyeSlash,
                          color: ColorsConstants.wine,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            obscuredText = !obscuredText;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case (false || null):
                          Messages.showError(
                            'Existem campos inválidos',
                            context,
                          );
                        case true:
                          log("Cadastrou");
                        // login(emailEC.text, passwordEC.text);
                      }
                    },
                    child: const Text(
                      'Salvar',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:comunidade_digital/services/request.dart';
import 'package:comunidade_digital/shared_components/display_alert.dart';
import 'package:comunidade_digital/shared_components/project_config.dart';
import 'package:comunidade_digital/shared_components/rounded_button.dart';
import 'package:comunidade_digital/shared_components/rounded_input_field.dart';
import 'package:comunidade_digital/shared_components/uf_to_state.dart';
import 'package:comunidade_digital/shared_components/extensions_string.dart';
import 'package:comunidade_digital/shared_components/validate_cpf.dart';
import 'package:comunidade_digital/shared_components/validate_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../home.dart';
import 'background.dart';

class Body extends StatefulWidget {

  @override
  _Body createState() => _Body();

  final User user;
  var cpf;
  var cep;
  Body({Key key, @required this.user}) : super(key: key);

}

class _Body extends State<Body> with AutomaticKeepAliveClientMixin<Body>{

  var _addressFieldsVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var emailController = TextEditingController(); emailController.text = this.widget.user.email;
    var nameController = TextEditingController(); nameController.text = this.widget.user.displayName;
    var cpfController = TextEditingController(); cpfController.text = this.widget.cpf;
    var cepController = TextEditingController(); cepController.text = this.widget.cep;
    var homeNumberController = TextEditingController();
    var logradouroController = TextEditingController();
    var cidadeController = TextEditingController();
    var estadoController = TextEditingController();
    var bairroController = TextEditingController();
    Map<String, dynamic> localizationData = null;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Text(
              "BEM VINDO AO APP COMUNIDADE DIGITAL",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "FAÇA SEU CADASTRO ABAIXO",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    this.widget.user.photoURL
                ),
              ),
            ),
            RoundedInputField(
              icon: Icons.email,
              controller: emailController,
              hintText: "Seu E-mail",
              readOnly: this.widget.user.email != null ? true : false,
              backgroundColor: disabledButtons,
            ),
            RoundedInputField(
              controller: nameController,
              icon: Icons.person,
              hintText: "Seu Nome",
            ),
            RoundedInputField(
                controller: cpfController,
                icon: Icons.assignment_ind,
                inputFormatters: new MaskTextInputFormatter(mask: '###.###.###-##', filter: { "#": RegExp(r'[0-9]') }),
                hintText: "CPF"
            ),
            RoundedInputField(
              controller: cepController,
              icon: Icons.edit_location,
              hintText: "CEP",
              inputFormatters: new MaskTextInputFormatter(mask: '#####-###', filter: { "#": RegExp(r'[0-9]') }),
              onChanged: (value) => {
                if(value.length == 9){
                  getRequest("https://viacep.com.br/ws/$value/json/").then((response) => {
                    localizationData = jsonDecode(response.body),
                    if(localizationData["erro"] != null){
                      displayAlert(context, "Erro ao validar", [Text("O CEP informado não existe.")]),
                    }else{
                      logradouroController.text = localizationData['logradouro'],
                      cidadeController.text = localizationData['localidade'],
                      bairroController.text = localizationData['bairro'],
                      estadoController.text = ufToState(localizationData['uf']).capitalize(),
                    }
                  })
                }else{
                  localizationData = null,
                }
              },
            ),
            Visibility(
                visible: true,
                child: Column(
                  children: [
                    RoundedInputField(
                      controller: logradouroController,
                      icon: Icons.edit_location,
                      hintText: "Logradouro",
                      readOnly: true,
                      backgroundColor: disabledButtons,
                    ),
                    RoundedInputField(
                        controller: homeNumberController,
                        icon: Icons.edit_location,
                        hintText: "Nº da Casa"
                    ),
                    RoundedInputField(
                      controller: bairroController,
                      icon: Icons.location_city,
                      readOnly: true,
                      hintText: "Bairro",
                      backgroundColor: disabledButtons,
                    ),
                    RoundedInputField(
                      controller: cidadeController,
                      icon: Icons.location_city,
                      readOnly: true,
                      hintText: "Cidade",
                      backgroundColor: disabledButtons,
                    ),
                    RoundedInputField(
                      controller: estadoController,
                      icon: Icons.edit_location,
                      readOnly: true,
                      hintText: "Estado",
                      backgroundColor: disabledButtons,
                    ),
                  ],
                )
            ),
            RoundedButton(
              text: "Completar Cadastro",
              color: primaryColor,
              textColor: Colors.white,
              press: () => {
                if(!validarEmail(emailController.text)){
                  displayAlert(context, "Erro ao validar", [Text("Preencha corretamente seu e-mail antes de continuar")]),
                }else if(!validarCPF(cpfController.text)){
                  displayAlert(context, "Erro ao validar", [Text("Preencha corretamente seu CPF antes de continuar")]),
                }else if(localizationData == null || localizationData['erro'] != null){
                  displayAlert(context, "Erro ao validar", [Text("Preencha corretamente o CEP antes de continuar.")]),
                }else if(homeNumberController.text == ""){
                  displayAlert(context, "Erro ao validar", [Text("Informe o número da sua casa antes de continuar.")]),
                }else{
                  EasyLoading.show(status: 'Criando usuário'),
                  postRequest("https://us-central1-comunidade-digital.cloudfunctions.net/user-createUser",{
                    "uid": this.widget.user.uid,
                    "cpf": cpfController.text,
                    "email": emailController.text,
                    "cep": localizationData["cep"],
                    "logradouro": localizationData["logradouro"],
                    "bairro": localizationData["bairro"],
                    "localidade": localizationData["localidade"],
                    "uf": localizationData["uf"],
                    "ibge": localizationData["ibge"],
                    "homeNumber": homeNumberController.text,
                    "photoURL": this.widget.user.photoURL
                  }).then((response) => {
                    EasyLoading.dismiss(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MyHomePage();
                        },
                      ),
                    )
                  })
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
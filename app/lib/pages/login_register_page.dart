import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';

class LoginPage extends StatefulWidget{
  const LoginPage ({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async{
    try {
      await Auth().signInwithEmailAndPassword(
        email: _controllerEmail.text,
       password: _controllerPassword.text,
       );
    } on FirebaseAuthException catch (e) {
      setState((){
        errorMessage = e.message;
      });
    }
  }

Future<void> createUserWithEmailAndPassword() async{
  try {
    await Auth().createUserWithEmailAndPassword(
      email: _controllerEmail.text, 
      password: _controllerPassword.text,
    );
  } on FirebaseAuthException catch (e){
    setState(() {
      errorMessage = e.message;
    });
  }
}

    Widget _title() {
    return Center(
      child: const Text('3AL AT3A'),
    );
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      )
    );
  }

  Widget _errorMessage(){
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _submitButton(){
    return ElevatedButton(onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
     child: Text(isLogin ? 'Login' : 'Register'),
     );
  }

  Widget _loginOrRegisterButton(){
    return TextButton(
      onPressed: () {
        setState((){
          isLogin = !isLogin;
        });
      },
      child: Text (isLogin ? 'Register instead' : 'Login instead' ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: ClipOval(
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20), // Add some spacing between the image and text fields
              _entryField('email', _controllerEmail),
              _entryField('password', _controllerPassword),
              _errorMessage(),
              _submitButton(),
              _loginOrRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
}
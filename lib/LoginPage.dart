import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './HomePage/HomePage.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String _email, _password, _username;


  void displayDialog(context, title, text) => showDialog(
    context: context,
      builder: (context) =>
      AlertDialog(
          title: Text(title),
          content: Text(text)
        ),
      );
  
  Future<String> attemptLogIn(String username, String password) async {

    print(username + password);
    var res = await http.post(
      "$SERVER_DOMAIN/api/auth/login",
      body: {
        "name": username,
        "password": password
      }
    );
    print(res.body);
    if(res.statusCode == 200) return res.body;
    return null;
  }

  Future<int> attemptSignUp(String username, String email, String password) async {
    var res = await http.post(
      '$SERVER_DOMAIN/api/auth/register',
      body: {
        "name": username,
        "email": email,
        "password": password
  });
    return res.statusCode;
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 100),
          child: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'username:'
                    ),
                    validator: (input) => input.length < 4 ? 'You need at least 4 characters' : null,
                    onSaved: (input) => _username = input,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password:'
                    ),
                    validator: (input) => input.length < 6 ? 'You need at least 6 characters' : null,
                    onSaved: (input) => _password = input,
                    obscureText: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: _submitLogin,
                          child: Text('Sign in'),
                        ),
                      )
                    ],
                  )
                  /* ,Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: _submitSignup,
                          child: Text('Sign up'),
                        ),
                      )
                    ],
                  )
                 */
                ],
              ),
            ),
          ),
      ))
    );
  }

  void _submitLogin() async {
    if(formKey.currentState.validate()){
      formKey.currentState.save();

      var jwt = await attemptLogIn(_username, _password);
      if(jwt != null) {
        storage.write(key:"jwt", value: jwt);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage.fromBase64(jwt) 
          )
        );
      } else {
        displayDialog(context, "An error occured", "No account was found matching that username and password.");
      }
    }
    
  }


  void _submitSignup() async {
    if(formKey.currentState.validate()){
      formKey.currentState.save();

      var res = await attemptSignUp(_username, _email,  _password);
      if(res == 201)
        displayDialog(context, "Success", "The user was created. Log in now.");
      else if(res == 409)
        displayDialog(context, "That username is already registered", "Please try to sign up using another username or log in if you already have an account.");  
      else {
        displayDialog(context, "Error", "An unknown error occurred.");
      }
    }
  }
}

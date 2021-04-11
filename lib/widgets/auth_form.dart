import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/http_exception.dart';
import '../providers/auth.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

enum AuthState { Login, Signup }

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthState _authState = AuthState.Login;
  Map<String, String> _authData = {"email": "", "password": ""};
  final _passwordController = TextEditingController();
  AnimationController _controller;
  Animation<Offset> _positionAnimation;
  Animation<double> _doubleAnimation;
  Animation<Size> _sizeAnimation;
  bool _loading = false;
  final _inputDec = InputDecoration(
    labelStyle: TextStyle(color: Color(0xFFf05454), fontSize: 18),
  );

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _positionAnimation = Tween<Offset>(
            begin: Offset(0, -0.15), end: Offset(0, 0))
        .animate(CurvedAnimation(curve: Curves.easeInOut, parent: _controller));
    _doubleAnimation = Tween<double>(begin: 0.1, end: 0.9)
        .animate(CurvedAnimation(curve: Curves.easeIn, parent: _controller));
    _sizeAnimation = Tween<Size>(
            begin: Size(double.infinity, 350), end: Size(double.infinity, 410))
        .animate(CurvedAnimation(curve: Curves.easeIn, parent: _controller));
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState.save();
    setState(() {
      _loading = true;
    });
    try {
      if (_authState == AuthState.Login) {
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email'], _authData["password"]);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signUp(_authData['email'], _authData["password"]);
      }
    } on HttpException catch (error) {
      var errorMessage = "Authentication faild";
      if (error.toString().contains("EMAIL_EXISTS")) {
        errorMessage = "This email address is already in use.";
      } else if (error.toString().contains("INVALID_EMAIL")) {
        errorMessage = "This email is not valid.";
      } else if (error.toString().contains("WEAK_PASSWORD")) {
        errorMessage = "This password is too weak.";
      } else if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "Couldn't find a user with that email.";
      } else if (error.toString().contains("INVALID_PASSWORD")) {
        errorMessage = "Invalid password.";
      }
      _showErrorDialog(errorMessage);
    } catch (e) {
      const errorMessage = "Check your internet connection . then try again";
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _loading = false;
    });
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Some thing !"),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  child: Text("Try again"),
                  onPressed: () => Navigator.of(ctx).pop(),
                )
              ],
            ));
  }

  void _switchAuth() {
    if (_authState == AuthState.Login) {
      setState(() {
        _authState = AuthState.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authState = AuthState.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 2,
        shadowColor: Theme.of(context).accentColor,
        child: AnimatedContainer(
          height: _sizeAnimation.value.height,
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 300),
          constraints: BoxConstraints(minHeight: _sizeAnimation.value.height),
          width: deviceSize.width * 0.85,
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                    decoration: _inputDec.copyWith(labelText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email.isEmpty || !email.contains("@")) {
                        return "invalid email !!";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      _authData['email'] = val;
                    },
                  ),
                  TextFormField(
                    expands: false,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                    decoration: _inputDec.copyWith(labelText: "Password"),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (password) {
                      if (password.isEmpty || password.length < 6) {
                        return _authState == AuthState.Signup
                            ? "Password is to short"
                            : "Wrong password !!";
                      }
                      return null;
                    },
                    onSaved: (password) {
                      _authData['password'] = password;
                    },
                  ),
                  AnimatedContainer(
                    curve: Curves.easeIn,
                    duration: Duration(milliseconds: 300),
                    constraints: BoxConstraints(
                      minHeight: _authState == AuthState.Signup ? 60 : 0,
                      maxHeight: _authState == AuthState.Signup ? 120 : 0,
                    ),
                    child: FadeTransition(
                      opacity: _doubleAnimation,
                      child: SlideTransition(
                          position: _positionAnimation,
                          child: _authState == AuthState.Signup
                              ? TextFormField(
                                  enabled: _authState == AuthState.Signup,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline4,
                                  decoration: _inputDec.copyWith(
                                      labelText: "Confirm Password"),
                                  obscureText: true,
                                  validator: (password) {
                                    if (password != _passwordController.text) {
                                      return "Password don't match";
                                    }
                                    return null;
                                  })
                              : null),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _loading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          child: Text(
                            _authState == AuthState.Signup ? "SignUp" : "LogIn",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          onPressed: _submit,
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).accentColor,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30))),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    child: Text(
                      "${_authState == AuthState.Signup ? "LogIn" : "SignUp"} instead",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    onPressed: _switchAuth,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

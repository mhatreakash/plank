// ========================== LoginPage ===============================

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:plank/screens/signupPage.dart';
import 'package:plank/ui/homepage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> _resetKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  FirebaseUser currentUser;
  Animation animation, delayAnimation, muchDelayedAnimation;
  AnimationController animationController;

  bool loading = false;
  bool hidePass = true;
  bool isLogedin = false;

  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(curve: Curves.fastOutSlowIn, parent: animationController),
    );
    delayAnimation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.7, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    isSignedIn();
    _loadCurrentUser();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });

    await firebaseAuth.currentUser().then((user) {
      if (user != null) {
        setState(() => isLogedin = true);
      }
    });
    if (isLogedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    setState(() {
      loading = false;
    });
  }

  void _loadCurrentUser() {
    firebaseAuth.currentUser().then((FirebaseUser user) {
      setState(() {
        // call setState to rebuild the view
        this.currentUser = user;
      });
    });
  }

  String email() {
    if (currentUser != null) {
      return currentUser.email;
    } else {
      return "Guest User";
    }
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                stops: [0.5, 0.8],
                colors: [
                  Color(0xFFF9E79F),
                  Color(0xFFABEBC6),
                ],
              ),
            ),
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        animation.value * width, 0.0, 0.0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      alignment: Alignment.center,
                      child: Text(
                        "Welcome to Plank",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        animation.value * width, 0.0, 0.0),
                    child: Container(
                      // alignment: Alignment.center,
                      child: Text(
                        "Your one stop destination to make your homes look beautiful!",
                        style: TextStyle(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Transform(
                    transform: Matrix4.translationValues(
                        animation.value * width, 0.0, 0.0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text(
                        "Login".toUpperCase(),
                        style: _loginRegStyles(),
                      ),
                    ),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        delayAnimation.value * width, 0.0, 0.0),
                    child: Form(
                      key: _formKey,
                      autovalidate: true,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.alternate_email,
                                    color: Colors.blueGrey),
                                hintText: "Email",
                                labelStyle: TextStyle(
                                    // color: Colors.white,
                                    ),
                                labelText: "Email"),
                            // ignore: missing_return
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please Provide Email";
                              }
                              // return "";
                            },
                            onSaved: (val) {
                              _emailController.text = val;
                            },
                            autocorrect: true,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            // obscureText:hidepass we toggle when user clicks the icon
                            obscureText: hidePass,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.blueGrey,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.blueGrey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      hidePass = false;
                                    });
                                  },
                                ),
                                hintText: "Password",
                                labelText: "Password"),
                            // ignore: missing_return
                            validator: (val) {
                              if (val.length < 6) {
                                return "Passsword must contain atleast 6 characters";
                              } else if (val.isEmpty) {
                                return "Password field can't be empty";
                              }
                              // return "";
                            },
                            onSaved: (val) {
                              _passwordController.text = val;
                            },
                            autocorrect: true,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          //  ================== Login Btn =======================
                          Transform(
                            transform: Matrix4.translationValues(
                                muchDelayedAnimation.value * width, 0.0, 0.0),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(25.0)),
                              minWidth: MediaQuery.of(context).size.width,
                              child: ListTile(
                                title: Center(
                                  child: Text(
                                    "Login".toUpperCase(),
                                    style: _btnStyle(),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                print("login btn clicked!");
                                signIn();
                              },
                              color: Color(0xFF58D68D),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Transform(
                            transform: Matrix4.translationValues(
                                muchDelayedAnimation.value * width, 0.0, 0.0),
                            child: Container(
                              child: InkWell(
                                onTap: () async {
                                  _showFormDialog();
                                },
                                child: Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xFFB33771),
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 5.0),
                          Transform(
                            transform: Matrix4.translationValues(
                                muchDelayedAnimation.value * width, 0.0, 0.0),
                            child: Container(
                              child: Text(
                                "Don't have an account !",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Transform(
                    transform: Matrix4.translationValues(
                        muchDelayedAnimation.value * width, 0.0, 0.0),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0)),
                      minWidth: MediaQuery.of(context).size.width,
                      child: ListTile(
                        title: Center(
                          child: Text(
                            "Register".toUpperCase(),
                            style: _btnStyle(),
                          ),
                        ),
                      ),
                      onPressed: () {
                        print("Register btn clicked!");
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      color: Color(0xFF58D68D),
                    ),
                  ),
                
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  TextStyle _btnStyle() {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle _loginRegStyles() {
    return TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 18.0,
      letterSpacing: 0.8,
      color: Color(0xFFB33771),
    );
  }

  Future signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _showLoadingIndicator();

      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => HomePage()));
        // pushAndRemoveUtil makes users to not see the login screen when they press the back button
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => true,
        );
      } catch (e) {
        print(e.message);
      }
    }
  }

  void _showFormDialog() {
    var alert = AlertDialog(
      content: ListTile(
        title: Text(
            "Password Reset Link Will Be Sent To Your Email ID: ${_emailController.text}"),
        subtitle: Form(
          child: TextFormField(
            key: _resetKey,
            autovalidate: true,
            controller: _emailController,
            autocorrect: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.alternate_email, color: Colors.blueGrey),
              hintText: "Enter Your Email",
              labelText: "Email",
            ),
            // ignore: missing_return
            validator: (val) {
              if (val.isEmpty) {
                return "Please Provide Email";
              }
            },
            onSaved: (val) {
              _emailController.text = val;
            },
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Send"),
          onPressed: () async {
          
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  _showLoadingIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                width: 20.0,
              ),
              Text("Loading!")
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/screens/chat_screen.dart';
import '../config/palette.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _authentication = FirebaseAuth.instance;
  bool isSignupScreen = true;
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            // 배경
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              // 배경이미지와 텍스트를 넣어주기 위해서 container
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('image/red.jpg'),
                    fit: BoxFit.fill
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 90, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Welcome',
                          style: TextStyle(
                            letterSpacing: 1.0,
                            fontSize: 25,
                            color: Colors.white
                          ),
                          children: [
                            TextSpan(
                              text: isSignupScreen ? ' to yummy chat!' : ' back!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0
                              ),

                            )
                          ]
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        isSignupScreen ? 'signup to continue' : 'signin to continyu',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.0
                        ),
                      )
                    ],
                  ),

                ),
              )),
            // 텍스트 폼 필드
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              top: 180,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  padding: EdgeInsets.all(20.0),
                  height: isSignupScreen ? 280 : 250,
                  width: MediaQuery.of(context).size.width - 40,
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5,
                      )
                    ]
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: !isSignupScreen ? Palette.activeColor : Palette.textColor1,
                                    ),
                                  ),
                                  if (!isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Colors.orange,
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = true;
                                });
                              },
                              child: Column(
                                children: [
                                  Text('SIGNUP',
                                    style: TextStyle(
                                      color: isSignupScreen ? Palette.activeColor : Palette.textColor1,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Colors.orange,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        if (isSignupScreen)
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  key: ValueKey(1),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 4) {
                                      return 'Please enter at least 4 characters';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                      userName = value!;
                                  },
                                  onChanged: (value) {
                                    userName = value;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: Palette.iconColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(35),
                                      ),
                                    ),
                                    focusedBorder:  OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                    ),
                                    hintText: 'User Name',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                       color: Palette.textColor1
                                    ),
                                    contentPadding: EdgeInsets.all(10)
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  key: ValueKey(2),
                                  validator: (value) {
                                    if (value!.isEmpty || !value.contains('@')) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userEmail = value!;
                                  },
                                  onChanged: (value) {
                                    userEmail = value;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email,
                                      color: Palette.iconColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35)
                                      )
                                    ),
                                    hintStyle: TextStyle(
                                      color: Palette.textColor1,
                                      fontSize: 14
                                    ),
                                    hintText: 'Email',
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  key: ValueKey(3),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 6) {
                                      return 'Please enter at least 6 characters';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userPassword = value!;
                                  },
                                  onChanged: (value) {
                                    userPassword = value;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.key,
                                    color: Palette.textColor1,),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35),
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1
                                      ),
                                      borderRadius: BorderRadius.circular(35)
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      color: Palette.textColor1,
                                      fontSize: 14
                                    )
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        if (!isSignupScreen)
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  key: ValueKey(4),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 4) {
                                      return 'Please enter at least 4 character';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                      userName = value!;
                                  },
                                  onChanged: (value) {
                                    userName = value;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.account_circle,
                                        color: Palette.textColor1,),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(35),
                                          borderSide: BorderSide(
                                            color: Palette.textColor1,
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1
                                          ),
                                          borderRadius: BorderRadius.circular(35)
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                      hintText: 'User Name',
                                      hintStyle: TextStyle(
                                          color: Palette.textColor1,
                                          fontSize: 14
                                      )
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                TextFormField(
                                  key: ValueKey(5),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 6) {
                                      return 'Please enter at least 6 character';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userPassword = value!;
                                  },
                                  onChanged: (value) {
                                    userPassword = value;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.key,
                                        color: Palette.textColor1,),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(35),
                                          borderSide: BorderSide(
                                            color: Palette.textColor1,
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1
                                          ),
                                          borderRadius: BorderRadius.circular(35)
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                          color: Palette.textColor1,
                                          fontSize: 14
                                      )
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ),
            // 전송 버튼
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              top: isSignupScreen ? 430 : 390,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0)
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      _tryValidation();
                      try {
                        final newUser = await _authentication
                            .createUserWithEmailAndPassword(
                            email: userEmail,
                            password: userPassword
                        );

                        if (newUser.user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    return ChatScreen();
                                  }), );

                        }
                      } catch(e) {
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Please Check your email and password'),
                              backgroundColor: Colors.blue,
                            )
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.orange,
                            Colors.redAccent
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0,1)
                          )
                        ]
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),

                    ),
                  ),
                ),
              )),
            // google login button
            AnimatedPositioned(
              duration: Duration(milliseconds: 50),
              curve: Curves.easeIn,
              right: 0,
              left: 0,
              top: isSignupScreen ? MediaQuery.of(context).size.height - 125 : MediaQuery.of(context).size.height - 165,
              child: Container(
                child: Column(
                  children: [
                    Text(
                      isSignupScreen ? 'or Signup with,' : 'or Signin with',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        minimumSize: Size(155, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        backgroundColor: Palette.googleColor
                      ),
                      icon: Icon(Icons.add),
                      label: Text(
                        'Google'
                      ),
                    )
                  ],
                ),

              )
            )
          ],
        ),
      ),
    );
  }
}

import 'package:ff/anasayfa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPag extends StatefulWidget {
  final void Function()? onPressed;
  const LoginPag({super.key, required this.onPressed});

  @override
  State<LoginPag> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPag> {
  final _fromkey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  bool _isObscured = true;

  signInWithEmailAndPassword() async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      setState(() {
        isLoading = false; //true
      });
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      String errorMessage;
      if (e.code == 'invalid-credential') {
        errorMessage = "E posta ve şifreyi kontrol ediniz.";
      } else {
        errorMessage = "Tekrar deneyiniz.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 206, 80, 245),
        centerTitle: true,
        title: const Text(
          "Hoşgeldiniz",
          style: TextStyle(color: Colors.white, fontSize: 29),
        ),
        
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _fromkey,
            child: OverflowBar(
              overflowSpacing: 20,
              children: [
                TextFormField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'E Posta Giriniz.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "E Posta",
                    prefixIcon: Icon(
                      Icons.mail,
                      color: const Color.fromARGB(255, 206, 80, 245),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  controller: _password,
                  keyboardType: TextInputType.number,
                  obscureText: _isObscured,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Şifre Giriniz.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Şifre",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color.fromARGB(255, 206, 80, 245),
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: w * 0.55,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 206, 80, 245),
                        ),
                        onPressed: () {
                          if (_fromkey.currentState!.validate()) {
                            signInWithEmailAndPassword();
                          }
                        },
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.black,
                              ))
                            : const Text(
                                "Giriş",
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Hesabınız yok mu? ",
                      style: TextStyle(color: Color.fromARGB(225, 33, 33, 36)),
                    ),
                    InkWell(
                      onTap: widget.onPressed,
                      child: const Text(
                        "  Kayıt Ol",
                        style: TextStyle(
                          color: Color.fromARGB(225, 33, 33, 36),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: w * 0.65,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Anasayfa()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 206, 80, 245),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.0),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Giriş Yapmadan Devam Et",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 6,
              ),
              Icon(Icons.arrow_forward, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

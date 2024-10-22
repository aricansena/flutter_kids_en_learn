import 'package:ff/anasayfa.dart';
import 'package:ff/services/authpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final void Function()? onPressed;
  const SignUp({super.key, required this.onPressed});

  @override
  State<SignUp> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUp> {
  final _fromkey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  bool _isObscured = true;

  createUserWithEmailAndPassword() async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      if (!mounted) return; // Check if the widget is still mounted
      setState(() {
        isLoading = false;
      });
      // setState(() {
      //   isLoading = false;
      // });
    } on FirebaseAuthException catch (e) {
      if (!mounted) return; // Check if the widget is still mounted
      setState(() {
        isLoading = false;
      });

      // setState(() {
      //   isLoading = false;
      // });
      if (e.code == 'weak-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Şifre en az 6 karakter uzunluğunda olmalıdır."),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Bu e posta ile açılmış bir hesap bulunmaktadır."),
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AuthPage()),
            );
          },
        ),
        backgroundColor: const Color.fromARGB(255, 206, 80, 245),
        centerTitle: true,
        title: const Text(
          "Üye Ol",
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
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'E Posta Giriniz.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "E Posta",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color.fromARGB(255, 206, 80, 245),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  obscureText: _isObscured,
                  controller: _password,
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
                    border: OutlineInputBorder(),
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
                            createUserWithEmailAndPassword();
                          }
                        },
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.black,
                              ))
                            : const Text(
                                "Üye Ol",
                                style: TextStyle(
                                  fontSize: 21,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
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
                "Kayıt Olmadan Devam Et",
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/screens/signIn.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();

  final FocusNode f1 = FocusNode();
  final FocusNode f2 = FocusNode();
  final FocusNode f3 = FocusNode();
  final FocusNode f4 = FocusNode();

  bool _isSuccess = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                    child: _signUp(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signUp() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(bottom: 50),
              child: Text(
                'إنشاء حساب',
                style: GoogleFonts.lato(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
            _buildTextField(
              controller: _displayName,
              hintText: 'الإسم الكامل',
              
              focusNode: f1,
              nextFocusNode: f2,
              validator: (value) => value!.isEmpty ? 'الرجاء إدخال الاسم' : null,
            ),
            const SizedBox(height: 25.0),
            _buildTextField(
              controller: _emailController,
              hintText: 'البريد الإلكتروني',
              focusNode: f2,
              nextFocusNode: f3,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'الرجاء إدخال البريد الإلكتروني';
                } else if (!emailValidate(value)) {
                  return 'الرجاء إدخال بريد إلكتروني صالح';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 25.0),
            _buildTextField(
              controller: _passwordController,
              hintText: 'كلمة المرور',
              focusNode: f3,
              nextFocusNode: f4,
              isPassword: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'الرجاء إدخال كلمة المرور';
                } else if (value.length < 8) {
                  return 'يجب أن تكون كلمة المرور مكونة من 8 أحرف على الأقل';
                }
                return null;
              },
            ),
            const SizedBox(height: 25.0),
            _buildTextField(
              controller: _passwordConfirmController,
              hintText: 'تأكيد كلمة المرور',
              focusNode: f4,
              isPassword: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'الرجاء إدخال كلمة المرور';
                } else if (value != _passwordController.text) {
                  return 'كلمات المرور غير متطابقة';
                }
                return null;
              },
            ),
            Container(
              padding: const EdgeInsets.only(top: 25.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    "تسجيل الدخول",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showLoaderDialog(context);
                      _registerAccount();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: Color.fromRGBO(0, 122, 61, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              child: const Divider(thickness: 1.5),
            ),
            Container(
              padding: const EdgeInsets.only(top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.g_mobiledata, color: Color.fromRGBO(0, 122, 61, 1)),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 30),
                  IconButton(
                    icon: Icon(Icons.facebook, color: Color.fromRGBO(0, 122, 61, 1)),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => _pushPage(context, SignIn()),
                    child: Text(
                      'تسجيل الدخول',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        color: Color.fromRGBO(0, 122, 61, 1),
                        fontWeight: FontWeight.w600,
                        
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                   Text(
                    "هل لديك حساب بالفعل؟",
                    style: GoogleFonts.lato(fontSize: 15.0, fontWeight: FontWeight.w700),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required FocusNode focusNode,
    FocusNode? nextFocusNode,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.center, // Center text and hintText
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
      obscureText: isPassword,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(90.0)),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[350],
        hintText: hintText,
        hintStyle: GoogleFonts.lato(
          color: Colors.black26,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
      onFieldSubmitted: (value) {
        focusNode.unfocus();
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
      validator: validator,
    );
  }

  bool emailValidate(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$").hasMatch(email);
  }

  void _registerAccount() async {
    User? user;
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      user = credential.user;

      if (user != null) {
        if (!user.emailVerified) {
          await user.sendEmailVerification();
        }
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': _displayName.text,
          'birthDate': null,
          'email': user.email,
          'phone': null,
          'bio': null,
          'city': null,
        });
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      }
    } catch (e) {
      showAlertDialog(context, e.toString());
    }
  }

  void showAlertDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void showLoaderDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 15),
            Text("Loading..."),
          ],
        ),
      ),
    );
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }
}

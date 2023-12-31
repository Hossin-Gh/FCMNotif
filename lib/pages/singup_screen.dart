import 'package:chate_app/pages/login_screen.dart';
import 'package:chate_app/pages/user_singUp_detail.dart';
import 'package:chate_app/sevrices/auth/auth_servic.dart';
import 'package:chate_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingUpScr extends StatefulWidget {
  const SingUpScr({super.key});

  @override
  State<SingUpScr> createState() => _LoginScrState();
}

class _LoginScrState extends State<SingUpScr> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController passWordConfirmController = TextEditingController();

  bool isNotVisiblePassword = true;

  @override
  Widget build(BuildContext context) {
    void singup() async {
      if (emailController.text.isNotEmpty &&
          passWordController.text.isNotEmpty &&
          passWordConfirmController.text.isNotEmpty) {
        if (passWordController.text == passWordConfirmController.text) {
          final authServic = Provider.of<AuthServic>(context, listen: false);
          await authServic.singUpWithEmailAndPassword(
              emailController.text, passWordController.text);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => SingUpDetail(),
                // builder: (context) => LoginScr(),
              ),
              (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('رمز ورود با تایید ان یکی نیست '),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تمام فیلد ها را کامل کنید'),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'صفحه ساخت اکانت',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey[700],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomTextFild(
                  type: TextInputType.emailAddress,
                  hint: 'ایمیل',
                  isobscureText: false,
                  controller: emailController,
                ),
                SizedBox(height: 16),
                CustomTextFild(
                  type: TextInputType.visiblePassword,
                  hint: 'رمز ورود',
                  isobscureText: isNotVisiblePassword,
                  controller: passWordController,
                ),
                SizedBox(height: 16),
                CustomTextFild(
                  type: TextInputType.visiblePassword,
                  hint: 'تایید رمز ورود',
                  isobscureText: isNotVisiblePassword,
                  controller: passWordConfirmController,
                ),
                SizedBox(height: 6),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isNotVisiblePassword = !isNotVisiblePassword;
                    });
                  },
                  child: Text(
                    'مشاهده رمز',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => singup(),
                  child: Container(
                    height: 65,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Colors.blueGrey,
                    ),
                    child: Center(
                      child: Text(
                        'ساخت اکانت',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'اکانت دارید؟',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 6),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => LoginScr(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Text(
                          'ورود به اکانت',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

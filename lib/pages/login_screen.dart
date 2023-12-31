import 'package:chate_app/pages/home_screen.dart';
import 'package:chate_app/pages/singup_screen.dart';
import 'package:chate_app/sevrices/auth/auth_servic.dart';
import 'package:chate_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScr extends StatefulWidget {
  const LoginScr({super.key});

  @override
  State<LoginScr> createState() => _LoginScrState();
}

class _LoginScrState extends State<LoginScr> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  bool isNotVisiblePassword = true;

  void singin() async {
    final authServic = Provider.of<AuthServic>(context, listen: false);

    try {
      await authServic.singInWithEmailAndPassword(
          emailController.text, passWordController.text);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomeScr(),
        ),
        (route) => false,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ورود با موفقیت انجام شد'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'صفحه ورود',
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
                SizedBox(height: MediaQuery.of(context).size.height / 8),
                CustomTextFild(
                  type: TextInputType.emailAddress,
                  hint: 'ایمیل',
                  isobscureText: false,
                  controller: emailController,
                ),
                SizedBox(height: 12),
                CustomTextFild(
                  type: TextInputType.visiblePassword,
                  hint: 'رمز ورود',
                  isobscureText: isNotVisiblePassword,
                  controller: passWordController,
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
                  onTap: () => singin(),
                  child: Container(
                    height: 65,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Colors.blueGrey,
                    ),
                    child: Center(
                      child: Text(
                        'ورود',
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
                        'اکانت ندارید؟',
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
                                builder: (context) => SingUpScr(),
                              ),
                              (route) => false);
                        },
                        child: Text(
                          'ساخت اکانت',
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

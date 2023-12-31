import 'package:chate_app/widgets/text_field.dart';
import 'package:flutter/material.dart';

class SingUpDetail extends StatefulWidget {
  const SingUpDetail({super.key});

  @override
  State<SingUpDetail> createState() => _SingUpDetailState();
}

class _SingUpDetailState extends State<SingUpDetail> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  // TextEditingController userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFild(
                hint: 'نام کاربری',
                isobscureText: false,
                controller: userNameController,
                type: TextInputType.text,
              ),
              CustomTextFild(
                hint: 'شماره همراه',
                isobscureText: false,
                controller: phoneNumberController,
                type: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

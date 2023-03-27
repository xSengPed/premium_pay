import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yt_app/components/sx_button.dart';
import 'package:flutter_yt_app/models/user_profile.dart';
import 'package:flutter_yt_app/services/firestore_services.dart';

class CreateMemberActionSheet extends StatefulWidget {
  const CreateMemberActionSheet({super.key});

  @override
  State<CreateMemberActionSheet> createState() =>
      _CreateMemberActionSheetState();
}

class _CreateMemberActionSheetState extends State<CreateMemberActionSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();

  void createMember() async {
    EasyLoading.show(status: "");
    try {
      await FirestoreServices.createSubscribedMember(UserProfile(
          gmail: emailController.text,
          tel: mobileNoController.text,
          value: 600,
          isAdmin: false,
          paid: false,
          uid: ""));
      EasyLoading.dismiss();
      Navigator.pop(context);
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Text('Create New Member',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const Spacer(),
              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
        Spacer(),
        Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'G-Mail',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: mobileNoController,
                    decoration: InputDecoration(
                      hintText: 'Mobile No.',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            )),
        Spacer(),
        Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: SxButton(
                    backgroundColor: Colors.grey,
                    child: Text('Clear'),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: SxButton(
                    onTap: createMember,
                    backgroundColor: Colors.red[500],
                    child: Text('Create'),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}

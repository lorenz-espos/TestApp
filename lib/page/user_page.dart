import 'package:flutter/material.dart';
import 'package:secure_storage_example/utils/user_secure_storage.dart';
import 'package:secure_storage_example/widget/birthday_widget.dart';
import 'package:secure_storage_example/widget/button_widget.dart';
import 'package:secure_storage_example/widget/title_widget.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final formKey = GlobalKey<FormState>();
  final controllerID = TextEditingController();
  final controllerEmail = TextEditingController();
  DateTime? birthday;

  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    final name = await UserSecureStorage.getID() ?? '';
    final surname = await UserSecureStorage.getEmail() ?? '';
    final birthday = await UserSecureStorage.getBirthday();

    setState(() {
      this.controllerID.text = name;
      this.controllerEmail.text = surname;
      this.birthday = birthday;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              TitleWidget(
                  icon: Icons.enhanced_encryption_rounded, text: 'Test App'),
              const SizedBox(height: 32),
              buildName(),
              const SizedBox(height: 32),
              buildSurname(),
              const SizedBox(height: 32),
              buildBirthday(),
              const SizedBox(height: 32),
              buildButton(),
            ],
          ),
        ),
      );

  Widget buildName() => buildTitle(
        title: 'ID Number',
        child: TextFormField(
          controller: controllerID,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Your ID number',
          ),
        ),
      );

  Widget buildBirthday() => buildTitle(
        title: 'Birthday',
        child: BirthdayWidget(
          birthday: birthday,
          onChangedBirthday: (birthday) =>
              setState(() => this.birthday = birthday),
        ),
      );
  Widget buildSurname() => buildTitle(
        title: 'Email',
        child: TextFormField(
          controller: controllerEmail,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Your Email Address',
          ),
        ),
      );
  Widget buildButton() => ButtonWidget(
      text: 'Save',
      onClicked: () async {
        await UserSecureStorage.setID(controllerID.text);
        await UserSecureStorage.setEmail(controllerEmail.text);
        //await UserSecureStorage.setPets(pets);

        if (birthday != null) {
          await UserSecureStorage.setBirthday(birthday!);
        }
      });

  Widget buildTitle({
    required String title,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          child,
        ],
      );
}

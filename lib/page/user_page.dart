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
  final controllerName = TextEditingController();
  final controllerSurname = TextEditingController();
  DateTime? birthday;

  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    final surname = await UserSecureStorage.getSurname() ?? '';
    final birthday = await UserSecureStorage.getBirthday();

    setState(() {
      this.controllerName.text = name;
      this.controllerSurname.text = surname;
      this.birthday = birthday;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              TitleWidget(icon: Icons.lock, text: 'Test App'),
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
        title: 'Name',
        child: TextFormField(
          controller: controllerName,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Your Name',
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
        title: 'Surname',
        child: TextFormField(
          controller: controllerSurname,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Your Surname',
          ),
        ),
      );
  Widget buildButton() => ButtonWidget(
      text: 'Save',
      onClicked: () async {
        await UserSecureStorage.setUsername(controllerName.text);
        await UserSecureStorage.setSurname(controllerSurname.text);
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

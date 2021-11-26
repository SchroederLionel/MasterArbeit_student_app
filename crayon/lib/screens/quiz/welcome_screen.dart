import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _userNameController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  IconButton(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                child: Text(
                  "Let's Play Quiz",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                          controller: _userNameController,
                          maxLength: 20,
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.indigo),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            isCollapsed: false,
                            enabled: true,
                            prefixIcon: const Icon(
                              Icons.account_circle,
                              color: Colors.indigo,
                            ),
                            labelText: 'Enter username',
                            labelStyle: const TextStyle(
                              color: Colors.indigo,
                            ),
                          )),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        if (_userNameController.text.length >= 2) {
                          Navigator.of(context).pushNamed('quiz',
                              arguments: _userNameController.text);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(20 * 0.75),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12))),
                        child: Text(
                          'Join Quiz',
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

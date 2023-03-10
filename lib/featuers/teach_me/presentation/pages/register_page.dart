import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:teachme/core/AppTheme.dart';
import 'package:teachme/core/constant.dart';
import 'package:teachme/featuers/teach_me/presentation/bloc/AuthBloc.dart';
import 'package:teachme/featuers/teach_me/presentation/bloc/AuthState.dart';
import 'package:teachme/featuers/teach_me/presentation/bloc/RegisterBloc.dart';
import 'package:teachme/featuers/teach_me/presentation/bloc/RegisterState.dart';
import 'package:teachme/featuers/teach_me/presentation/pages/home_page.dart';
import 'package:teachme/featuers/teach_me/presentation/pages/login_page.dart';
import 'package:teachme/featuers/teach_me/presentation/widgets/lodingWidget.dart';
import 'package:teachme/featuers/teach_me/presentation/widgets/login/input_field.dart';
import 'package:teachme/featuers/teach_me/presentation/widgets/spacer.dart';
import '../widgets/radio_button.dart';
import '../widgets/register/register_btn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, }) : super(key: key);

  // final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late FocusNode firstNameFocus;
  late FocusNode lastNameFocus;
  late FocusNode emailFocus;
  late FocusNode phoneFocus;
  late FocusNode countryFocus;
  late FocusNode cityFocus;
  late FocusNode areaFocus;
  late FocusNode passwordFocus;
  late FocusNode registerBtnFocus;
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController email;
  late TextEditingController phoneNumber;
  late TextEditingController country;
  late TextEditingController city;
  late TextEditingController area;
  late TextEditingController password;
  String user_type = 'Student';
  int id = 1;

  @override
  void initState() {
    super.initState();
    firstNameFocus = FocusNode();
    lastNameFocus = FocusNode();
    emailFocus = FocusNode();
    phoneFocus = FocusNode();
    countryFocus = FocusNode();
    cityFocus = FocusNode();
    areaFocus = FocusNode();
    passwordFocus = FocusNode();
    registerBtnFocus = FocusNode();
    firstName = TextEditingController();
    lastName = TextEditingController();
    email = TextEditingController();
    phoneNumber = TextEditingController();
    country = TextEditingController();
    city = TextEditingController();
    area = TextEditingController();
    password = TextEditingController();

  }

  @override
  void dispose() {
    firstNameFocus.dispose();
    lastNameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    password.dispose();
    registerBtnFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => RegisterBloc())
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme
              .of(context)
              .primaryBtnText,
          automaticallyImplyLeading: false,
          title: Text(
            'Sign Up',
            style: AppTheme
                .of(context)
                .subtitle2
                .override(
              fontFamily: 'Lexend Deca',
              color: Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body:BlocConsumer<RegisterBloc,RegisterState>(
          listener: (context, state) {
            if (state is RegisterError) {
              buildErrorLayout();
            } else if (state is RegisterLoaded) {
              clearTextData();
              Navigator
                  .of(context, rootNavigator: true)
                  .pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage()));
              // showAlertDialog(context);
            }
            else if (state is RegisterResponseError) {
              ResponseErrorLayout();
            }
          },
          builder: (context, state) {
            if (state is RegisterLoading) {
              return LoadingWidget(child: buildInitialInput());
            } else {
              return buildInitialInput();
            }
          },
        ),
      ),
    );
  }
  Widget buildInitialInput() => SingleChildScrollView(
    child: SingleChildScrollView(
      child: Column(
        children: [
          // ImageBuilder(imagePath: loginImages[0]),
          // const TextData(message: "User"),
          HeightSpacer(myHeight: kSpacing),
          Padding(
            padding: const EdgeInsets.only(left: 0,right: 0),
            child:  InputField(
              focusNode: firstNameFocus,
              textController: firstName,
              label: "First Name",
              icons: const Icon(Icons.person, color: Colors.blue),
            ),
          ),
          HeightSpacer(myHeight: kSpacing),
          Padding(
            padding: const EdgeInsets.only(left: 0,right: 0),
            child:  InputField(
              focusNode: lastNameFocus,
              textController: lastName,
              label: "Last Name",
              icons: const Icon(Icons.person, color: Colors.blue),
            ),
          ),
          HeightSpacer(myHeight: kSpacing),
          Padding(
            padding: const EdgeInsets.only(left: 0,right: 0),
            child:  InputField(
              focusNode: emailFocus,
              textController: email,
              label: "Email",
              icons: const Icon(Icons.email, color: Colors.blue),
            ),
          ),
          HeightSpacer(myHeight: kSpacing),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: IntlPhoneField(
              decoration: const InputDecoration( //decoration for Input Field
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'AE', //default contry code, NP for UAE
              onChanged: (phone) {
                //when phone number country code is changed
                phoneNumber.text = phone.completeNumber.toString();

              },
            ),
          ),
          HeightSpacer(myHeight: kSpacing),
          Padding(
            padding: const EdgeInsets.only(left: 0,right: 0),
            child:  InputField(
              focusNode: countryFocus,
              textController: country,
              label: "Country",
              icons: const Icon(Icons.language, color: Colors.blue),
            ),
          ),
          HeightSpacer(myHeight: kSpacing),
          Padding(
            padding: const EdgeInsets.only(left: 0,right: 0),
            child:  InputField(
              focusNode: cityFocus,
              textController: city,
              label: "City",
              icons: const Icon(Icons.location_city, color: Colors.blue),
            ),
          ),
          HeightSpacer(myHeight: kSpacing),
          Padding(
            padding: const EdgeInsets.only(left: 0,right: 0),
            child:  InputField(
              focusNode: areaFocus,
              textController: area,
              label: "Area",
              icons: const Icon(Icons.location_city_sharp, color: Colors.blue),
            ),
          ),
          HeightSpacer(myHeight: kSpacing),
          Padding(
            padding: const EdgeInsets.only(left: 0,right: 0),
            child: InputField(
              focusNode: passwordFocus,
              textController: password,
              label: "Password",
              icons: const Icon(Icons.lock, color: Colors.blue),
            ),
          ),
          HeightSpacer(myHeight: kSpacing),
           Padding(
             padding: const EdgeInsets.only(left: 20,right: 20),
             child:Column(
           children: <Widget>[
           // Padding(
           //     padding: EdgeInsets.all(0),
           //     child: Text('Register as ' + '$radioButtonItem',
           //         style: TextStyle(fontSize: 21))
           // ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Radio(
                 value: 1,
                 groupValue: id,
                 onChanged: (val) {
                   setState(() {
                     user_type = 'Student';
                     id = 1;
                   });
                 },
               ),
               Text(
                 'Student',
                 style: new TextStyle(fontSize: 17.0),
               ),

               Radio(
                 value: 2,
                 groupValue: id,
                 onChanged: (val) {
                   setState(() {
                     user_type = 'Teacher';
                     id = 2;
                   });
                 },
               ),
               Text(
                 'Teacher',
                 style: new TextStyle(
                   fontSize: 17.0,
                 ),
               ),
             ],
           ),
        ],
      ),
           ),
          HeightSpacer(myHeight: kSpacing),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
              child: RegisterBtn(
              focusNode: registerBtnFocus,
              firstName: firstName,
              lastName: lastName,
              email: email,
              phone: phoneNumber,
              country: country,
              city: city,
              area: area,
              password: password,
                user_type: user_type,
            ),
          ),
        ],
      ),
    ),
  );
  ScaffoldFeatureController buildErrorLayout() =>
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All fields is required!'),
        ),
      );
  ScaffoldFeatureController ResponseErrorLayout() =>
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Data!'),
        ),
      );

  clearTextData() {
    firstName.clear();
    password.clear();

  }
}
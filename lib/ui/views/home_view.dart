import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_ke/core/enums/button_type.dart';
import 'package:shop_ke/core/view_models/home_view_model.dart';
import 'package:shop_ke/ui/shared/buttons/app_button.dart';
import 'package:shop_ke/ui/shared/containers/responsive_container.dart';
import 'package:shop_ke/ui/shared/forms/form_helper.dart';
import 'package:shop_ke/ui/shared/utils/text_styles.dart';
import 'package:shop_ke/ui/shared/widgets/app_drawer.dart';
import 'package:shop_ke/ui/widgets/home/home_floating_action_button.dart';

import 'base_view.dart';

class HomeView extends StatefulWidget {
  static const routeName = '/home';

  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController barCodeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text('Home')),
          drawer: AppDrawer(),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //Top half of the screen with the scanner
                ResponsiveContainer(
                  height: 0.5,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                  ),
                ),

                //Bottom half of the screen where they can manually enter the code
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: FormHelper.sidePadding,
                        vertical: FormHelper.formFieldSpacing),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        //Top half with the input and label
                        Container(
                          child: Column(
                            children: [
                              Text('Code won\'t scan?',
                                  style: darkSubHeader,
                                  textAlign: TextAlign.left),
                              SizedBox(height: FormHelper.formFieldSpacing),
                              TextField(
                                controller: barCodeController,
                                keyboardType: TextInputType.number,
                                decoration: FormHelper.buildInputDecoration(
                                    controller: barCodeController,
                                    labelText: 'Enter Code'),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: FormHelper.formFieldSpacing * 2),

                        AppButton(
                          buttonType: ButtonType.Primary,
//                          text: model.cameraIsReady ? 'SCAN' : 'START CAMERA',
                          text: 'START SCAN',
                          //TODO: Scan functionality
                          onPressed: () async {
//                            scanBarcodeOnce();
                            model.socketsService.sendData('Hello world');

//                          Navigator.of(context).pushNamed(TestSocket.routeName);

//                            final phoneNumber = '+254700013635';
//                            final Ticket ticket = await locator<ApiService>()
//                                .getTicket(phoneNumber);
//                            print(ticket.username);
//                            final FirebaseUser user = await locator<
//                                ApiService>().getFireBaseUser(phoneNumber);
//                            print(user.token);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                //Removed Expanded widget of flex factor 5 containing the CartCard
              ],
            ),
          ),
          floatingActionButton: !model.cartOccupiesFullScreen
              ? HomeFloatingActionButton(model: model)
              : null,
        ),
      ),
    );
  }
}

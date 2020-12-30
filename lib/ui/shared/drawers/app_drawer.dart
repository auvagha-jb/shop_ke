import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/icon_type.dart';
import 'package:shop_ke/core/view_models/app_view_models/app_drawer_view_model.dart';
import 'package:shop_ke/ui/shared/utils/text_styles.dart';
import 'package:shop_ke/ui/shared/utils/ui_helpers.dart';
import 'package:shop_ke/ui/shared/widgets/app_icon.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<DrawerViewModel>(
      builder: (context, model, child) => SafeArea(
        child: Drawer(
          child: Column(
            children: <Widget>[
              //Drawer Title
              Container(
                alignment: Alignment.centerLeft,
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    AppIcon(
                      iconType: IconType.Light,
                      iconSize: 30,
                    ),
                    Text(
                      UIHelper.appName,
                      style: lightHeader2,
                    ),
                  ],
                ),
              ),

              //Drawer Items
              FutureBuilder(
                future: model.appDrawerItems,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  Widget widget;
                  if (snapshot.hasData) {
                    widget = model.getDrawerListView(snapshot.data);
                  } else if (snapshot.hasError) {
                    widget = Container();
                    print(snapshot.error);
                  } else {
                    widget = CircularProgressIndicator();
                  }
                  return widget;
                },
              ),

              Divider(),
              //Divider for the last item
            ],
          ),
        ),
      ),
    );
  }
}

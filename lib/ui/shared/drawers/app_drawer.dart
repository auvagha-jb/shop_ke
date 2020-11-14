import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/icon_type.dart';
import 'package:shop_ke/core/view_models/app_drawer_view_model.dart';
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
              ListView.separated(
                //To make sure it takes up as much space as it needs rather than expanding to fill parent
                shrinkWrap: true,
                itemCount: model.appDrawerItems.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  title: Text(model.appDrawerItems[index].title),
                  leading: model.appDrawerItems[index].icon,
                  onTap: model.appDrawerItems[index].onPressed,
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
              ),
              Divider(), //Divider for the last item
            ],
          ),
        ),
      ),
    );
  }
}

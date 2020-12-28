import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/icon_type.dart';
import 'package:shop_ke/core/view_models/app_drawer_view_model.dart';
import 'package:shop_ke/ui/shared/owner/shop_name_text.dart';
import 'package:shop_ke/ui/shared/utils/text_styles.dart';
import 'package:shop_ke/ui/shared/widgets/app_icon.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';

class OwnerDrawer extends StatelessWidget {
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
                color: Theme.of(context).backgroundColor,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    AppIcon(
                      iconType: IconType.Light,
                      iconSize: 30,
                    ),
                    StoreNameText(style: primaryHeader2),
                  ],
                ),
              ),

              //Drawer Items
              model.getDrawerListView(model.ownerDrawerItems),

              Divider(), //Divider for the last item
            ],
          ),
        ),
      ),
    );
  }
}

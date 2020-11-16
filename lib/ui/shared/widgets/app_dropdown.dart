import 'package:flutter/material.dart';
import 'package:shop_ke/ui/shared/ui_helpers.dart';

class AppDropdown extends StatefulWidget {
  final String value;
  final Function onChanged;
  final String validatorValue;
  final List<String> items;

  const AppDropdown({
    Key key,
    @required this.value,
    @required this.onChanged,
    @required this.validatorValue,
    @required this.items,
  }) : super(key: key);

  @override
  _AppDropdownState createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: UIHelper.dropdownPadding),
      child: DropdownButtonFormField<String>(
        validator: (value) => widget.validatorValue,
        isExpanded: true,
        value: widget.value,
        icon: Icon(Icons.keyboard_arrow_down),
        elevation: UIHelper.dropdownElevation,
        onChanged: widget.onChanged,
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

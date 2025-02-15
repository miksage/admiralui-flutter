import 'package:admiralui_flutter/admiralui_flutter.dart';
import 'package:admiralui_flutter/layout/layout_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../navigation/tab_navigator_home.dart';

class InputNumberDefaultScreen extends StatefulWidget {
  const InputNumberDefaultScreen({
    super.key,
    required this.title,
    required this.onPush,
  });

  final String title;
  final Function(TabNavigatorRoutes route) onPush;

  @override
  State<InputNumberDefaultScreen> createState() =>
      _InputNumberDefaultScreenState();
}

class _InputNumberDefaultScreenState extends State<InputNumberDefaultScreen> {
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = AppThemeProvider.of(context);
    final ColorPalette colors = theme.colors;
    final FontPalette fonts = theme.fonts;

    return Scaffold(
      appBar: AppBar(
        leading: CupertinoButton(
          child: Icon(
            Icons.arrow_back_ios,
            color: colors.elementSecondary.color(),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.title,
          style: fonts.subtitle2.toTextStyle(
            colors.textPrimary.color(),
          ),
        ),
        centerTitle: true,
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: colors.backgroundBasic.color(),
      ),
      body: Container(
        color: colors.backgroundBasic.color(),
        padding: EdgeInsets.all(
          LayoutGrid.doubleModule,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            StandardTabs(
              <String>['Default', 'Disabled'],
              onTap: (String value) {
                setState(() {
                  switch (value) {
                    case 'Default':
                      isEnabled = true;
                      break;
                    case 'Disabled':
                      isEnabled = false;
                      break;
                  }
                });
              },
            ),
            SizedBox(height: LayoutGrid.quadrupleModule),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextView(
                  'Default',
                  font: theme.fonts.headline,
                  textColorNormal: theme.colors.textSecondary.color(),
                )
              ],
            ),
            SizedBox(height: LayoutGrid.doubleModule),
            InputNumber(
                title: 'Optional value',
                onChangedValue: _ChangeInputControl,
                style: InputNumberButtonStyle.normal,
                isEnable: isEnabled),
          ],
        ),
      ),
    );
  }

  void _ChangeInputControl(double value) {}
}

import 'package:admiralui_flutter/admiralui_flutter.dart';
import 'package:admiralui_flutter/layout/layout_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../navigation/tab_navigator_home.dart';

class CalendarsScreen extends StatelessWidget {
  const CalendarsScreen({
    super.key,
    required this.title,
    required this.onPush,
  });

  final String title;
  final Function(TabNavigatorRoutes route) onPush;

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = AppThemeProvider.of(context);
    final ColorPalette colors = theme.colors;
    final FontPalette fonts = theme.fonts;

    return Scaffold(
      backgroundColor: colors.backgroundBasic.color(),
      appBar: AppBar(
        leading: CupertinoButton(
          child: Icon(
            Icons.arrow_back_ios,
            color: colors.elementSecondary.color(),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: colors.backgroundBasic.color(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(
              LayoutGrid.doubleModule,
            ),
            child: TextView(
              'Calendar',
              font: fonts.title1,
              textColorNormal: colors.textPrimary.color(),
            ),
          ),
          BaseCellWidget(
            centerCell: TextView('Vertical'),
            trailingCell: Icon(
              AdmiralIcons.admiral_ic_chevron_right_outline,
              color: colors.elementSecondary.color(),
            ),
            onPressed: () => onPush.call(
              TabNavigatorRoutes.calendarVertical,
            ),
          ),
          BaseCellWidget(
            centerCell: TextView('Horizontal'),
            trailingCell: Icon(
              AdmiralIcons.admiral_ic_chevron_right_outline,
              color: colors.elementSecondary.color(),
            ),
            onPressed: () => onPush.call(
              TabNavigatorRoutes.calendarHorizontal,
            ),
          ),
        ],
      ),
    );
  }
}

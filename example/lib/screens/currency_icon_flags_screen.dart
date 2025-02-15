import 'package:admiralui_flutter/admiralui_flutter.dart';
import 'package:admiralui_flutter/layout/layout_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../navigation/tab_navigator_home.dart';

class CurrencyIconsFlagsScreen extends StatelessWidget {
  const CurrencyIconsFlagsScreen({
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
      appBar: AppBar(
        leading: CupertinoButton(
          child: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: colors.backgroundBasic.color(),
        title: Text(
          title,
          style: fonts.subtitle1.toTextStyle(
            colors.textPrimary.color(),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutGrid.doubleModule,
        ),
        color: colors.backgroundBasic.color(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: LayoutGrid.quadrupleModule,
            ),
            Row(
              children: <Widget>[
                Text('Курсы валют',
                    style: fonts.subtitle1
                        .toTextStyle(colors.textPrimary.color())),
                SizedBox(width: LayoutGrid.halfModule),
                Icon(AdmiralIcons.admiral_ic_chevron_down_outline),
                Spacer(),
                LinkControl(
                  title: 'Button',
                  style: LinkStyle.medium,
                ),
              ],
            ),
            SizedBox(
              height: LayoutGrid.quadrupleModule,
            ),
            CurrencyHeader(
              'Валюта',
              'Купить',
              'Продать',
              isTextSpacingEnabled: true,
            ),
            SizedBox(
              height: LayoutGrid.doubleModule,
            ),
            Currency(
              'USD',
              '89',
              '90',
              Image(
                image: AssetImage('assets/currency/usa.png'),
                fit: BoxFit.cover,
                height: LayoutGrid.halfModule * 5,
              ),
              CurrencyCellType.arrowUp,
              CurrencyCellType.arrowDown,
            ),
            SizedBox(
              height: LayoutGrid.halfModule * 3,
            ),
            Currency(
              'EUR',
              '89',
              '90',
              Image(
                image: AssetImage('assets/currency/european.png'),
                fit: BoxFit.cover,
                height: LayoutGrid.halfModule * 5,
              ),
              CurrencyCellType.arrowUp,
              CurrencyCellType.arrowDown,
            ),
            SizedBox(
              height: LayoutGrid.halfModule * 3,
            ),
            Currency(
              'GBP',
              '89',
              '90',
              Image(
                image: AssetImage('assets/currency/britain.png'),
                fit: BoxFit.cover,
                height: LayoutGrid.halfModule * 5,
              ),
              CurrencyCellType.arrowUp,
              CurrencyCellType.arrowDown,
            ),
            SizedBox(
              height: LayoutGrid.halfModule * 3,
            ),
            Currency(
              'CNY',
              '89',
              '90',
              Image(
                image: AssetImage('assets/currency/china.png'),
                fit: BoxFit.cover,
                height: LayoutGrid.halfModule * 5,
              ),
              CurrencyCellType.arrowUp,
              CurrencyCellType.arrowDown,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

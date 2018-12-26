import 'package:flutter/material.dart';
import 'cell_model.dart';
import 'common_comp.dart';
import 'constants.dart';
import 'services.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isHomeDataLoading;

  @override
  void initState() {
    super.initState();
    isHomeDataLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: ComComp.getAppBar(COLORS.APP_THEME_COLOR, "Home"),
      body: Center(
        child: Container(
          child: FutureBuilder<List<CellModel>>(
            future: Services.fetchHomeData(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? snapshot.hasData
                      ? ComComp.homeGrid(snapshot, gridClicked)
                      : ComComp.retryButton(fetch)
                  : ComComp.circularProgress();
            },
          ),
        ),
      ),
    );
  }

  setLoading(bool loading) {
    setState(() {
      isHomeDataLoading = loading;
    });
  }

  fetch() {
    setLoading(true);
  }
}

gridClicked(BuildContext context, CellModel homeCellModel) {}

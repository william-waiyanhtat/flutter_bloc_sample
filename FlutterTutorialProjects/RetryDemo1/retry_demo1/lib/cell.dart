import 'package:flutter/material.dart';
import 'cell_model.dart';

class Cell extends StatelessWidget {
  const Cell(this.cellModel);
  @required
  final CellModel cellModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Padding(
          padding:
              new EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0, top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.network(cellModel.thumbnailUrl,
                  width: 150.0,
                  height: 150.0,
                  alignment: Alignment.center,
                  fit: BoxFit.fill),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  cellModel.title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

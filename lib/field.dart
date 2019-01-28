import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class Field extends StatefulWidget {

  final int idx;
  final String playerSymbol;
  final Function(int idx) onTap;

  final BorderSide _borderSide = BorderSide(
      color: Colors.amber,
      width: 2.0,
      style: BorderStyle.solid
  );


  Field({Key key, this.idx, this.playerSymbol, @required this.onTap}) : super(key: key);

  @override
  State createState() => _FieldState();

  Border _determineBorder(int idx) {
    Border determinedBorder = Border.all();

    switch(idx) {
      case 0:
        determinedBorder = Border(bottom: _borderSide, right: _borderSide);
        break;
      case 1:
        determinedBorder = Border(left: _borderSide, bottom: _borderSide, right: _borderSide);
        break;
      case 2:
        determinedBorder = Border(left: _borderSide, bottom: _borderSide);
        break;
      case 3:
        determinedBorder = Border(bottom: _borderSide, right: _borderSide, top: _borderSide);
        break;
      case 4:
        determinedBorder = Border(left: _borderSide, bottom: _borderSide, right: _borderSide, top: _borderSide);
        break;
      case 5:
        determinedBorder = Border(left: _borderSide, bottom: _borderSide, top: _borderSide);
        break;
      case 6:
        determinedBorder = Border(right: _borderSide, top: _borderSide);
        break;
      case 7:
        determinedBorder = Border(left: _borderSide, top: _borderSide, right: _borderSide);
        break;
      case 8:
        determinedBorder = Border(left: _borderSide, top: _borderSide);
        break;
    }

    return determinedBorder;
  }


}

class _FieldState extends State<Field> {

  void _handleTap() {
    widget.onTap(widget.idx);
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        margin: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
            border: widget._determineBorder(widget.idx)
        ),
        child: Center(
            child: Text(widget.playerSymbol, style: TextStyle(fontSize: 50))
        ),
      ),
    );
  }
}

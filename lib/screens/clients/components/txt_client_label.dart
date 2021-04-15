import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TxtClientLabel extends StatelessWidget {

  TxtClientLabel({this.txtLabel, this.txtString, this.txtDateTime});

  final String txtLabel;
  final String txtString;
  final DateTime txtDateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey[300]),
        ),
      ),
      child: Column(
        children: [
          Text(
            txtLabel,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.green,
            ),
          ),
          Text(
            txtString != null ? txtString : txtDateTime == DateTime.fromMillisecondsSinceEpoch(0) ? '' : DateFormat("dd-MM-yyyy").format(txtDateTime),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class QuoteWidgetSmall extends StatelessWidget {
  final Color widgetColor;
  final String quoteText;
  final String author;
  final Function(BuildContext)? deleteQuote;

  const QuoteWidgetSmall(
      {super.key,
      required this.widgetColor,
      required this.quoteText,
      required this.author,
      this.deleteQuote});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 8),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteQuote,
              icon: Icons.delete,
              backgroundColor: Color.fromARGB(255, 255, 119, 119),
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
        child: SizedBox(
          width: 400,
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: widgetColor, borderRadius: BorderRadius.circular(10)),
            child: Column(children: [
              Text(quoteText,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              SizedBox(height: 3),
              Text(author, style: TextStyle(fontSize: 11)),
            ]),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class QuoteWidgetSmall extends StatelessWidget {
  final String quoteText;
  final String author;
  final Function(BuildContext)? deleteQuote;

  const QuoteWidgetSmall(
      {super.key,
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
              backgroundColor: Colors.red.shade300,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 143, 135),
              borderRadius: BorderRadius.circular(10)),
          child: Column(children: [
            Text(quoteText, style: TextStyle(fontSize: 12)),
            SizedBox(height: 3),
            Text(author, style: TextStyle(fontSize: 11)),
          ]),
        ),
      ),
    );
  }
}

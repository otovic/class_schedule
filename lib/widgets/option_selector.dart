import 'package:flutter/material.dart';

class OptionSelector extends StatelessWidget {
  final IconData icon;
  final Function function;
  final String title;
  final String value;
  const OptionSelector(
      {required this.icon,
      required this.function,
      required this.title,
      required this.value,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        width: double.infinity,
        height: MediaQuery.of(context).size.shortestSide * 0.2,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.shortestSide * 0.13,
              height: MediaQuery.of(context).size.shortestSide * 0.13,
              child: Center(
                child: Icon(
                  icon,
                  color: Theme.of(context).backgroundColor,
                  size: MediaQuery.of(context).size.shortestSide * 0.07,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.shortestSide * 0.13,
              width: MediaQuery.of(context).size.shortestSide * 0.7,
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 2),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.shortestSide * 0.065,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Theme.of(context).backgroundColor,
                        fontSize:
                            MediaQuery.of(context).size.shortestSide * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.shortestSide * 0.05,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                          fontSize:
                              MediaQuery.of(context).size.shortestSide * 0.04,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:debts/src/models/debt_model.dart';

import 'package:debts/src/modals/debt/actions.dart';

class DebtCard extends StatelessWidget {
  const DebtCard({
    Key key,
    this.debt,
  }) : super(key: key);

  final DebtModel debt;

  @override
  Widget build(BuildContext context) {
    final DebtActionsModal _dModal = DebtActionsModal(debt: debt);

    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => print(1),
      onLongPress: () => _dModal.mainBottomSheet(context),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0,
        ),
        height: 100.0,
        child: InkWell(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              _avatarBox(context, size),
              _textBox(context, size),
            ],
          ),
        ),
      ),
    );
  }

  // Avatar
  Widget _avatarBox(BuildContext context, size) {
    return Positioned(
      top: 25.0,
      left: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage(
            debt.user.image,
          ),
        ),
      ),
    );
  }

  // Text
  Widget _textBox(BuildContext context, size) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: SizedBox(
        height: 110.0,
        // our image take 200 width, thats why we set out total width - 200
        width: size.width - 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                debt.title,
                style: Theme.of(context).textTheme.button,
              ),
            ),
            // it use the available space
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0 * 1.5, // 30 padding
                vertical: 20.0 / 4, // 5 top and bottom
              ),
              decoration: BoxDecoration(
                color: Color(0xFF0000000),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(22),
                  topLeft: Radius.circular(22),
                ),
              ),
              child: Text(
                "${debt.quantity} \€",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

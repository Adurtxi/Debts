import 'package:auto_size_text/auto_size_text.dart';
import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/widgets/userList.dart';
import 'package:flutter/material.dart';

class DebtDetail extends StatelessWidget {
  final prefs = new UserPreferences();

  DebtModel debt = new DebtModel();

  @override
  Widget build(BuildContext context) {
    debt = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(debt.title),
      ),
      body: Column(
        children: <Widget>[
          _container(),
          Flexible(child: _showPhoto()),
        ],
      ),
    );
  }

  Widget _container() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Column(
        children: <Widget>[
          UserList(user: debt.user),
          UserList(user: debt.defaulter),
          _quantity(),
          _description(),
        ],
      ),
    );
  }

  Widget _quantity() {
    Color color;
    if (debt.paid == true) {
      color = Colors.green;
    } else {
      color = Colors.red;
    }

    return ListTile(
      title: _statusText(),
      subtitle: _quantityText(),
      trailing: Icon(
        Icons.money_off,
        color: color,
      ),
    );
  }

  Widget _quantityText() {
    int i = debt.quantity.truncate();

    if (debt.quantity == i) {
      return Text('${i.toString()}€');
    }
    return Text('${debt.quantity.toString()}€');
  }

  Widget _statusText() {
    if (debt.paid == true) {
      return Text(
        'Pagada',
        style: TextStyle(
          color: Colors.green,
        ),
      );
    }
    return Text(
      'Sin pagar',
      style: TextStyle(
        color: Colors.red,
      ),
    );
  }

  Widget _description() {
    final description = Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              AutoSizeText(
                debt.description,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
                maxLines: 10,
              ),
            ],
          ),
        ),
      ),
    );

    if (debt.description.length > 1) {
      return description;
    } else {
      return Container();
    }
  }

  Widget _showPhoto() {
    if (debt.fileName != null) {
      return FadeInImage(
        image: NetworkImage(
          'https://api.debts.epbasic.eu/api/ticket/${debt.fileName}',
        ),
        placeholder: AssetImage('assets/img/original.gif'),
        fit: BoxFit.cover,
      );
    } else {
      return Container();
    }
  }
}

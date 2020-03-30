import 'package:epbasic_debts/src/blocs/followers_bloc.dart';
import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/modals/defaulter_modal.dart';
import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:epbasic_debts/src/models/user_model.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/widgets/myAppBar.dart';
import 'package:epbasic_debts/src/widgets/userList.dart';
import 'package:flutter/material.dart';
import 'package:epbasic_debts/src/utils/utils.dart' as utils;

class NewDebtPage extends StatefulWidget {
  @override
  _NewDebtPageState createState() => _NewDebtPageState();
}

class _NewDebtPageState extends State<NewDebtPage> {
  final _prefs = new UserPreferences();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  DebtModel debt = new DebtModel();
  DebtsBloc debtsBloc = new DebtsBloc();

  @override
  Widget build(BuildContext context) {
    final followersBloc = Provider.followersBloc(context);

    DefaulterModal modal = new DefaulterModal();

    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(
        title: Text('Crear deuda'),
        user: '${_prefs.identity[1][0]}${_prefs.identity[2][0]}',
        context: context,
      ),
      floatingActionButton: _defaulterButton(modal),
      body: _container(followersBloc),
    );
  }

  Widget _container(followersBloc) {
    return Stack(children: <Widget>[
      Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        child: Column(
          children: <Widget>[
            _userList(followersBloc),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _createTitle(),
                      _createDescription(),
                      _createQuantity(),
                      _createAvailable(),
                      _createButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Widget _userList(FollowersBloc followersBloc) {
    return StreamBuilder<UserModel>(
      stream: followersBloc.defaulter,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          debt.defaulterId = snapshot.data.id;

          return UserList(user: snapshot.data);
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Selecciona moroso',
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.blue[500],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _createTitle() {
    return TextFormField(
      initialValue: debt.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Título',
      ),
      onSaved: (value) => debt.title = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el título de la deuda';
        } else {
          return null;
        }
      },
    );
  }

  Widget _createDescription() {
    return TextFormField(
      initialValue: debt.description,
      decoration: InputDecoration(
        labelText: 'Descripción',
      ),
      onSaved: (value) => debt.description = value,
    );
  }

  Widget _createQuantity() {
    return TextFormField(
      initialValue: debt.quantity.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Cantidad',
      ),
      onSaved: (value) => debt.quantity = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo números';
        }
      },
    );
  }

  Widget _createAvailable() {
    return SwitchListTile(
      value: debt.paid,
      title: Text('Pagado'),
      activeColor: Color.fromRGBO(31, 133, 109, 1.0),
      onChanged: (value) => setState(() {
        debt.paid = value;
      }),
    );
  }

  Widget _createButton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Color.fromRGBO(31, 133, 109, 1.0),
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: () => _submit(),
    );
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    if (debt.defaulterId == null) {
      _printSnackbar('Selecciona deudor', Colors.blue, Colors.white);
      return;
    }

    final resp = await debtsBloc.createDebt(debt);

    if (resp['ok'] == true) {
      _formKey.currentState?.reset();

      _printSnackbar(resp['message'], Colors.green, Colors.white);
    } else {
      _printSnackbar(resp['message'], Colors.red, Colors.white);
      return;
    }
  }

  void _printSnackbar(String message, Color backColor, Color textColor) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message, style: TextStyle(color: textColor)),
      duration: Duration(milliseconds: 1500),
      backgroundColor: backColor,
    ));
  }

  Widget _defaulterButton(DefaulterModal modal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.blue),
          ),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () => modal.mainBottomSheet(context),
          child: Text("Seleccionar deudor"),
        ),
      ],
    );
  }
}

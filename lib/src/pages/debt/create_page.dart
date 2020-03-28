import 'package:epbasic_debts/src/blocs/followers_bloc.dart';
import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/modals/defaulter_modal.dart';
import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:epbasic_debts/src/models/user_model.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:epbasic_debts/src/utils/utils.dart' as utils;

class NewDebtPage extends StatefulWidget {
  @override
  _NewDebtPageState createState() => _NewDebtPageState();
}

class _NewDebtPageState extends State<NewDebtPage> {
  final prefs = new UserPreferences();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  DebtModel debt = new DebtModel();
  DebtsBloc debtsBloc = new DebtsBloc();

  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final followersBloc = Provider.followersBloc(context);

    DefaulterModal modal = new DefaulterModal();

    return Scaffold(
      key: scaffoldKey,
      appBar: MyAppBar(
        title: Text('Crear deuda'),
        user: '${prefs.identity[1][0]}${prefs.identity[2][0]}',
        context: context,
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => modal.mainBottomSheet(context),
        child: new Icon(Icons.add),
      ),
      body: _container(followersBloc),
    );
  }

  Widget _container(followersBloc) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    _defaulter(followersBloc),
                    _createTitle(),
                    _createDescription(),
                    _createQuantity(),
                    _createAvailable(),
                    _createButton(followersBloc),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _defaulter(FollowersBloc followersBloc) {
    return StreamBuilder<UserModel>(
      stream: followersBloc.defaulter,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          debt.defaulterId = snapshot.data.id;

          return Text(
            '${snapshot.data.name} ${snapshot.data.surname}',
            style: TextStyle(fontSize: 20.0),
          );
        } else {
          return Text('Selecciona moroso');
        }
      },
    );
  }

  Widget _createTitle() {
    return TextFormField(
      autofocus: true,
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

  Widget _createButton(followersBloc) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Color.fromRGBO(31, 133, 109, 1.0),
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: () {
        _submit();
      },
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _saving = true;
    });

    debtsBloc.createDebt(debt);
    _printSnackbar('Deuda guardada');

    setState(() {
      _saving = false;
    });
  }

  void _printSnackbar(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}

import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/modals/ticket_picker.dart';
import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class EditDebtPage extends StatefulWidget {
  @override
  _EditDebtPageState createState() => _EditDebtPageState();
}

class _EditDebtPageState extends State<EditDebtPage> {
  final _prefs = new UserPreferences();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  DebtModel debt = new DebtModel();

  TicketPickerModal _ticketPickerModal = new TicketPickerModal();

  @override
  Widget build(BuildContext context) {
    final debtsBloc = Provider.debtsBloc(context);

    DebtModel debtData = ModalRoute.of(context).settings.arguments;

    if (debtData != null) {
      debt = debtData;
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(
        title: Text('Editar deuda'),
        user: '${_prefs.identity[1][0]}${_prefs.identity[2][0]}',
        context: context,
      ),
      body: Column(
        children: <Widget>[
          _container(debtsBloc),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _showPhoto(debtsBloc, _ticketPickerModal),
            ),
          ),
          _showStreamTicket(debtsBloc),
        ],
      ),
    );
  }

  Widget _container(DebtsBloc debtsBloc) {
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
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _createTitle(),
                    _createDescription(),
                    _createButton(debtsBloc),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createTitle() {
    return TextFormField(
      initialValue: debt.title,
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

  Widget _createButton(DebtsBloc debtsBloc) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: RaisedButton.icon(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Color.fromRGBO(31, 133, 109, 1.0),
        textColor: Colors.white,
        label: Text('Actualizar'),
        icon: Icon(Icons.save),
        onPressed: () => _submit(debtsBloc),
      ),
    );
  }

  Widget _showPhoto(DebtsBloc debtsBloc, TicketPickerModal modal) {
    return StreamBuilder<File>(
      stream: debtsBloc.debtTicketFile,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image(
            image: AssetImage(snapshot.data.path),
            fit: BoxFit.cover,
          );
        } else {
          Widget image;

          if (debt.fileName != null) {
            image = FadeInImage(
              image: NetworkImage(
                'https://api.debts.epbasic.eu/api/ticket/${debt.fileName}',
              ),
              placeholder: AssetImage('assets/img/original.gif'),
              fit: BoxFit.cover,
            );
          } else {
            image = Image(
              image: AssetImage('assets/img/original.png'),
              height: 200.0,
              fit: BoxFit.cover,
            );
          }

          return GestureDetector(
            onTap: () {
              modal.mainBottomSheet(context);
            },
            child: image,
          );
        }
      },
    );
  }

  Widget _showStreamTicket(DebtsBloc debtsBloc) {
    return StreamBuilder<String>(
      stream: debtsBloc.debtTicket,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          debt.fileName = snapshot.data;

          return Text('Imagen subida');
        } else {
          return Text('');
        }
      },
    );
  }

  void _submit(DebtsBloc debtsBloc) async {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    final resp = await debtsBloc.updateDebt(debt);

    if (resp['ok'] == true) {
      debtsBloc.deleteData();

      _printSnackbar(resp['message'], Colors.green, Colors.white);
    } else {
      _printSnackbar(resp['message'], Colors.red, Colors.white);
    }
  }

  void _printSnackbar(String message, Color backColor, Color textColor) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message, style: TextStyle(color: textColor)),
      duration: Duration(milliseconds: 1500),
      backgroundColor: backColor,
    ));
  }
}

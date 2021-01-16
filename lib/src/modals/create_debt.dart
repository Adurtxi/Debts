import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/blocs/debt/debt_bloc.dart';
import 'package:debts/src/blocs/user/user_bloc.dart';

import 'package:debts/src/modals/user_selector.dart';

import 'package:debts/src/models/debt_model.dart';
import 'package:debts/src/models/user_model.dart';

import 'package:debts/src/widgets/button_with_icon.dart';

class CreateDebtModal {
  DebtModel debt = new DebtModel();

  final _formKey = GlobalKey<FormState>();

  UserSelectorModal _uModal = UserSelectorModal();

  mainBottomSheet(BuildContext context) {
    final debtBloc = BlocProvider.of<DebtBloc>(context);

    BlocProvider.of<UserBloc>(context).add(
      UserSelect(null),
    );

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) => _container(context, debtBloc),
    );
  }

  Widget _container(BuildContext context, DebtBloc debtBloc) {
    return StatefulBuilder(
      builder: (BuildContext context, state) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _formContainer(context, state),
              _createButton(context, debtBloc),
            ],
          ),
        );
      },
    );
  }

  Widget _formContainer(BuildContext context, Function state) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            'Crear deuda',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              children: [
                _titleInput(),
                SizedBox(height: 20.0),
                _quantityInput(),
                SizedBox(height: 20.0),
                _selectDefaulter(context, state),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _titleInput() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Título',
        suffixIcon: Icon(
          Icons.title,
          color: Colors.black,
        ),
      ),
      onChanged: (value) => debt.title = value,
      validator: (value) =>
          (value.length < 3) ? 'El título tiene que contener más de 3 carácteres' : null,
    );
  }

  Widget _quantityInput() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Cantidad',
        suffixIcon: Icon(
          Icons.money_rounded,
          color: Colors.black,
        ),
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      onChanged: (value) => debt.quantity = double.parse(value),
      validator: (value) =>
          (double.parse(value) < 0) ? 'La cantidad tiene que ser mayor a 0€' : null,
    );
  }

  Widget _selectDefaulter(BuildContext context, Function state) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        String text = 'Seleccionar deudor';

        if (state is UserState && state.selectedUser != null) {
          UserModel user = state.selectedUser;
          debt.defaulterId = user.id;
          text = user.name;
        }

        return Container(
          height: 40.0,
          child: GestureDetector(
            onTap: () => _uModal.mainBottomSheet(context),
            child: ButtonWithIcon(
              size: 0.6,
              text: text,
              loading: false,
            ),
          ),
        );
      },
    );
  }

  Widget _createButton(BuildContext context, DebtBloc debtBloc) {
    return Container(
      margin: EdgeInsets.all(20.0),
      height: 50.0,
      child: RaisedButton(
        onPressed: () => _createDebt(context, debtBloc),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: ButtonWithIcon(
          size: 0.9,
          text: 'Crear deuda',
          loading: false,
        ),
      ),
    );
  }

  void _createDebt(BuildContext context, DebtBloc debtBloc) async {
    if (!_formKey.currentState.validate()) return;

    debtBloc.add(
      DebtStore(debt),
    );

    Navigator.pop(context);
  }
}

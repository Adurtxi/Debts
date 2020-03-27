import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:epbasic_debts/src/providers/debts_provider.dart';
import 'package:epbasic_debts/src/widgets/debtsList.dart';
import 'package:flutter/material.dart';

class DebtSearch extends SearchDelegate {
  final debtsProvider = new DebtsProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: debtsProvider.searchDebt(query),
      builder: (BuildContext context, AsyncSnapshot<List<DebtModel>> snapshot) {
        if (snapshot.hasData) {
          final debts = snapshot.data;

          return ListView(
            children: debts.map((debt) {
              final user = '${debt.user.name[0]}${debt.user.surname[0]}';

              return DebstList(debt: debt, user: user);
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

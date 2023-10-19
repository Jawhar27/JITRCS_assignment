import 'package:flutter/material.dart';
import 'package:jitrcs_assignment/data_sources/db_helper.dart';
import 'package:jitrcs_assignment/models/transaction.dart';
import 'package:provider/provider.dart';

class DataProvider with ChangeNotifier {
  
  Future<List<Transaction>> fetchTransactionData() async {
    List<Transaction> transactions = [];
    final fetchData = await DBHelper.getTransactionRecords();

    transactions = fetchData
        .map((record) => Transaction.fromJson(record))
        .toList();

    notifyListeners();
    return transactions;
  }

   Future<void> deleteTransaction(int id) async {
    DBHelper.deleteTransaction(id);
  }
}

DataProvider getDataProviderState(BuildContext context, {bool listen = false}) {
  return Provider.of<DataProvider>(context, listen: listen);
}

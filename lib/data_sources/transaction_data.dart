import 'package:jitrcs_assignment/models/transaction.dart';

List<Transaction> transactions = [
  Transaction(
    id: 1,
    transactionAmount: 300.0,
    transactionDate: '12-10-2023',
    transactionNumber: '12367545',
    transactionType: 'Withdrawal',
    comission: 250.0,
    typeOfOperation: 'Withdrawal',
  ),
  Transaction(
    id: 2,
    transactionAmount: 700.0,
    transactionDate: '14-10-2023',
    transactionNumber: '12398745',
    transactionType: 'Deposit',
    comission: 100.0,
    typeOfOperation: 'Replenishment',
  ),
  Transaction(
    id: 3,
    transactionAmount: 400.0,
    transactionDate: '12-08-2023',
    transactionNumber: '12342455',
    transactionType: 'Transfer',
    comission: 200.0,
    typeOfOperation: 'Transfer',
  ),
  Transaction(
    id: 4,
    transactionAmount: 200.0,
    transactionDate: '02-10-2023',
    transactionNumber: '45673455',
    transactionType: 'Deposit',
    comission: 100.0,
    typeOfOperation: 'Replenishment',
  ),
  Transaction(
    id: 5,
    transactionAmount: 350.0,
    transactionDate: '03-11-2023',
    transactionNumber: '99673455',
    transactionType: 'Deposit',
    comission: 60.0,
    typeOfOperation: 'Replenishment',
  ),

  Transaction(
    id: 6,
    transactionAmount: 100.0,
    transactionDate: '12-10-2023',
    transactionNumber: '19967545',
    transactionType: 'Withdrawal',
    comission: 30.0,
    typeOfOperation: 'Withdrawal',
  ),
];

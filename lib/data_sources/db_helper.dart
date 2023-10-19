import 'package:jitrcs_assignment/data_sources/transaction_data.dart';
import 'package:jitrcs_assignment/models/transaction.dart';
import 'package:jitrcs_assignment/utils/log_util.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // ----------------------------------Database connection------------------------------------------------------
  static Future<Database> databaseConnection() async {
    final databasePath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(databasePath, 'jitrcsApp.db'),
        version: 1);
  }

  static Future<void> createTable() async {
    final db = await DBHelper.databaseConnection();
    printLogs(db);
    printLogs("***********Creating Table****************");
    db.execute(
        'CREATE TABLE IF NOT EXISTS Transaction_Details(id INT PRIMARY KEY,transactionAmount DOUBLE, transactionDate String , transactionNumber TEXT, transactionType String,comission DOUBLE,typeOfOperation String)');
  }

  static Future<void> deleteTable() async {
    final db = await DBHelper.databaseConnection();
    db.execute('DROP TABLE Transaction_Details');
    printLogs("deleted");
  }

  static Future<void> insertTransaction() async {
    final db = await DBHelper.databaseConnection();
    final result =
        await db.rawQuery('select count(*) from Transaction_Details');
    if (result[0]['count(*)'] == 0) {
      printLogs('insert performingg');
      transactions.forEach((element) {
        Map<String, Object> records = {
          'id': element.id!,
          'transactionAmount': element.transactionAmount!,
          'transactionDate': element.transactionDate!,
          'transactionNumber': element.transactionNumber!,
          'transactionType': element.transactionType!,
          'comission': element.comission!,
          'typeOfOperation': element.typeOfOperation!,
        };
        db.insert('Transaction_Details', records);
      });
    }

    printLogs("************Records Succesfully INSERTED!************");
  }

  static Future<List<Map<String, dynamic>>> getTransactionRecords() async {
    final db = await DBHelper.databaseConnection();
    return db.query('Transaction_Details');
  }

  static Future<void> deleteTransaction(int id) async {
    final db = await DBHelper.databaseConnection();
    final result =
        await db.rawQuery('DELETE FROM Transaction_Details WHERE id="$id"');
  }
}

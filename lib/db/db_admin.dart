import 'dart:io';
import 'package:appgastos/models/gasto_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin {
  Database? myDatabase;

  static final DBAdmin _instance = DBAdmin._();
  DBAdmin._();

  factory DBAdmin() {
    return _instance;
  }

  Future<Database?> _checkDatabase() async {
    if (myDatabase == null) {
      myDatabase = await _initDatabase();
    }
    return myDatabase;
    //myDatabase ??= await initDatabase();
  }

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String pathdatabase = join(directory.path, "PagosDB.db");
    return await openDatabase(
      pathdatabase,
      version: 1,
      onCreate: (Database db, int version) {
        db.execute("""
          CREATE TABLE GASTOS(
            ID INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            price REAL,
            datetime TEXT,
            type TEXT
          )""");
      },
    );
  }

  // Future<int> insrtarGasto(Map<String, dynamic> data) async {
  Future<int> insrtarGasto(GastoModel gasto) async {
    Database? db = await _checkDatabase();
    int res = await db!.insert("GASTOS", gasto.convertirMap()
        // {
        //   "title": "Compras del mercado",
        //   "price": 1200.50,
        //   "datetime": "12/12/2024",
        //   "type": "Alimentos"
        // },
        );
    return res;
  }

  Future<List<GastoModel>> obetenerGastos() async {
    Database? db = await _checkDatabase();
    List<Map<String, Object?>> data = await db!.query("GASTOS");
    List<GastoModel> gastosList =
        data.map((e) => GastoModel.fromDB(e)).toList();

    print(data);
    print(gastosList);

    return gastosList;
    // print("------------");
    // print(db);
    // print("------------");
    // //  List<Map<String, Object?>> data = await db!.query("GASTOS");
    // List<Map<String, Object?>> data =
    //     await db!.rawQuery("Select title from gastos where type='Alimentos'");
    // print(data);
  }

  updateGasto() async {
    Database? db = await _checkDatabase();
    int res = await db!.update("GASTOS", {"price": 20});
    print(res);
  }

  deleteGasto(int id) async {
    Database? db = await _checkDatabase();
    int res = await db!.delete(
      "GASTOS",
      where: 'ID = ?',
      whereArgs: [id],
    );
    print(res);
  }

  Future<void> deleteGastoById(int id) async {
    Database? db = await _checkDatabase();
    await db!.delete("GASTOS", where: 'ID = ?', whereArgs: [id]);
  }
}

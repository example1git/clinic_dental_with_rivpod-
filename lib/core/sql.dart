import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("dintest.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onOpen: (db) async {
        // تفعيل العلاقات الخارجية (FK)
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE doctorPatient (
        id TEXT PRIMARY KEY,
        doctorID TEXT,
        patientID TEXT,
        doctorFullName TEXT,
        patientFullName TEXT,
        patientphone TEXT,
        isDeleteDoctor INTEGER,
        isDeletePatient INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE appointment (
        id TEXT PRIMARY KEY,
        treatmentCaseID TEXT,
        doctorPatientID TEXT,
        timeAppointment TEXT,
        payPrice INTEGER,
        teethSelected TEXT,
        descriptionTeeth TEXT,
        FOREIGN KEY (treatmentCaseID) REFERENCES treatmentCase(id) ON DELETE CASCADE 

      )
    ''');

    await db.execute('''
      CREATE TABLE treatmentCase (
        id TEXT PRIMARY KEY,
        doctorPatientID TEXT,
        totalPrice INTEGER,
        treatmentStatus TEXT,
        createdTime TEXT,
        FOREIGN KEY (doctorPatientID) REFERENCES doctorPatient(id) ON DELETE CASCADE ON UPDATE CASCADE 


      )
    ''');

    await db.execute('''
      CREATE TABLE doctor (
        id TEXT PRIMARY KEY,
        fullName TEXT,
        phone TEXT,
        equlatifications TEXT,
        isWorking INTEGER DEFAULT 1,
        imgUrl TEXT,
        gender TEXT,
        location TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE doctors (
        id TEXT PRIMARY KEY,
        fullName TEXT,
        phone TEXT,
        equlatifications TEXT,
        isWorking INTEGER DEFAULT 1,
        imgUrl TEXT,
        gender TEXT,
        location TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE patient (
        id TEXT PRIMARY KEY,
        fullName TEXT,
        phone TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE request (
        id TEXT PRIMARY KEY,
        patientID TEXT,
        doctorID TEXT,
        fullName TEXT,
        phone TEXT,
        stateRequest TEXT,
        sendTime TEXT,
        reciveTime TEXT
      )
    ''');

    // await db.execute('''
    //   CREATE TABLE doctorsForPatient (
    //     id TEXT PRIMARY KEY,
    //     fullName TEXT,
    //     doctorID TEXT,
    //     patientID TEXT
    //   )
    // ''');

    // await db.execute('''
    //   CREATE TABLE appointmentP (
    //     id TEXT PRIMARY KEY,
    //     treatmentCaseID TEXT,
    //     timeAppointment TEXT,
    //     payPrice INTEGER,
    //     teethSelected TEXT,
    //     descriptionTeeth TEXT,
    //     FOREIGN KEY (treatmentCaseID) REFERENCES treatmentCaseP(id) ON DELETE CASCADE
    //   )
    // ''');

    // await db.execute('''
    //   CREATE TABLE treatmentCaseP (
    //     id TEXT PRIMARY KEY,
    //     doctorPatientID TEXT,
    //     numberTreatmentCase INTEGER,
    //     totalPrice INTEGER,
    //     treatmentStatus TEXT,
    //     createdTime TEXT,
    //     createdAt TEXT,
    //     FOREIGN KEY (doctorPatientID) REFERENCES doctorsForPatient(id) ON DELETE CASCADE ON UPDATE CASCADE

    //   )
    // ''');

    // print('✅ Database created successfully');
  }

  // ====== عمليات CRUD ======
  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert(
      table,
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    final db = await instance.database;
    return await db.query(table);
  }

  Future<int> update(String table, Map<String, dynamic> row, String id) async {
    final db = await instance.database;
    return await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(String table, String id) async {
    final db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
      // print('✅ Database closed');
    }
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'dintest.db');

    // ✅ أغلق القاعدة أولاً إذا كانت مفتوحة
    if (_database != null) {
      await _database!.close();
      _database = null;
      // print('🔒 Database connection closed before deletion');
    }

    await deleteDatabase(path);
    print('🗑️ تم حذف قاعدة البيانات بنجاح');
  }
}

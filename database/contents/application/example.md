# 学生管理システム

## 概要

学生管理システムのER図は次のように表現される。

```{mermaid}
erDiagram
    STUDENT {
        string student_id PK
        string name
    }
    ENROLLMENT {
        string student_id PK, FK
        string course_id PK, FK
    }
    CLASS {
        string course_id PK
        string course_name
    }
    STUDENT ||--o{ ENROLLMENT : enrolls
    CLASS ||--o{ ENROLLMENT : contains
```

Pythonを使用してSQLiteデータベースを操作し、学生、コース、および登録情報を管理するシステムを実装する。

```plaintext
=============================================
 Welcome to the School Database System 
=============================================
1. 📚 List Students
2. 🏫 List Courses
3. ✍️  Enroll Student
4. 📋 Show Enrollments
5. ❌ Exit
6. 🔁 Show Options
=============================================

Enter your choice (1-6): 1

('S001', 'Alice')
('S002', 'Bob')
('S003', 'Charlie')

Enter your choice (1-6): 2

('CS101', 'Computer Science')
('CS102', 'Data Structures')
('CS103', 'Algorithms')

Enter your choice (1-6): 3

Enter Student ID: S001
Enter Course ID: CS101
Enrollment successful.

Enter your choice (1-6): 4
Alice is enrolled in Computer Science

Enter your choice (1-6): 5

Exiting the program. Goodbye!
```

## Python実装

まずは、`sqlite3`モジュールを`import`し、SQLiteデータベース`school.db`に接続する。データベースが存在しない場合は新たに作成される。

```python
import sqlite3

# Connect to SQLite database (or create it)
conn = sqlite3.connect("school.db")
cursor = conn.cursor()
```

次に、テーブルを作成するための関数を定義する。`Students`、`Courses`、および`Enrollments`の3つのテーブルを作成する。各テーブルには、主キーや外部キー制約が設定されている。

```python
def create_tables():
    cursor.execute(
        """
        CREATE TABLE IF NOT EXISTS Students (
        student_id TEXT PRIMARY KEY,
        name TEXT NOT NULL
    )
    """
    )

    cursor.execute(
        """
        CREATE TABLE IF NOT EXISTS Courses (
        course_id TEXT PRIMARY KEY,
        course_name TEXT NOT NULL
    )
    """
    )

    cursor.execute(
        """
        CREATE TABLE IF NOT EXISTS Enrollments (
        student_id TEXT,
        course_id TEXT,
        PRIMARY KEY (student_id, course_id),
        FOREIGN KEY (student_id) REFERENCES Students(student_id),
        FOREIGN KEY (course_id) REFERENCES Courses(course_id)
    )
    """
    )
```

これで、テーブルを作成する準備ができた。次に、サンプルデータを挿入するための関数を定義する。この関数は、`Students`と`Courses`テーブルにいくつかの初期データを挿入する。

```python
def insert_sample_data():
    cursor.executemany(
        """
        INSERT INTO Students (student_id, name) VALUES (?, ?)
        """,
        [
            ("S001", "Alice"),
            ("S002", "Bob"),
            ("S003", "Charlie"),
        ],
    )
    cursor.executemany(
        """
        INSERT INTO Courses (course_id, course_name) VALUES (?, ?)
        """,
        [
            ("CS101", "Computer Science"),
            ("CS102", "Data Structures"),
            ("CS103", "Algorithms"),
        ],
    )
    conn.commit()
```

次に、学生のリストを表示する関数を定義する。`cursor.fetchall()`を使用して、テーブルからすべての学生を取得し、`for`文で各行を表示する。

```python
def list_students():
    cursor.execute("SELECT * FROM Students")
    for row in cursor.fetchall():
        print(row)
```

同様に、コースのリストを表示する関数も定義する。

```python
def list_courses():
    cursor.execute("SELECT * FROM Courses")
    for row in cursor.fetchall():
        print(row)
```

次に、学生をコースに登録するための関数を定義する。この関数は、学生IDとコースIDを受け取り、`Enrollments`テーブルに新しい行を挿入する。`student_id`と`course_id`が存在しない場合はエラーメッセージを表示し、登録が成功した場合は成功メッセージを表示する。もし学生がすでにそのコースに登録されている場合は、登録失敗のメッセージを表示する。

```python
def enroll_student(student_id, course_id):
    cursor.execute("SELECT * FROM Students WHERE student_id = ?", (student_id,))
    if not cursor.fetchone():
        print("Student ID not found.")
        return
    cursor.execute("SELECT * FROM Courses WHERE course_id = ?", (course_id,))
    if not cursor.fetchone():
        print("Course ID not found.")
        return
    try:
        cursor.execute(
            "INSERT INTO Enrollments ('student_id', 'course_id') VALUES (?, ?)",
            (student_id, course_id),
        )
        conn.commit()
        print("Enrollment successful.")
    except sqlite3.IntegrityError:
        print("Enrollment failed. Student is already enrolled in this course.")
```

次に、登録状況を表示する関数を定義する。この関数は、`Enrollments`テーブルと`Students`および`Courses`テーブルを結合して、どの学生がどのコースに登録されているかを表示する。

```python
def show_enrollments():
    cursor.execute(
        """
    SELECT Students.name, Courses.course_name
    FROM Enrollments
    JOIN Students ON Enrollments.student_id = Students.student_id
    JOIN Courses ON Enrollments.course_id = Courses.course_id
    """
    )
    for row in cursor.fetchall():
        print(f"{row[0]} is enrolled in {row[1]}")
```

テーブルが空である場合にサンプルデータを挿入するためのコードを追加する。`Students`テーブルと`Courses`テーブルの行数を確認し、両方が空であればサンプルデータを挿入する。

```python
def initialize_database():
    student_count = cursor.execute("SELECT COUNT(*) FROM Students").fetchone()[0]
    course_count = cursor.execute("SELECT COUNT(*) FROM Courses").fetchone()[0]
    if student_count == 0 and course_count == 0:
        print("Inserting sample data...")
        insert_sample_data()
```

簡単なコマンドラインインターフェース（CLI）を作成する。ユーザーはメニューから選択し、学生のリスト表示、コースのリスト表示、学生の登録、登録状況の表示などを行うことができる。

```python
def print_menu():
    print("\n" + "=" * 45)
    print(" Welcome to the School Database System ")
    print("=" * 45)
    print(
        "1. 📚 List Students\n"
        "2. 🏫 List Courses\n"
        "3. ✍️  Enroll Student\n"
        "4. 📋 Show Enrollments\n"
        "5. ❌ Exit\n"
        "6. 🔁 Show Options"
    )
    print("=" * 45)


def menu():
    print_menu()
    while True:
        choice = input("\nEnter your choice (1-6): ").strip()
        print()

        if choice == "1":
            list_students()
        elif choice == "2":
            list_courses()
        elif choice == "3":
            s_id = input("Enter Student ID: ").strip()
            c_id = input("Enter Course ID: ").strip()
            enroll_student(s_id, c_id)
        elif choice == "4":
            show_enrollments()
        elif choice == "5":
            print("Exiting the program. Goodbye!")
            break
        elif choice == "6":
            print_menu()
        else:
            print("Invalid choice")
```

`main()`関数を定義して、データベースの初期化、メニューの表示、および接続のクローズを行う。

```python
def main():
    create_tables()
    initialize_database()
    menu()
    conn.close()
```

作成したデータベースを実行してみよう。

```python
if __name__ == "__main__":
    main()
```


## ソースコード

```python
import sqlite3

# Connect to SQLite database (or create it)
conn = sqlite3.connect("school.db")
cursor = conn.cursor()


def create_tables():
    cursor.execute(
        """
        CREATE TABLE IF NOT EXISTS Students (
        student_id TEXT PRIMARY KEY,
        name TEXT NOT NULL
    )
    """
    )

    cursor.execute(
        """
        CREATE TABLE IF NOT EXISTS Courses (
        course_id TEXT PRIMARY KEY,
        course_name TEXT NOT NULL
    )
    """
    )

    cursor.execute(
        """
        CREATE TABLE IF NOT EXISTS Enrollments (
        student_id TEXT,
        course_id TEXT,
        PRIMARY KEY (student_id, course_id),
        FOREIGN KEY (student_id) REFERENCES Students(student_id),
        FOREIGN KEY (course_id) REFERENCES Courses(course_id)
    )
    """
    )


def insert_sample_data():
    cursor.executemany(
        """
        INSERT INTO Students (student_id, name) VALUES (?, ?)
        """,
        [
            ("S001", "Alice"),
            ("S002", "Bob"),
            ("S003", "Charlie"),
        ],
    )
    cursor.executemany(
        """
        INSERT INTO Courses (course_id, course_name) VALUES (?, ?)
        """,
        [
            ("CS101", "Computer Science"),
            ("CS102", "Data Structures"),
            ("CS103", "Algorithms"),
        ],
    )
    conn.commit()


def list_students():
    cursor.execute("SELECT * FROM Students")
    for row in cursor.fetchall():
        print(row)


def list_courses():
    cursor.execute("SELECT * FROM Courses")
    for row in cursor.fetchall():
        print(row)


def enroll_student(student_id, course_id):
    cursor.execute("SELECT * FROM Students WHERE student_id = ?", (student_id,))
    if not cursor.fetchone():
        print("Student ID not found.")
        return
    cursor.execute("SELECT * FROM Courses WHERE course_id = ?", (course_id,))
    if not cursor.fetchone():
        print("Course ID not found.")
        return
    try:
        cursor.execute(
            "INSERT INTO Enrollments ('student_id', 'course_id') VALUES (?, ?)",
            (student_id, course_id),
        )
        conn.commit()
        print("Enrollment successful.")
    except sqlite3.IntegrityError:
        print("Enrollment failed. Student is already enrolled in this course.")


def show_enrollments():
    cursor.execute(
        """
    SELECT Students.name, Courses.course_name
    FROM Enrollments
    JOIN Students ON Enrollments.student_id = Students.student_id
    JOIN Courses ON Enrollments.course_id = Courses.course_id
    """
    )
    for row in cursor.fetchall():
        print(f"{row[0]} is enrolled in {row[1]}")


def initialize_database():
    student_count = cursor.execute("SELECT COUNT(*) FROM Students").fetchone()[0]
    course_count = cursor.execute("SELECT COUNT(*) FROM Courses").fetchone()[0]
    if student_count == 0 and course_count == 0:
        print("Inserting sample data...")
        insert_sample_data()


def print_menu():
    print("\n" + "=" * 45)
    print(" Welcome to the School Database System ")
    print("=" * 45)
    print(
        "1. 📚 List Students\n"
        "2. 🏫 List Courses\n"
        "3. ✍️  Enroll Student\n"
        "4. 📋 Show Enrollments\n"
        "5. ❌ Exit\n"
        "6. 🔁 Show Options"
    )
    print("=" * 45)


def menu():
    print_menu()
    while True:
        choice = input("\nEnter your choice (1-6): ").strip()
        print()

        if choice == "1":
            list_students()
        elif choice == "2":
            list_courses()
        elif choice == "3":
            s_id = input("Enter Student ID: ").strip()
            c_id = input("Enter Course ID: ").strip()
            enroll_student(s_id, c_id)
        elif choice == "4":
            show_enrollments()
        elif choice == "5":
            print("Exiting the program. Goodbye!")
            break
        elif choice == "6":
            print_menu()
        else:
            print("Invalid choice")


def main():
    create_tables()
    initialize_database()
    menu()
    conn.close()


if __name__ == "__main__":
    main()
```

## 練習問題

1. 学生情報を追加する機能を実装せよ。
2. 学生数をカウントする機能を追加せよ。
3. 点数`score`を`Enrollments`テーブルに追加し、学生ごとの点数を登録する機能を実装せよ。
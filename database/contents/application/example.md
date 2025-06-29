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
1. List Students
2. List Courses
3. Enroll Student
4. Show Enrollments
5. Exit
6. Show Options

Enter choice: __1__

('S001', 'Alice')
('S002', 'Bob')
('S003', 'Charlie')

Enter choice: __2__

('CS101', 'Computer Science')
('CS102', 'Data Structures')
('CS103', 'Algorithms')

Enter choice: __3__
Student ID: __S001__
Course ID: __CS101__
Enrollment successful.

Enter choice: __4__
Alice is enrolled in Computer Science
```

## Python実装

まずは、`sqlite3`モジュールを`import`し、SQLiteデータベース`school.db`に接続する。データベースが存在しない場合は新たに作成される。

```python
import sqlite3

# Connect to SQLite database (or create it)
conn = sqlite3.connect("school.db")
cursor = conn.cursor()
```

次に、学生、コース、および登録のためのテーブルを作成する。

```python
# Create tables if they do not exist
cursor.execute(
    """CREATE TABLE IF NOT EXISTS Students (
    student_id TEXT PRIMARY KEY,
    name TEXT NOT NULL
)"""
)
cursor.execute(
    """CREATE TABLE IF NOT EXISTS Courses (
    course_id TEXT PRIMARY KEY,
    course_name TEXT NOT NULL
)"""
)
cursor.execute(
    """CREATE TABLE IF NOT EXISTS Enrollments (
    student_id TEXT,
    course_id TEXT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
)"""
)
```

これで、`Students`、`Courses`、および`Enrollments`の3つのテーブルが作成された。以下はテーブルにデータを挿入するための関数を定義する。

```python
# Sample data
def insert_sample_data():
    cursor.execute(
        """INSERT INTO Students (student_id, name) VALUES
        ('S001', 'Alice'),
        ('S002', 'Bob'),
        ('S003', 'Charlie')"""
    )
    cursor.execute(
        """INSERT INTO Courses (course_id, course_name) VALUES
        ('CS101', 'Computer Science'),
        ('CS102', 'Data Structures'),
        ('CS103', 'Algorithms')"""
    )
    conn.commit()
```

次に、学生のリストを表示する関数を定義する。`cursor.fetchall()`を使用して、テーブルからすべての学生を取得し、`for`文で各行を表示する。

```python
# View functions
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

次に、学生をコースに登録するための関数を定義する。この関数は、学生IDとコースIDを受け取り、`Enrollments`テーブルに新しい行を挿入する。`try`と`except`を使用して、例外処理を行う。例えば、学生IDやコースIDが存在しない場合や、重複した登録が発生した場合に`sqlite3.IntegrityError`をキャッチし、エラーメッセージを表示する。

```python
def enroll_student(student_id, course_id):
    try:
        cursor.execute(
            "INSERT INTO Enrollments ('student_id', 'course_id') VALUES (?, ?)",
            (student_id, course_id),
        )
        conn.commit()
        print("Enrollment successful.")
    except sqlite3.IntegrityError:
        print("Enrollment failed. Check IDs or duplicate entry.")
```

次に、登録状況を表示する関数を定義する。この関数は、`Enrollments`テーブルと`Students`および`Courses`テーブルを結合して、どの学生がどのコースに登録されているかを表示する。

```python
def show_enrollments():
    cursor.execute(
        """SELECT Students.name, Courses.course_name
        FROM Enrollments
        JOIN Students ON Enrollments.student_id = Students.student_id
        JOIN Courses ON Enrollments.course_id = Courses.course_id"""
    )
    for row in cursor.fetchall():
        print(f"{row[0]} is enrolled in {row[1]}")
```

テーブルが空である場合にサンプルデータを挿入するためのコードを追加する。`Students`テーブルと`Courses`テーブルの行数を確認し、両方が空であればサンプルデータを挿入する。

```python
# If the tables are empty, insert sample data
cursor.execute("SELECT COUNT(*) FROM Students")
if cursor.fetchone()[0] == 0:
    cursor.execute("SELECT COUNT(*) FROM Courses")
    if cursor.fetchone()[0] == 0:
        # Insert sample data if both tables are empty
        print("Inserting sample data...")
        insert_sample_data()
```

最後に、簡単なコマンドラインインターフェース（CLI）を作成する。ユーザーはメニューから選択し、学生のリスト表示、コースのリスト表示、学生の登録、登録状況の表示などを行うことができる。

```python
# Simple CLI
def menu():
    print(
        "\n1. List Students\n2. List Courses\n3. Enroll Student\n4. Show Enrollments\n5. Exit\n6. Show Options"
    )
    while True:
        choice = input("\nEnter choice: ")
        if choice == "1":
            list_students()
        elif choice == "2":
            list_courses()
        elif choice == "3":
            s_id = input("Student ID: ")
            c_id = input("Course ID: ")
            enroll_student(s_id, c_id)
        elif choice == "4":
            show_enrollments()
        elif choice == "5":
            break
        elif choice == "6":
            print(
                "\n1. List Students\n2. List Courses\n3. Enroll Student\n4. Show Enrollments\n5. Exit\n6. Show Options\n"
            )
        else:
            print("Invalid choice")
```

以上で、SQLiteを使用した学生管理システムの基本的な構造が完成した。

作成したデータベースを実行してみよう。

```python
if __name__ == "__main__":
    menu()
    conn.close()
```

## ソースコード

```python
import sqlite3

# Connect to SQLite database (or create it)
conn = sqlite3.connect("school.db")
cursor = conn.cursor()

# Create tables if they do not exist
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


# Sample data
def insert_sample_data():
    cursor.execute(
        """
    INSERT INTO Students (student_id, name) VALUES
    ('S001', 'Alice'),
    ('S002', 'Bob'),
    ('S003', 'Charlie')
    """
    )
    cursor.execute(
        """
    INSERT INTO Courses (course_id, course_name) VALUES
    ('CS101', 'Computer Science'),
    ('CS102', 'Data Structures'),
    ('CS103', 'Algorithms')
    """
    )
    conn.commit()


# View functions
def list_students():
    cursor.execute("SELECT * FROM Students")
    for row in cursor.fetchall():
        print(row)


def list_courses():
    cursor.execute("SELECT * FROM Courses")
    for row in cursor.fetchall():
        print(row)


def enroll_student(student_id, course_id):
    try:
        cursor.execute(
            "INSERT INTO Enrollments ('student_id', 'course_id') VALUES (?, ?)",
            (student_id, course_id),
        )
        conn.commit()
        print("Enrollment successful.")
    except sqlite3.IntegrityError:
        print("Enrollment failed. Check IDs or duplicate entry.")


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


# If the tables are empty, insert sample data
cursor.execute("SELECT COUNT(*) FROM Students")
if cursor.fetchone()[0] == 0:
    cursor.execute("SELECT COUNT(*) FROM Courses")
    if cursor.fetchone()[0] == 0:
        # Insert sample data if both tables are empty
        print("Inserting sample data...")
        insert_sample_data()


# Simple CLI
def menu():
    print(
        "\n1. List Students\n2. List Courses\n3. Enroll Student\n4. Show Enrollments\n5. Exit\n6. Show Options"
    )
    while True:
        choice = input("\nEnter choice: ")
        if choice == "1":
            list_students()
        elif choice == "2":
            list_courses()
        elif choice == "3":
            s_id = input("Student ID: ")
            c_id = input("Course ID: ")
            enroll_student(s_id, c_id)
        elif choice == "4":
            show_enrollments()
        elif choice == "5":
            break
        elif choice == "6":
            print(
                "\n1. List Students\n2. List Courses\n3. Enroll Student\n4. Show Enrollments\n5. Exit\n6. Show Options\n"
            )
        else:
            print("Invalid choice")


if __name__ == "__main__":
    menu()
    conn.close()
```

## 練習問題

1. 学生情報を追加する機能を実装せよ。
2. 学生数をカウントする機能を追加せよ。
3. 点数`score`を`Enrollments`テーブルに追加し、学生ごとの点数を登録する機能を実装せよ。
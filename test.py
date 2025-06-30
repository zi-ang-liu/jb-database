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
        "3. ✍️ Enroll Student\n"
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

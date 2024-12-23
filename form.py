from flask import Flask, request, jsonify
from flask_cors import CORS
import MySQLdb
import MySQLdb.cursors

app = Flask(__name__)
CORS(app)

# Database configuration
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '0123456'
app.config['MYSQL_DB'] = 'root'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

# Initialize MySQL
db = MySQLdb.connect(
    host=app.config['MYSQL_HOST'],
    user=app.config['MYSQL_USER'],
    password=app.config['MYSQL_PASSWORD'],
    db=app.config['MYSQL_DB'],
    cursorclass=MySQLdb.cursors.DictCursor
)

@app.route('/')
def index():
    return jsonify({"message": "Server is running"}), 200

@app.route('/signup', methods=['POST'])
def signup():
    data = request.get_json()
    username = data['username']
    student_id = data['student_id']
    device_id = data['device_id']
    email = data['email']
    academic_year = data['academic_year']

    

    cursor = db.cursor()
    cursor.execute("SELECT * FROM users WHERE device_id = %s", (device_id,))
    account = cursor.fetchone()
    if account:
        return jsonify({"message": "Username already exists"}), 409

    cursor.execute("INSERT INTO users (username, student_id, device_id, email, academic_year) VALUES (%s, %s, %s, %s, %s)", (username, student_id, device_id, email, academic_year))
    db.commit()

    return jsonify({"message": "User created successfully"}), 201

@app.route('/signin', methods=['POST'])
def signin():
    data = request.get_json()
    device_id = data['device_id']

    cursor = db.cursor()
    cursor.execute("SELECT * FROM users WHERE device_id = %s", (device_id,))
    account = cursor.fetchone()

    if account:
        return jsonify({"message": "Login successful", "device_id": account['device_id']}), 200
    else:
        return jsonify({"message": "Invalid device ID"}), 401

@app.route('/profile', methods=['GET'])
def profile():
    device_id = request.args.get('device_id')

    cursor = db.cursor()
    cursor.execute("SELECT * FROM users WHERE device_id = %s", (device_id,))
    account = cursor.fetchone() 

    if account:
        return jsonify({
            "username": account['username'], 
            "student_id": account['student_id'],# 
            "device_id": account['device_id'],#
            "to": "khamiiiis", #
            "note_today":"You have Midterm Exam Next Leacture,Study hard and don't worry ",
            "Break_time": "09:00 AM",
            "Next_Lecture_time": "10:00 AM",#
            "Next_Lecture_subject": "Math",#
            "lecture_end": "10:00 AM",
            "Comment": "Good performance today",
            "Id": "14",#
            "No_of_Presence": "18",
            "No_of_Absence": "3",
            "total_time_of_Lateness": "2 h",
            "Check_in_time": "08:00 AM"
        }), 200
    else:
        return jsonify({"message": "User not found"}), 404

@app.route('/profile2', methods=['GET'])
def profile2():
    device_id = request.args.get('device_id')

    cursor = db.cursor()
    cursor.execute("SELECT * FROM users WHERE device_id = %s", (device_id,))
    account = cursor.fetchone() 

    if account:
        return jsonify({
            "username": account['username'], 
            "student_id": account['student_id'], 
            "email": account['email'], 
            "academic_year": account['academic_year'], 

        }), 200
    else:
        return jsonify({"message": "User not found"}), 404

@app.route('/check_device', methods=['POST'])
def check_device():
    data = request.get_json()
    device_id = data['device_id']

    cursor = db.cursor()
    cursor.execute("SELECT * FROM users WHERE device_id = %s", (device_id,))
    account = cursor.fetchone()

    if account:
        return jsonify({"message": "Device found", "device_id": account['device_id']}), 200
    else:
        return jsonify({"message": "Device not found"}), 404

@app.route('/leaderboard', methods=['GET'])
def leaderboard():
    cursor = db.cursor()
    cursor.execute("SELECT username, student_id FROM users ORDER BY student_id DESC")
    users = cursor.fetchall()

    return jsonify(users), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

from flask import Flask, render_template, json, request
from flask.ext.mysql import MySQL
from werkzeug import generate_password_hash, check_password_hash

app = Flask(__name__)

mysql = MySQL()
# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'rems'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)

@app.route("/")
def main():
  return render_template('index.html')

@app.route('/showSignUp')
def showSignUp():
  return render_template('signup.html')
  
@app.route('/signUp',methods=['POST'])
def signUp():
  _name = request.form['inputName']
  _email = request.form['inputEmail']
  _password = request.form['inputPassword']
  # create user code will be here !!
  _hashed_password = generate_password_hash(_password)
  conn = mysql.connect()
  cursor = conn.cursor()
  cursor.callproc('sp_createUser',(_name,_email,_hashed_password))
  
  data = cursor.fetchall()
 
  if len(data) is 0:
    conn.commit()
    return json.dumps({'message':'User created successfully !'})
  else:
    return json.dumps({'error':str(data[0])})

if __name__ == '__main__':
  app.run()

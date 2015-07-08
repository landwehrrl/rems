from flask import Flask, render_template, json, request, session, redirect
from flask.ext.mysql import MySQL
from werkzeug import generate_password_hash, check_password_hash
from rems.views import pages

app = Flask(__name__, static_url_path='')
app.secret_key = 'CHANGE_FOR_REAL_WORLD'

mysql = MySQL()
# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'root'
app.config['MYSQL_DATABASE_DB'] = 'rems'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)

def callSQLStoredProcedure(sp,*kwargs):
  global conn,cursor
  conn = mysql.connect()
  cursor = conn.cursor()
  cursor.callproc(sp,*kwargs)
  return cursor.fetchall()
  
@app.route("/")
def main():
  return render_template('index.html')

@app.route('/rems')
def rems():
  return render_template('rems.html' , user = data[0][1], session = session)

@app.route('/validateLogin',methods=['POST'])
def validateLogin():
  _name = request.form['inputName']
  _password = request.form['inputPassword']
    
  try:
    data = callSQLStoredProcedure('sp_validateUser',(_name,))
    if len(data) > 0 and check_password_hash(str(data[0][2]),_password):
      session['user'] = data[0][0]
      return render_template('rems.html' , user = data[0][1], session = session)
    return render_template('index.html', error = 'Incorrect Username or Password');
  except Exception as e:
    print str(e)
    return render_template('index.html', error = 'General Error');
  finally:
    cursor.close()
    conn.close()
'''
Only use to add users
'''
@app.route('/signUp',methods=['POST'])
def signUp():
  _name = request.form['inputName']
  _password = request.form['inputPassword']
  _hashed_password = generate_password_hash(_password)
  
  data = callSQLStoredProcedure('sp_createUser',(_name,_hashed_password))
  if len(data) is 0:
    conn.commit()
    return 'Added User' #could move to render template if added as admin option later
  else:
    return 'Failed' #could move to render template if admin option added later
  #Maybe add roles for users, granting admin... or not.
  
if __name__ == '__main__':
  app.run()

def register_blueprints(app):
  app.register_blueprint(pages)

register_blueprints(app)

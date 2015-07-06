from flask import Flask, render_template, json, request, session, redirect
from flask.ext.mysql import MySQL
from werkzeug import generate_password_hash, check_password_hash
from rems.views import pages

app = Flask(__name__, static_url_path='')
app.secret_key = 'CHANGE_FOR_REAL_WORLD'

mysql = MySQL()
# MySQL configurations
try:
  app.config['MYSQL_DATABASE_USER'] = 'root'
  app.config['MYSQL_DATABASE_PASSWORD'] = 'root'
  app.config['MYSQL_DATABASE_DB'] = 'rems'
  app.config['MYSQL_DATABASE_HOST'] = 'localhost'
  mysql.init_app(app)
except Exception, e:
  print e

@app.route("/")
def main():
  return render_template('index.html')

@app.route('/rems')
def rems():
  return render_template('rems.html' , user = currentUser, session = session)

@app.route('/validateLogin',methods=['POST'])
def validateLogin():
  try:
    _name = request.form['inputName']
    _password = request.form['inputPassword']
    _hashed_password = generate_password_hash(_password)
    
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.callproc('sp_validateUser',(_name,))
    data = cursor.fetchall()
  
    if len(data) > 0:
      if check_password_hash(str(data[0][2]),_password):
        session['user'] = data[0][0]
        global currentUser
        currentUser = str(data[0][1])
        print 'currentUser ' + str(currentUser)
        return redirect('/rems')
      else:
        return render_template('index.html', error = 'Incorrect Username or Password');
    else:
      return render_template('index.html', error = 'Incorrect Username or Password');
  except Exception as e:
    print str(e)
    return render_template('index.html', error = 'General Error');
  finally:
    cursor.close()
    conn.close()

    
@app.route('/signUp',methods=['POST'])
def signUp():
  '''
  Only used to add users use index.html.addusers
  '''

  _name = request.form['inputName']
  _password = request.form['inputPassword']
  _hashed_password = generate_password_hash(_password)
    
  conn = mysql.connect()
  cursor = conn.cursor()
  cursor.callproc('sp_createUser',(_name,_hashed_password))
  
  data = cursor.fetchall()
 
  if len(data) is 0:
    conn.commit()
    return 'made it'
  else:
    return 'internal error'
  
if __name__ == '__main__':
  app.run()

def register_blueprints(app):
  app.register_blueprint(pages)

register_blueprints(app)

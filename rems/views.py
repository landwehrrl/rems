from flask import Blueprint, request, redirect, render_template, url_for
from flask.views import MethodView

pages = Blueprint('pages', __name__, template_folder='templates')

class IndexView(MethodView):
  def get(self):
    return render_template('index.html')

class RemsView(MethodView):
  def get(self):
    return render_template('rems.html')
  
pages.add_url_rule('/',view_func=IndexView.as_view('indexPage'))
pages.add_url_rule('/rems',view_func=RemsView.as_view('remsPage'))
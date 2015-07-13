import os, csv, time
from flask import Flask, render_template, request, redirect, url_for, send_from_directory,jsonify
from werkzeug import secure_filename

#
#TODO -> CHANGE FROM PYMONGO TO MYSQL, move MYSQL functions from __init__ to a mysql.py file import here and there.
#
current_time = time.strftime("%d%b%Y.%H:%M:%S")

def upload(app):
    file = request.files['file']
    entryDate = request.form['entryDate']
    entryDate = entryDate.split(' ')
    month = entryDate[0]
    year = entryDate[1]
	
    if file and allowed_file(file.filename, app):
        filename = secure_filename(file.filename)
        file.save(os.path.join(app.config['UPLOAD_FOLDER'],filename))
        #completionMessage = addToMongo(month,year,filename,app)
        completionMessage = 'MADE IT'
        return render_template('rems.html', reloadVals = {'type':'Entry','msg':completionMessage})
    else:
        return render_template('rems.html', reloadVals = {'type':'Entry','msg':'File Upload <span style = color:red>FAILED</span><br \> Using Correct Format?'})

def allowed_file(filename, app):
    return '.' in filename and filename.rsplit('.',1)[1] in app.config['ALLOWED_EXTENSIONS']

def addToMySQL(month, year, filename, app):
	with open(os.path.join(app.config['UPLOAD_FOLDER'],filename), 'r') as fh:
	    data = [row for row in csv.reader(fh.read().splitlines())]
	if(data[0] == ['Nickname','PropID','Amount','Type','Due','Paid','Notes']):
	#	from housing.upload import parseBills
		msg = parseBills(filename, month, year, data)
	
	elif (data[0] == ['PropertyID','Nickname','Amount','DueDate','PaidDate']):
	#	from housing.upload import parseTaxes
		msg = parseTaxes(filename, month, year, data)
	
	elif (data[0] == ['Date','PropID','Nickname','Contractor','LaborCost','MaterialCost','Paid','Comments']):
	#	from housing.upload import parseMaint
		msg = parseMaint(filename, month, year, data)

	elif (data[0] == ['PropID','Nickname','Unit','Tenant','Rent','Paid','Owes','DueDate','PaidDate','Comments']):
	#	from housing.upload import parseRent
		msg = parseRent(filename, month, year, data)
	else:
		msg = filename + " <span style = color:red>FAILED</span> to parse: \n" + data[0]
		#TODO add useful debugging for user
		#msg = debugSortingParse(data[0])
	return msg

def restore (fileName, itemList):
	for ob in itemList:
		ob.save()
		print 'saved ' + str(ob.year) + " " + ob.month
	os.system("rm uploads/" + fileName)
    #TODO create more helpful msg for CSV troubleshooting

def removeOld(itemList, month, year):
	#remove old items from same month/year
	objList = []
	for myItem in itemList:
		print 'This is the oldItem list: ' + str(myItem.year) + ' ' + myItem.month + ' ' + str(year) + ' ' + month
		if(str(myItem.year) == year and myItem.month == month):
			objList.append(myItem)
			myItem.delete()
			print 'removed item ' + str(myItem.year) + " " + myItem.month
	return objList

def parseBills(fileName, month, year, data):
	from housing.models import MonthlyBillEntries, Bills

	oldBills = MonthlyBillEntries.objects.all()
	billList = removeOld(oldBills, month, year)
    #replace the old documents with the new ones
	try:
		monthlyBills = MonthlyBillEntries(
	    	year = year,
	    	month = month
	    	)
		monthlyBills.save()
    
		for x in range(1,len(data)):
			monthlyBills.billEntries 
			[]
			newBills = Bills(
			    nickname = data[x][0],
			    prop_id = data[x][1],
			    amount = data[x][2],
			    bill_type = data[x][3],
			    due_date = data[x][4],
			    paid = data[x][5],
			    comments = data[x][6]
			    )
			monthlyBills.billEntries.append(newBills)
			monthlyBills.save()
	except:
	    restore(fileName, billList)
	    return "Bill Upload Failed, reverted back to old list"
	os.system("mv uploads/" + fileName + " uploads/" + year + "/" + month + "/BILL" + "." + current_time)
	return 'Updated Bills!'

def parseTaxes(fileName, month, year, data):
	from housing.models import MonthlyTaxEntries, Taxes
	oldTaxes = MonthlyTaxEntries.objects.all()
	taxList = removeOld(oldTaxes, month, year)
	#replace the old documents with the new ones
	try:
		monthlyTaxes = MonthlyTaxEntries(
	    	year = year,
	    	month = month
	    	)
		
		for x in range(1,len(data)):
			monthlyTaxes.taxEntries 
			[]
			newTaxes = Taxes(
			    prop_id = data[x][0],
			    nickname = data[x][1],
			    amount = data[x][2],
			    due_date = data[x][3],
			    paid_date = data[x][4]
			    )
			monthlyTaxes.taxEntries.append(newTaxes)
		monthlyTaxes.save()

	except:
	    restore(fileName, taxList)
	    return "Tax Upload Failed, reverted back to old list"
	os.system("mv uploads/" + fileName + " uploads/" + year + "/" + month + "/TAX" + "." + current_time)
	return 'Updated Taxes!'
def parseMaint(fileName, month, year, data):
	from housing.models import MonthlyMaintenanceEntries, Maintenance
	oldMaint = MonthlyMaintenanceEntries.objects.all()
	maintList = removeOld(oldMaint, month, year)
    #replace the old documents with the new ones
	try:
		monthlyMaintenance = MonthlyMaintenanceEntries(
	    	year = year,
	    	month = month
	    	)
		for x in range(1,len(data)):
			monthlyMaintenance.maintenanceEntries 
			[]
			newMaint = Maintenance(
			    date = data[x][0],
			    prop_id = data[x][1],
			    nickname = data[x][2],
			    contractor = data[x][3],
			    labor_cost = data[x][4],
			    material_cost = data[x][5],
			    paid = data[x][6],
			    comments = data[x][7]
			    )
			monthlyMaintenance.maintenanceEntries.append(newMaint)
		monthlyMaintenance.save()
	except:
	    restore(fileName, maintList)
	    return "Maintenance Upload Failed, reverted back to old list"
	os.system("mv uploads/" + fileName + " uploads/" + year + "/" + month + "/MAINT" + "." + current_time)
	return 'Updated Maintenance!'

def parseRent(fileName, month, year, data):
	from housing.models import MonthlyRentEntries, Rent
	oldRent = MonthlyRentEntries.objects.all()
	rentList = removeOld(oldRent, month, year)
    #replace the old documents with the new ones
	try:
		monthlyRent = MonthlyRentEntries(
	    	year = year,
	    	month = month
	    	)
		for x in range(1,len(data)):
			monthlyRent.rentEntries 
			[]
			newRent = Rent(
				prop_id = data[x][0],
				nickname = data[x][1],
				unit = data[x][2],
				tenant = data[x][3],
				rent = data[x][4],
				paid = data[x][5],
				owes = data[x][6],
				due_date = data[x][7],
				paid_date = data[x][8],
				comments = data[x][9]
				)
			monthlyRent.rentEntries.append(newRent)
		monthlyRent.save()
	except:
		restore(fileName, rentList)
		return "Rent Upload Failed, reverted back to former state"
	os.system("mv uploads/" + fileName + " uploads/" + year + "/" + month + "/RENT" + "." + current_time)
	return 'Updated Rent!'
/*jslint browser:true, devel:true */ 

/*global rent, tables*/
var months = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
var monthToNumber = {"JAN":"00", "FEB":"01", "MAR":"02", "APR":"03", "MAY":"04", "JUN":"05", "JUL":"06", "AUG":"07", "SEP":"08", "OCT":"09", "NOV":"10", "DEC":"11"};
var today = new Date();

function reloadTabs(nameVal){
  console.log("HELLO! " + nameVal.type + " " + nameVal.msg);
  if(nameVal.type == 'Rent'){ rent.loadRent(); }
  else if(nameVal.type == 'Maint'){ loadMaint(); }
  else if(nameVal.type == 'Bills'){ loadBills(); }
  else if(nameVal.type == 'Taxes'){ loadTenants(); }
  else if(nameVal.type == 'Entry'){ loadEntry(nameVal.msg); }
  else{ /*ignore*/ }
}
function loadRent(){
  setTabs("Rent");
  setLinks(["Current Rent Status","Year To Date Rent Status"]);
  setCustomRange("Custom Rent Status"); //in rent.js
}
function loadMaint(){
  setTabs("Maint");
  setLinks(["Most Recent Month Maintenance", "Year To Date Maintenance", "Custom Maintenance"]);
}
function loadBills(){
  setTabs("Bills");	
  setLinks([]);
}
function loadTenants(){
  setTabs("Tenants");	
  setLinks([]);
}
function loadEntry(msg){
  if(!msg){ msg = " "; }
  setTabs("Entry");	
  setDownload(msg); //in entry.js
}
function setTabs(uniqueTab){
	var tabs = document.getElementsByClassName("uiTab");
	for(var i=0; i < tabs.length; i++){
	  if(tabs[i].style.backgroundColor === "black"){
        tabs[i].removeAttribute("style");
      }
	}
	var tab = document.getElementById("menuTabs" + uniqueTab);
    tab.style.backgroundColor = "black";
    tab.style.color = "white";
}

function setLinks(links){
	var index;
	var htmlText = "<ul id='tabFunctions'>";
	for(index=0;index<links.length;index++){
		var linksFunction = links[index].replace(/\s+/gm,'');
		htmlText += "<li><form action = '' method = 'post' enctype='multipart/form-data'>" +
             "<input type='hidden' name='inputType' value='" + linksFunction + "'>" +
             "<input type='submit' value ='" + links[index] + "' class='blend'></form></li>"; 
    }
    document.getElementById("linkTextArea").innerHTML = htmlText;
}
function MostRecentMonthMaintenance(){}
function YearToDateMaintenance(){}
function CustomMaintenance(){}

function getCharts(){
  document.getElementById('d3ChartsID').innerHTML = "Select a Function or Tab Entry From the Menu";
}
function getComments(){
  document.getElementById('commentsID').innerHTML = "Comment area";
}
function getFooter(){
  document.getElementById('footer').innerHTML = "RJL1 LLC 2004-" + today.getFullYear();
}
/*REMOVE THIS SHOULD BE REAL FUNCTION IN RENT.js*/
function setCustomRange(msg){
  console.log(msg);
}
/*END REMOVE*/
/* Helper Functions */
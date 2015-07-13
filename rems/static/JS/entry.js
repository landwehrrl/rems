/*jslint browser:true, devel:true */ 
function setDownload(msg){
	var linkText = document.getElementById('linkTextArea');
	var form = createEntryForm();
	appendFormChild(form);
	while (linkText.firstChild) {
        linkText.removeChild(linkText.firstChild);
    }
    linkText.appendChild(form);
    createMonthYearCalendar('#entryDate');
    document.getElementById("d3ChartsID").innerHTML = "Upload File";
}
function createEntryForm(){
	var entryForm = document.createElement('FORM');
	entryForm.name = 'entryForm';
	entryForm.id = 'entryForm';
	entryForm.action = '';
	entryForm.onsubmit = 'return validateDate()';
	entryForm.method = 'post';
	entryForm.enctype = 'multipart/form-data';
	return entryForm;
}
function validateDate(){
	var myDate = document.forms.entryForm.entryDate.value;
	if(myDate == "Select Month"){
		alert('Select Month For This Entry');
		return 'false';
	}
}
function appendFormChild(form){
	var fieldSet = createEntryFieldSet();
	appendFieldSetChildren(fieldSet);
	form.appendChild(fieldSet);
}
function createEntryFieldSet(){
	var fieldSet = document.createElement('FIELDSET');
	fieldSet.id = 'entryFieldSet';
	return fieldSet;
}
function appendFieldSetChildren(fieldSet){
	appendLegend(fieldSet);
	appendInput('file','file','','','margin: 2px;',fieldSet);
    appendInput('hidden','inputType','','upload','',fieldSet);
    appendInput('text','entryDate','entryDate','Select Month','margin: 2px;',fieldSet);
    appendSelect(fieldSet,'docType',['Rent','Maintenance','Bills']); /* MAY REMOVE IF UNNECESSARY */
    appendInput('submit','','','Upload','margin: 2px',fieldSet);
}
function appendLegend(fieldSet){
	var legend = document.createElement('LEGEND');
	legend.innerHTML = 'Choose File For Upload';
	fieldSet.appendChild(legend);
}
function appendInput(mytype, myname, myid, myvalue, mystyle, myparent){
  var br = document.createElement('br');
  var temp = document.createElement('INPUT');
  temp.type = mytype;
  temp.name = myname;
  temp.id = myid;
  temp.value= myvalue;
  temp.style= mystyle;
  myparent.appendChild(temp);
  myparent.appendChild(br);
}
/* MAY REMOVE IF DETERMINED TO BE UNNECESSARY*/
function appendSelect(fieldSet, myName, options){
  var mySelect = document.createElement('SELECT');
  mySelect.name = myName;
  for(option in options){
    var temp = document.createElement('OPTION');
    temp.setAttribute("value",options[option]);
    var t = document.createTextNode(options[option]);
    temp.appendChild(t);
    mySelect.appendChild(temp);
  }
  fieldSet.appendChild(mySelect);
  var br = document.createElement('br');
  fieldSet.appendChild(br);
}
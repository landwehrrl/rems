function createMonthYearCalendar(target){
  $(function() {
    $( target ).datepicker({
      changeMonth: true,
      changeYear: true,
      dateFormat: 'M yy',
      showButtonPanel: true, 
      onClose: function(dateText, inst) { 
        var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
        var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
        $(this).datepicker('setDate', new Date(year, month, 1));
      }
    });
  });
}
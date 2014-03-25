$(document).ready(function(){
  $.ajax({
    url: '/items',
    type: 'GET',
    dataType: 'json'
  })
  .done(function(data) {
    Master.storeData(data);
  });

  // $('.add-existing').click(Master.renderMasterList);

});

var Master = Master || {
  items: []
};

Master.storeData = function(data) {
  Master.items = data;
};

Master.renderMasterList = function(event) {
  var masterHTML;
  masterHTML = Master.renderMasterHTML();
};

Master.addToList = function(event) {

};

$(document).ready(function(){
  $.ajax({
    url: '/items',
    type: 'GET',
    dataType: 'json'
  })
  .done(function(data) {
    Master.storeData(data);
    console.log("Done")
  });

  $('#add-existing').click(Master.renderMasterList);
  // $('.add-button').click(Master.addToList);

});

var Master = Master || {
  items: []
};

Master.storeData = function(data) {
  Master.items = data;
};

Master.renderMasterList = function(event) {
  event.preventDefault();
  var items = Master.items;
  Master.renderMasterHTML(items);
};

Master.renderMasterHTML = function(items) {
  var i = 0;
  for (; i < Master.items.length; i++) {
    Master.renderItemHTML(items[i]);
  }
};

Master.renderItemHTML = function(item) {
  var $itemDiv = '<div>' + item.item_name + '<button class="add-button">+ Add</button></div>';
  $('#existing-list').append($itemDiv);
  $('#new-list').hide("slow");
};

// Master.addToList = function(event) {
//   event.preventDefault();

//   $.ajax({
//     type: 'POST',
//     url: '/lists/' + list_id + '/items',
//     data: { list_id: list_id, user_id: user_id }
//   })
//   .done(function(data){
//     var itemHTML = '<li>' +  + '</li>';
//     $('#new-list').append(itemHTML);
//   });

//   return false;
// };

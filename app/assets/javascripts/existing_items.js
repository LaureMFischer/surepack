$(document).ready(function(){
  $.ajax({
    url: '/items',
    type: 'GET',
    dataType: 'json'
  })
  .done(function(data) {
    Master.storeData(data);
    console.log("Done");
  });

  $('#add-existing').click(Master.renderMasterList);

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
  var i = 0,
    $doneAddingButton = '<button id="done-adding-button">Done Adding</button>';

  for (; i < Master.items.length; i++) {
    Master.renderItemHTML(items[i]);
  }
  $('#done-adding').append($doneAddingButton);
  $('#done-adding-button').click(Master.hideMaster);
};

Master.renderItemHTML = function(item) {
  var $itemDiv = '<div>' + item.item_name + '<button class="add-button" id="add-button-' + item.id + '" data-item-name="' + item.item_name + '">+ Add</button></div>';
  $('#existing-list').append($itemDiv);
  $('#new-list').hide("slow");
  $('#add-button-' + item.id).click(Master.addToList.bind(item));
};

Master.addToList = function(event) {
  event.preventDefault();

  var list_id = $('#list-name').attr('data-list-id'),
    user_id = $('#list-name').attr('data-user-id'),
    item_id = this.id,
    item_name = this.item_name;

  $.ajax({
    type: 'PATCH',
    url: '/lists/' + list_id + '/items/' + item_id,
    data: { list_id: list_id, user_id: user_id, item_id: item_id, item_name: item_name },
    dataType: 'json'
  })
  .done(function(data){
    var itemHTML = '<li>' + data.item_name + '</li>';
    $('#list-of-items').append(itemHTML);
    $('#add-button-' + item_id).hide();
    console.log('Post Done');
  });

  return false;
};

Master.hideMaster = function(event) {
  var list_id = $('#list-name').attr('data-list-id');
  event.preventDefault();

  window.location.href = '/lists/' + list_id;
  // $('#new-list').show("slow");
};

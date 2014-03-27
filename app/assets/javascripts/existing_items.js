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

  var items = Master.items,
    list_id = $('#list-name').attr('data-list-id');

  $.ajax({
    url: '/lists/' + list_id,
    type: 'GET',
    dataType: 'json'
  })
  .done(function(data) {
    Master.storeCurrentListItems(data);
    console.log("Got current list items");
  });
});

var Master = Master || {
  items: [],
  itemNames: [],
  currentListItems: [],
  currentListItemNames: []
};

Master.storeData = function(data) {
  Master.items = data;
  var i = 0;
  for (; i < data.length; i++) {
    Master.itemNames.push(data[i].item_name);
  }
};

Master.storeCurrentListItems = function (data) {
  Master.currentListItems = data;

  var i = 0;
  for (; i < data.length; i++) {
    Master.currentListItemNames.push(data[i].item_name);
  }
};

Master.renderMasterList = function(event) {
  event.preventDefault();
  var items = Master.items;

  Master.renderMasterHTML(items);

  return false;
};

Master.renderMasterHTML = function(items) {
  var i = 0,
    $doneAddingButton = '<button id="done-adding-button" class="btn btn-primary btn-md">Done Adding</button>',
    list_id = $('#list-name').attr('data-list-id');

  for (; i < items.length; i++) {
    if(Master.currentListItemNames.indexOf(items[i].item_name) === -1) {
      Master.renderItemHTML(items[i]);
    }
  }
  $('#done-adding').append($doneAddingButton);
  $('#done-adding-button').click(Master.hideMaster);
};

Master.renderItemHTML = function(item) {
  var $itemDiv = '<tr class="existing-items"><td class="existing-item-name">' + item.item_name + '</td><td><button class="add-button btn btn-primary btn-xs" id="add-button-' + item.id + '" data-item-name="' + item.item_name + '">+ Add</button></td></tr>';
  $('#' + item.category).append($itemDiv);
  $('#new-list').hide("slow");
  $('#existing-list').show("slow");
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

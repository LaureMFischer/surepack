$(document).ready(function(){
  $.ajax({
    url: '/items', //Get all of a user's items
    type: 'GET',
    dataType: 'json'
  })
  .done(function(data) {
    Master.storeData(data); //Store the data that comes back in the Master.items array
    console.log("Done");
  });

  $('#add-existing').click(Master.renderMasterList); //Event listener for button that allows adding items from existing master list

  var items = Master.items,
    list_id = $('#list-name').attr('data-list-id');

  $.ajax({
    url: '/lists/' + list_id,
    type: 'GET',
    dataType: 'json'
  })
  .done(function(data) {
    Master.storeCurrentListItems(data); //Store the data that comes back in the Master.currentListItems array
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
  Master.items = data; //Store the data from the AJAX request in the Master.items array
  var i = 0;
  for (; i < data.length; i++) {
    Master.itemNames.push(data[i].item_name); //Add each of the item names to the Master.itemNames array
  }
};

Master.storeCurrentListItems = function (data) {
  Master.currentListItems = data; // Set Master.currentListItems array equal to the data that comes back from AJAX request above

  var i = 0;
  for (; i < data.length; i++) {
    Master.currentListItemNames.push(data[i].item_name); //Add each of the item names to the Master.currentListItemNames array
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
    if(Master.currentListItemNames.indexOf(items[i].item_name) === -1) { // If the item name is not already in Master.currentListItemNames array, indexOf will return -1
      Master.renderItemHTML(items[i]);
    }
  }
  $('#done-adding').append($doneAddingButton); // At the end of the master list, append a Done Adding button
  $('#done-adding-button').click(Master.hideMaster); // Event listener, hides master list items when Done Adding is clicked
};

Master.renderItemHTML = function(item) {
  var $itemDiv = '<tr class="existing-items"><td class="existing-item-name">' + item.item_name + '</td><td><button class="add-button btn btn-primary btn-xs" id="add-button-' + item.id + '" data-item-name="' + item.item_name + '">+ Add</button></td></tr>';
  $('#' + item.category).append($itemDiv); // Append the item to the appropriate category list (e.g. Clothing)
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
    $('#list-of-items').append(itemHTML); // itemHTML is appended to the current packing list after clicking the Add button
    $('#add-button-' + item_id).hide(); // Add button is hidden after clicking Add so that the same item can't be added twice
    console.log('Post Done');
  });

  return false;
};

Master.hideMaster = function(event) {
  var list_id = $('#list-name').attr('data-list-id');
  event.preventDefault();

  window.location.href = '/lists/' + list_id; // Takes user back to the list they are editing once they click Done Adding
};

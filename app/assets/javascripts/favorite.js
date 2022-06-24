$(document).on('turbolinks:load', function(){
  $('body').on('ajax:success', '.favorite', function(event){
    var response = event.detail[0];
    var testId = '.test' + '-' + response.id
    $(testId).text( response.text );
   })
}); 

$(document ).ready(function() {
  if($('#dropZone').length) {
    dropZone.ondragover = dropZone.ondragenter = function(evt) {
      evt.preventDefault();
    };
    dropZone.ondrop = function(evt) {
      fileInput.files = evt.dataTransfer.files;
      evt.preventDefault();
      console.log(fileInput.files);
    };
  }
  $('.close-btn').click(function(){
    let className = $(this).closest('.popup-sign-up').attr('class');
    if(className){
      let JElement = "." + className;
      $(JElement).css("display", "none");
    }
  })
});
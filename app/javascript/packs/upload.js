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
  $("#myBtn").click(function(){
    $("#upload-fail-modal").modal();
  });
  $("#upload-fail-modal").modal();
  function hidenModal(selectorElement, targetModal){
    $(selectorElement).click(function(){
      $(targetModal).modal('hide');
    })
    
  }
  hidenModal('.btn-close-modal', '#upload-fail-modal');
  hidenModal('.close-icon-modal', '#upload-fail-modal');
});
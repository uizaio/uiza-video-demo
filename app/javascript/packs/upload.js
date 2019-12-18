$(document ).ready(function() {
  dropZone.ondragover = dropZone.ondragenter = function(evt) {
    evt.preventDefault();
  };
  
  dropZone.ondrop = function(evt) {
    fileInput.files = evt.dataTransfer.files;
    evt.preventDefault();
    console.log(fileInput.files);
  };

});
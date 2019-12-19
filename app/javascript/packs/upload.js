$(document ).ready(function() {
  if($('#dropZone').length) {
    dropZone.ondragover = dropZone.ondragenter = function(evt) {
      evt.preventDefault();
    };
    dropZone.ondrop = function(evt) {
      fileInput.files = evt.dataTransfer.files;
      evt.preventDefault();
      upload_files_with_progress(fileInput.files[0]);

    };
  }
  $('.close-btn').click(function(){
    let className = $(this).closest('.popup-sign-up').attr('class');
    if(className){
      let JElement = "." + className;
      $(JElement).css("display", "none");
    }
  })
  function hidenModal(selectorElement, targetModal){
    $(selectorElement).click(function(){
      $(targetModal).modal('hide');
    })
    
  }
  hidenModal('.btn-close-modal', '#upload-fail-modal');
  hidenModal('.close-icon-modal', '#upload-fail-modal');

  $('#fileInput').on("change", function(){ 
    let file = $(this).prop('files');
    upload_files_with_progress(file[0]);
   });

  function upload_files_with_progress(fileData) {
    var formdata = new FormData();
    formdata.append("name", fileData.name);
    formdata.append("data", fileData);
    var ajax = new XMLHttpRequest();
    ajax.upload.addEventListener("progress", progressHandler);
    ajax.addEventListener("error", errorHandler);
    ajax.addEventListener("abort", abortHandler);
    ajax.open("POST", "api/v1/upload");
    ajax.onreadystatechange = function() {
      if (this.readyState == 4) {
        if(this.status == 200) {
          videoUploadSuccess(this.response);
        }else {
          videoUploadFail(this.response);
        }

      }     
    }; 
    ajax.send(formdata); 

  }
  function progressHandler(e) {
    $('#upload-video-block').css("display", "none");
    $('#edit-upload').css("display", "block");
    $('.upload-video-success .upload-video-fail').css("display", "none");
    $('.upload-video-progress').css("display", "block");
    let progressBarFill = document.querySelector("#progress-upload > .progress-bar-load");
    let progressBarText = document.querySelector("#value-progres");
    let percent  = e.lengthComputable ?  (e.loaded / e.total) * 100 : 0;
    progressBarFill.style.width = percent.toFixed(0) + "%";
    progressBarText.textContent = percent.toFixed(0) + "%";
  }
  function errorHandler(e) {
    console.log(e);
  }
  
  function abortHandler(e) {
    console.log(e)
  }
  function videoUploadSuccess (res) {
    let resObj = JSON.parse(res);
    $('#upload-video-block').css("display", "none");
    $('#edit-upload').css("display", "block");
    $('.upload-video-progress').css("display", "none")
    $('.upload-video-fail').css("display", "none");
    $('.upload-video-success').css("display", "block");
    let videoName = resObj.data.upload.name;
    console.log(videoName);
    let videoNameText = document.querySelector("#video-name");
    videoNameText.textContent = videoName;
  }
  function videoUploadFail(res) {
    $('#upload-video-block').css("display", "none");
    $('#edit-upload').css("display", "block");
    $('.upload-video-fail').css("display", "block");
    $('.upload-video-progress').css("display", "none")
    $('.upload-video-success').css("display", "none");
    $("#upload-fail-modal").modal();
  }
  
});
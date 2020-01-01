var publishStatusInterval = null;

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
      window.location.href = "/videos";
    })
    
  }
  hidenModal('.btn-close-modal', '#upload-fail-modal');
  hidenModal('.close-icon-modal', '#upload-fail-modal');

  $('#fileInput').on("change", function(){ 
    let file = $(this).prop('files');
    upload_files_with_progress(file[0]);
   });

  $('#re-upload-video').on("change", function(){ 
    let file = $(this).prop('files');
    upload_files_with_progress(file[0]);
    $('#upload-fail-modal').modal('hide');
   });

  function copyToClipboard(text) {
    var $temp = $("<input>");
    $("body").append($temp);
    $temp.val(text).select();
    document.execCommand("copy");
    $temp.remove();
  }

  $(".copi-link").click(function() {
    copyToClipboard($(this).val());
    console.log($(this).val());

    // $(this).text('Copied').css('background', 'green');
    // var interval = 2000;
    // setTimeout(function() {
    //   $(this).text('Copy link').css('background', '#DC3545');
    // }, interval);
  });

  $(".get-embed").click(function() {
    copyToClipboard($(this).val());
    console.log($(this).val());

    // $(this).text('Copied').css('background', 'green');
    // var interval = 2000;
    // setTimeout(function() {
    //   $(this).text('Get embbed').css('background', 'white');
    // }, interval);
  });

  function upload_files_with_progress(fileData) {
    var formdata = new FormData();
    formdata.append("name", fileData.name);
    formdata.append("data", fileData);
    var ajax = new XMLHttpRequest();
    ajax.upload.addEventListener("progress", progressHandler);
    ajax.addEventListener("error", errorHandler);
    ajax.addEventListener("abort", abortHandler);
    ajax.open("POST", "api/v1/videos");
    ajax.onreadystatechange = function() {
      if (this.readyState == 4) {
        if(this.status == 200) {
          videoPublishToCdnSuccess (this.response)
          // videoUploadSuccess(this.response);
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
    console.log(res);
    $('#upload-video-block').css("display", "none");
    $('#edit-upload').css("display", "block");
    $('.upload-video-progress').css("display", "none")
    $('.upload-video-fail').css("display", "none");
    $('.upload-video-success').css("display", "block");
    let videoName = res.data.entity.name;
    let thumbnail = res.data.entity.thumbnail;
    let videoUrl = window.location.origin + res.data.entity.view_url;
    let embbed_str = res.data.entity.embbed;

    let videoNameText = document.querySelector("#video-name");
    videoNameText.textContent = videoName;

    $('.thumbnail-top').css('background-image', 'url(' + thumbnail + ')');
    $('.thumbnail-top').css('cursor', 'pointer');
    $('.thumbnail-top').attr("onclick", 'window.location="' + videoUrl + '";');

    $('.copi-link').val(videoUrl);
    $('.get-embed').val(embbed_str);
  }

  function videoPublishToCdnSuccess (res) {
    let resObj = JSON.parse(res);
    $('.thumbnail-top').css('background-image', 'url(' + window.location.origin + '/img/image/img_video_placeholder.jpg)');
    $('.state-upload').css('display', 'block');
    publishStatusInterval = setInterval(function()
    {
      $.ajax({
        type: "get",
        url: "/api/v1/videos/" + resObj.data.video.uiza_id + "/publish_status",
        success:function(response)
        {
          console.log(response.data.publish.status);
          if (response.data.publish.status == 'success') {
            clearInterval(publishStatusInterval);
            $.ajax({
              type: "get",
              url: "/api/v1/videos/" + resObj.data.video.uiza_id + "/entity",
              success:function(response)
              {
                videoUploadSuccess(response);
              }
            });
          }
        }
      });
    }, 3000);
  }

  function videoUploadFail(res) {
    $('#upload-video-block').css("dsplay", "none");
    $('#edit-upload').css("display", "block");
    $('.upload-video-fail').css("display", "block");
    $('.upload-video-progress').css("display", "none")
    $('.upload-video-success').css("display", "none");
    $("#upload-fail-modal").modal();
  }
  function redirectPageView() {
    // let value = $('#upload-video-success-com').attr('value');
    // document.getElementById("upload-video-success-com").innerHTML = "zaauauuaua"
    // console.log(value);
    var s = document.getElementById('upload-video-success-com');
    if (s != null) {
      s.value = "new value";
    }
  }  
  redirectPageView();

  $('#terms-cond').click(function(){
    $("#terms-cond-modal").modal();
  })


});
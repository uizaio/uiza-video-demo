var liveGetInfoInterval = null;

$(document).ready(function() {
  function copyToClipboard(text) {
    var $temp = $("<input>");
    $("body").append($temp);
    $temp.val(text).select();
    document.execCommand("copy");
    $temp.remove();
  }

  $('#create-live-btn').click(function(){
    let liveName = $(".live-name").val();
    let liveDes = $(".live-des").val();
    if(liveName && liveDes){
      formData = new FormData();
      formData.append("name", liveName);
      formData.append("des", liveDes);
      // $('#process-modal-live').modal();
      // $('#process-modal-live').modal({backdrop: 'static', keyboard: false});
      $.ajax({
        url: '/api/v1/lives',
        data: formData,
        cache: false,
        contentType: false,
        processData: false,
        method: 'POST',
        success: function(response)
        {
          $('#process-modal-live').modal();
          let uiza_id = response.data.live.uiza_id;
          let code = response.data.live.code;
          $('.btn-start-stream').val(window.location.origin + '/lives/' + code + '/detail');
          getLiveInfo(uiza_id);
        },
        error: function (error)
        {
          console.log(error);
        }
      });
    }else {
      alert('Name and Description not empty');
    }
  });
  $('.close-icon-modal-live').click(function(){
    $('#process-modal-live').modal('hide');
  })
  function redirect_to_streaming_view(code){
    let location = window.location;

    let currentURL = location.origin;
    let urlStreaming = currentURL + "/lives/" + code + "/detail";
  }
  $('#copy-stream-url').click(function(){
    copyToClipboard($('.stream-url-input').val());
  });
  $('#copy-stream-key').click(function(){
    copyToClipboard($('.stream-key-input').val());
  });
  $(".get-link-btn").click(function() {
    let value = document.getElementById('get-link-btn').getAttribute('value');
    copyToClipboard(value);
  });
  $(".get-embed-btn").click(function() {
    let value = document.getElementById('get-embed-btn').getAttribute('value');
    copyToClipboard(value);
  });
  function liveGetInfoSuccess (res) {
    console.log(res);
    let streamKey = res.data.live.stream_key;
    $('.ingest_key').val(streamKey);
    let streamUrl = res.data.live.stream_url;
    $('.stream_url').val(streamUrl);
    $('.btn-start-stream').css("display", "block");
    $('.live-progress-text').text("Creating Resource ...100%");
    let progressBarFill = document.querySelector("#progress-live > .progress-bar-load");
    progressBarFill.style.width = "100%";
  }

  function getLiveInfo(uiza_id) {
    liveGetInfoInterval = setInterval(function()
    {
      $.ajax({
        type: "get",
        url: "/api/v1/lives/" + uiza_id + "/entity",
        success:function(response)
        {
          console.log(response.data.live.status);
          if (response.data.live.status == 'ready') {
            clearInterval(liveGetInfoInterval);
            liveGetInfoSuccess(response);
          }
        }
      });
    }, 2000);
  }

  $('#process-modal-live').on('hidden.bs.modal', function () {
    clearInterval(liveGetInfoInterval);
  });

  $('.btn-start-stream').click(function(){
    window.location = $(this).val();
  });
})
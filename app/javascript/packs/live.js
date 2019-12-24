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
      $('#process-modal-live').modal();
      // $('#process-modal-live').modal({backdrop: 'static', keyboard: false});
      // $.ajax({
      //   url: '/api/v1/lives',
      //   data: formData,
      //   cache: false,
      //   contentType: false,
      //   processData: false,
      //   method: 'POST',
      //   success: function(response)
      //   {
      //     // console.log(response.data.live.code);
      //     redirect_to_streaming_view(response.data.live.code);
      //   },
      //   error: function (error)
      //   {
      //     console.log(error);
      //   }
      // });
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
    // window.location.href = urlStreaming;
  }
  $('#copy-stream-url').click(function(){
    copyToClipboard($('.stream-url-input').val());
  });

})
$(document).ready(function() {

  $('#create-live-btn').click(function(){
    let liveName = $(".live-name").val();
    let liveDes = $(".live-des").val();
    if(liveName){
      formData = new FormData();
      formData.append("name", liveName);
      formData.append("des", liveDes);
      $.ajax({
        url: '/api/v1/lives',
        data: formData,
        cache: false,
        contentType: false,
        processData: false,
        method: 'POST',
        success: function(response)
        {
          // console.log(response.data.live.code);
          redirect_to_streaming_view(response.data.live.code);
        },
        error: function (error)
        {
          console.log(error);
        }
      });
    }else {
      alert('Không được để trống name');
    }
  });
  function redirect_to_streaming_view(code){
    let currentURL = window.location.href;
    let urlStreaming = currentURL + "/" + code;
    window.location.href = urlStreaming;
  }

})
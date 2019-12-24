var liveDetailInterval = null;

$(document).ready(function() {
  let uiza_id = '4a3f906b-3a0b-4a11-9280-715593140602';
  getLiveInfo(uiza_id);

  function liveGetInfoSuccess (res) {
    console.log(res);
    let streamUrl = res.data.live.stream_url;
    let streamKey = res.data.live.stream_key;
  }

  function getLiveInfo(uiza_id) {
    liveDetailInterval = setInterval(function()
    {
      $.ajax({
        type: "get",
        url: "/api/v1/lives/" + uiza_id + "/entity",
        success:function(response)
        {
          console.log(response.data.live.status);
          if (response.data.live.status == 'ready') {
            clearInterval(liveDetailInterval);
            liveGetInfoSuccess(response);
          }
        }
      });
    }, 2000);
  }
})
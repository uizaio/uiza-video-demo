var liveDetailInterval = null;

$(document).ready(function() {
  let uiza_id = $('#live_uiza_id').val();
  getLiveInfo(uiza_id);

  function updateLiveStatus(res) {
    let live_status = res.data.live.status;
    if (live_status == 'broadcasting') {
      $('.action-streaming').css("display", "flex");
      $('.action-offline').css("display", "none");
    }
    else {
      $('.action-streaming').css("display", "none");
      $('.action-offline').css("display", "flex");
    }
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
          updateLiveStatus(response);
        }
      });
    }, 2000);
  }
})
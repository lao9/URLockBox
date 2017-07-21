
function postLink() {
  var linkData = {
    link: {
      url: $("#link_url").val(),
      title: $("#link_title").val(),
      user_id: $("#link_user_id").val()
    }
  }

  $.ajax({
    url: "/api/v1/links",
    method: "POST",
    data: linkData
  })
  .done(function(newLinkMarkup) {
    $("#link_url").val("");
    $("#link_title").val("");
    if (newLinkMarkup) {
      $(".links").append(newLinkMarkup);
    }
  })
}

function bindSubmitListenerAndPostLink() {
  $("#new_link").submit(function(event) {
    event.preventDefault();
    postLink();
  })
}

$(document).ready(function(){
  bindSubmitListenerAndPostLink();
})


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
    $(':input[type="submit"]').prop('disabled', false);
    if (newLinkMarkup.link_html) {
      $(".links").append(newLinkMarkup.link_html);
      $(".container:nth-child(2)").prepend(flash_message(newLinkMarkup.message, "success"))
    } else {
      $(".container:nth-child(2)").prepend(flash_message(newLinkMarkup.message, "danger"))
    }
  })
}

function flash_message(message, type) {
  return `<div class='alert alert-${type}'>
            <button type='button' class='close' data-dismiss='alert'>x</button>
            ${message}
          </div>`
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

$( document ).ready(function(){
  $("body").on("click", ".mark-as-read", markAsRead)
})

function markAsRead(e) {
  e.preventDefault();

  var linkId = $(this).parents().prop('id').split("-")[1];
  var status = $(this).siblings(".read-status").text().split(":")[1]

  $.ajax({
    type: "PATCH",
    url: "/api/v1/links/" + linkId,
    data: { read: (status === " false") },
  }).then(updateLinkStatus)
    .fail(displayFailure);
}

function updateLinkStatus(link) {
  var new_status = link.read
  var $link = $(`#link-${link.id} .read-status`)
  $link.text(`Read?: ${new_status.toString()}`)
  if (new_status) {
    $link.parents(".link").addClass("read")
    $link.siblings(".mark-as-read").text("Mark as Unread")
  }
  else {
    $link.parents(".link").removeClass("read")
    $link.siblings(".mark-as-read").text("Mark as Read")
  }
}

function displayFailure(failureData){
  console.log("FAILED attempt to update Link: " + failureData.responseText);
}

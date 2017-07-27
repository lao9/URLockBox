$( document ).ready(function(){
  $(`#search-filter`).keyup(function() {
    var filter = $(this).children().val().toLowerCase()
    var linkElements = $(".link")

    linkElements.each(function(link){
      var title = $(this).children("h4").text().split(":")[1]
      title = title.slice(1, length.title).toLowerCase()
      var url = $(this).children("p.url").text().split(" ")[1].toLowerCase()

      if ((title.indexOf(filter) > -1) || (url.indexOf(filter) > -1)) {
        this.style.display = ""
      } else {
        this.style.display = "none"
      }
    })
  })
})

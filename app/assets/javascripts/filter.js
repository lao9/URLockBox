$( document ).ready(function(){
  filterByText()
  filterByRead()
  filterByUnread()
  clearFilters()
})

function clearFilters() {
  $(".clear-filters").on('click', function(){
    var linkElements = $(".link")

    linkElements.each(function(){
      this.style.display = ""
    })
  })
}

function filterByUnread() {
  $(".unread-filter").on('click', function(){
    var linkElements = $(".link")

    linkElements.each(function(){
      var status = $(this).children("p.read-status").text().split(" ")[1]

      if (status === "true") {
        this.style.display = "none"
      } else {
        this.style.display = ""
      }
    })
  })
}

function filterByRead() {
  $(".read-filter").on('click', function(){
    var linkElements = $(".link")

    linkElements.each(function(){
      var status = $(this).children("p.read-status").text().split(" ")[1]

      if (status === "true") {
        this.style.display = ""
      } else {
        this.style.display = "none"
      }
    })
  })
}

function filterByText() {
  $(`#search-filter`).keyup(function() {
    var filter = $(this).children().val().toLowerCase()
    var linkElements = $(".link")

    linkElements.each(function(){
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

}

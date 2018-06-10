$(document).ready(() => {

  id = 1;
  name = "Instituto de Matemática e Estatística";

  // Institutions
  $.get('/institutions', (data) => {
    drawer = $('#drawer');
    for (i = 0; i < data.institutions.length; i++) {
      let institute = data.institutions[i];
      var link = $('<a>',{
        text: institute.name,
        id: "institute"+institute.id,
        class: "mdl-navigation__link",
        href: "#",
        click: function(e) {
          id = institute.id;
          name = institute.name;
          $('#page-title').text(institute.name);
          $.get('/institutions/'+institute.id, (data) => {
            for (i = 0; i < drawer.children().length; i++) {
              drawer.children()[i].classList.remove("active");
            }
            tab = document.getElementById("institute"+institute.id);
            tab.classList.add("active");
            container = $('#salas-container');
            container.empty();
            for (i = 0; i < data.study_rooms.length; i++) {
              room = data.study_rooms[i];
              // Name
              var sala = $("<div>").addClass("sala card").appendTo(container);
              var sala_header = $("<div>").addClass("sala-header").appendTo(sala);
              var sala_header_p = $("<p>").text(room.name).appendTo(sala_header);
              // sala.click(function(){
              //   console.log(room.name);
              // });

              // Status
              var status = $("<div>").addClass("attribute").appendTo(sala);
              var status_row = $("<div>").addClass("row").appendTo(status);
              var status_col = $("<div>").addClass("col").appendTo(status_row);
              var status_p = $("<p>").appendTo(status_col);
              var status_span = $("<span>").text("Status: ").appendTo(status_p);
              if (room.is_free == true) {
                status_p.append("Livre");
              } else {
                status_p.append("Ocupada");
                sala_header.addClass("red")
              }

              // Capacity
              var capacity = $("<div>").addClass("attribute").appendTo(sala);
              var capacity_row = $("<div>").addClass("row").appendTo(capacity);
              var capacity_col = $("<div>").addClass("col").appendTo(capacity_row);
              var capacity_p = $("<p>").appendTo(capacity_col);
              var capacity_span = $("<span>").text("Capacidade: ").appendTo(capacity_p);
              capacity_p.append(room.fits_people);
            }
          })

        }
      }).appendTo(drawer);
    }
  })

  setInterval(function loop() {
    $('#page-title').text(name);
    $.get('/institutions/'+id, (data) => {
      tab = document.getElementById("institute"+id);
      tab.classList.add("active");
      container = $('#salas-container');
      container.empty();
      for (i = 0; i < data.study_rooms.length; i++) {
        room = data.study_rooms[i];
        // Name
        var sala = $("<div>").addClass("sala card").appendTo(container);
        var sala_header = $("<div>").addClass("sala-header").appendTo(sala);
        var sala_header_p = $("<p>").text(room.name).appendTo(sala_header);

        // Status
        var status = $("<div>").addClass("attribute").appendTo(sala);
        var status_row = $("<div>").addClass("row").appendTo(status);
        var status_col = $("<div>").addClass("col").appendTo(status_row);
        var status_p = $("<p>").appendTo(status_col);
        var status_span = $("<span>").text("Status: ").appendTo(status_p);
        if (room.is_free == true) {
          status_p.append("Livre");
        } else {
          status_p.append("Ocupada");
          sala_header.addClass("red")
        }

        // Capacity
        var capacity = $("<div>").addClass("attribute").appendTo(sala);
        var capacity_row = $("<div>").addClass("row").appendTo(capacity);
        var capacity_col = $("<div>").addClass("col").appendTo(capacity_row);
        var capacity_p = $("<p>").appendTo(capacity_col);
        var capacity_span = $("<span>").text("Capacidade: ").appendTo(capacity_p);
        capacity_p.append(room.fits_people);
      }
    })
    return loop;
  }(), 5000);

})

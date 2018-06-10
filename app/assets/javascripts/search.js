$(document).ready(() => {

  id = 1;
  name = "Instituto de Matemática e Estatística";

  // Institutions
  $.get('/institutions', (data) => {
    drawer = $('#drawer');
    for (i = 0; i < data.institutions.length; i++) {
      let institute = data.institutions[i];
      var link = $('<a>',{
        text: institute.tag,
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
              let room = data.study_rooms[i];
              // Name
              var sala = $("<div>").addClass("sala card").appendTo(container);
              var sala_header = $("<div>").addClass("sala-header").appendTo(sala);
              var sala_header_p = $("<p>").text(room.name).appendTo(sala_header);
              sala.click(function(){
                modal(room);
              });

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

              // Desde
              var change = $("<div>").addClass("attribute").appendTo(sala);
              var change_row = $("<div>").addClass("row").appendTo(change);
              var change_col = $("<div>").addClass("col").appendTo(change_row);
              var change_p = $("<p>").appendTo(change_col);
              var change_span = $("<span>").text("Desde: ").appendTo(change_p);
              change_p.append(parseDate(room.last_change));

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

  //  Loop
  setInterval(function loop() {
    $('#page-title').text(name);
    $.get('/institutions/'+id, (data) => {
      tab = document.getElementById("institute"+id);
      tab.classList.add("active");
      container = $('#salas-container');
      container.empty();
      for (i = 0; i < data.study_rooms.length; i++) {
        let room = data.study_rooms[i];
        // Name
        var sala = $("<div>").addClass("sala card").appendTo(container);
        var sala_header = $("<div>").addClass("sala-header").appendTo(sala);
        var sala_header_p = $("<p>").text(room.name).appendTo(sala_header);
        sala.click(function(){
          modal(room);
        });

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

        // Desde
        var change = $("<div>").addClass("attribute").appendTo(sala);
        var change_row = $("<div>").addClass("row").appendTo(change);
        var change_col = $("<div>").addClass("col").appendTo(change_row);
        var change_p = $("<p>").appendTo(change_col);
        var change_span = $("<span>").text("Desde: ").appendTo(change_p);
        change_p.append(parseDate(room.last_change));

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
  }(), 4000);

  function parseDate(datetime) {
    return datetime.substring(11, 16) + " (" +
           datetime.substring(8, 10) + "/" +
           datetime.substring(5, 7) + "/" +
           datetime.substring(0, 4) + ")";
  }

  function modal(room) {
    $('#modal-title').text(room.name);

    chart(room);

    $('#modal').modal('show')
  }

  function chart(room) {
    $.get('/peak-hours/'+room.id, (data) => {
      probs = data.probabilities;
      console.log(probs);
      for (i = 0; i < probs.length; i++) {
        probs[i] *= 100;
      }
      var prob_labels = ["00:00", "01:00", "02:00", "03:00", "04:00", "05:00",
                         "06:00", "07:00", "08:00", "09:00", "10:00", "11:00",
                         "12:00", "13:00", "14:00", "15:00", "16:00", "17:00",
                         "18:00", "19:00", "20:00", "21:00", "22:00", "23:00"];

      var ctxB = document.getElementById("barChart").getContext('2d');
      var myBarChart = new Chart(ctxB, {
        type: 'bar',
        data: {
          labels: prob_labels,
          datasets: [{
            label: 'Probabilidade de a sala estar livre (%)',
            data: probs,
            backgroundColor: '#673AB7',
            borderColor: '#512DA8',
            borderWidth: 1
          }]
        },
        options: {
          scales: {
            yAxes: [{
              ticks: {
                beginAtZero:true
              }
            }]
          }
        }
      });//
    })





  }

})

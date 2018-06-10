$(document).ready(() => {

  $.get('/institutions', (data) => {
    drawer = $('#drawer');

    for (i = 0; i < data.institutions.length; i++) {
      institute = data.institutions[i];


      var a = document.createElement('a');
      a.className = "mdl-navigation__link";
      a.appendChild(document.createTextNode(institute.name));
      a.href = "/"+institute.id;
      drawer.append(a);
    }

    console.log(drawer);


    $('#institutions').append('Data loaded: ' + JSON.stringify(data))
  })









})

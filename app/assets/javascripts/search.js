console.log('AAAAAAAAAAAAAAAAA')
$(document).ready(() => {
  $.get('/institutions', (data) => {
    $('#institutions').append('Data loaded: ' + JSON.stringify(data))
  })
})

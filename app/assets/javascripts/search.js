console.log('AAAAAAAAAAAAAAAAA')
$(document).ready(() => {
  $.get('localhost:3000/institutions', (data) => {
    $(body).append('Data loaded: ' + JSON.stringify(data))
  })
})

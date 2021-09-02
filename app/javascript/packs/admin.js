import '../stylesheets/admin'
import lozad from 'lozad'
console.log('Hello')
document.addEventListener('turbolinks:load', function(){
    lozad().observe()
})
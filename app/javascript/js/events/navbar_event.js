import { start } from "turbolinks";

function darken_screen(yesno){
    if( yesno == true ){
      document.querySelector('.screen-darken').classList.add('active');
    }
    else if(yesno == false){
      document.querySelector('.screen-darken').classList.remove('active');
    }
  }
      
  function close_offcanvas(){
    darken_screen(false);
    document.querySelector('.mobile-offcanvas.show').classList.remove('show');
    document.body.classList.remove('offcanvas-active');
  }
  
  function show_offcanvas(offcanvas_id){
    darken_screen(true);
    document.getElementById(offcanvas_id).classList.add('show');
    document.body.classList.add('offcanvas-active');
  }
  
  const NavbarTrigger = () =>{
    start()
    document.querySelectorAll('[data-trigger="navbar_main"]').forEach(function(everyelement){
        let offcanvas_id = everyelement.getAttribute('data-trigger');
        everyelement.addEventListener('click', function (e) {
          e.preventDefault();
              show_offcanvas(offcanvas_id);

        });

      });
    
      document.querySelectorAll('.btn-close').forEach(function(everybutton){
        everybutton.addEventListener('click', function (e) { 
              close_offcanvas();
          });
      });
    let element = document.querySelector('.screen-darken')
    if (element){
      element.addEventListener('click', function(event){
        close_offcanvas();
      });
    }
  }


  export default NavbarTrigger
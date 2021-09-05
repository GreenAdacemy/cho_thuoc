import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  connect() {}

  closescreen(event) {
    event.preventDefault();
    let screen = document.querySelector(".screen-darken_pay").classList;
    let classes = document.querySelector("section[name='pay']").classList;
    classes.remove("show");
    screen.remove("active");
    console.log("close screen pay");
  }
}

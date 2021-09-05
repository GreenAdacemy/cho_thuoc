import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static targets = ["pay"];
  connect() {
    super.connect();
  }
  openpay(event) {
    event.preventDefault();
    console.log("openpay");

    let screen = document.querySelector(".screen-darken_pay").classList;
    let id = this.payTarget.getAttribute("id");
    let classes = document.querySelector("section[name='pay']").classList;
    if (classes.contains("show")) {
      classes.remove("show");
      screen.remove("active");
    } else {
      classes.add("show");
      screen.add("active");
    }
  }
  closepay(event) {
    event.preventDefault();
    console.log("closepay");

    let screen = document.querySelector(".screen-darken_pay").classList;
    let id = this.payTarget.getAttribute("id");
    let classes = document.querySelector("section[name='pay']").classList;
    classes.remove("show");
    screen.remove("active");
  }
}

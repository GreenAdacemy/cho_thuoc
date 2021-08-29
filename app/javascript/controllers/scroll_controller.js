import { Controller } from "stimulus";
// import { type } from "jquery"

export default class extends Controller {
  static targets = ["scroll"];

  connect() {
    // write your code here
    this.init();
  }

  disconnect() {
    // write your code here
  }

  init() {
    let self = this;
    self.navbarWillFixed(window.scrollY);
    window.addEventListener("scroll", function () {
      self.navbarWillFixed(window.scrollY);
    });
  }
  navbarWillFixed(scrollY) {
    if(this.scrollTargets.length === 0) {
      return
    }

    let id = this.scrollTarget.getAttribute("id");
    let classes = document.querySelector(`#${id}`).classList;
    if (scrollY >= 120) {
      classes.add("fixed-navbar");
    } else {
      classes.remove("fixed-navbar");
    }

    if (scrollY >= 800) {
      document.getElementById("go-top").classList.remove("d-none");
    }

    if (scrollY == 0) {
      document.getElementById("go-top").classList.add("d-none");
    }
  }

  reconnect() {
    this.init();
  }
  initialize() {
    // write your code here
    document.addEventListener(
      "cable-ready:after-morph",
      this.reconnect.bind(this)
    );
  }
  gotoTop(event) {
    event.preventDefault();
    window.scrollTo({ top: 0, behavior: "smooth" });
  }
}

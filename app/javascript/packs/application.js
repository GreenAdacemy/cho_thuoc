import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "bootstrap";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

import "../stylesheets/application.scss";
const images = require.context("../images", true);

// document.addEventListener("DOMContentLoaded", function () {
//   NavbarTrigger();
//   // new Splide ( '#splide', {}).mount()
// });

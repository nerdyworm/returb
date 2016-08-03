import "./app/ujs";
import "./app/react";

import Turbolinks from 'turbolinks';
Turbolinks.start();

document.addEventListener('turbolinks:before-render', teardown);
document.addEventListener("turbolinks:load", load);

function teardown() {
  // destroy all the things
}

function load() {
  // Highlight current links
}


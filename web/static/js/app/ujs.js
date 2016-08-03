import fetch from 'isomorphic-fetch';
import { load, teardown } from './react.js';
import Turbolinks from 'turbolinks';

function didHandleSubmitLinkClick(element){
  while(element) {
    if(element.matches && element.matches('a[data-submit=parent]')){
      var message = element.getAttribute('data-confirm');
      if (message === null || confirm(message)) {
        // TODO - ensure is remote form
        remote(element.parentNode);
      }

      return true;
    } else {
      element = element.parentNode;
    }
  }
  return false;
}

// for links with HTTP methods other than GET
window.addEventListener('click', function (event) {
  if(event.target && didHandleSubmitLinkClick(event.target)) {
    event.preventDefault();
    return false;
  }
}, false);

function remote(form) {
  fetch(form.action + '?_format=js', {
    method: 'POST',
    credentials: 'same-origin',
    body: new FormData(form),
  }).then(function(response) {
    return response.text().then(function(js) {
      Turbolinks.clearCache();
      teardown();
      eval(js);
      highlightErrorMessages();
      load(); // setup components after errors
      return response;
    });
  });
}

document.addEventListener('submit', function(event) {
  if (event.target.className.indexOf('remote') !== -1) {
    event.preventDefault();
    remote(event.target);
  }
});

function highlightErrorMessages() {
  const elements = document.querySelectorAll('.error-message');
  for(let i = 0; i < elements.length; i++) {
    const link = elements[i];
    link.parentElement.className += ' has-error';
  }
}


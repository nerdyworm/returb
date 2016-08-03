import React from 'react';
import ReactDOM from 'react-dom';

import { createStore, applyMiddleware } from 'redux'
import { Provider }                     from 'react-redux'
import reducers                         from './reducers';

import createLogger     from  'redux-logger';
import thunkMiddleware  from  'redux-thunk';
import { fromJS }       from  'immutable';
import humps from 'humps';

const logger = createLogger({
  level: 'info',
  collapsed: true,
});

const middleware = applyMiddleware(
  thunkMiddleware,
  logger
);

const store = middleware(createStore)(reducers);

const CLASS_NAME = "turbo-react-component";
const STATE_CHANGE_CLASS_NAME = "turbo.react-state";

const components = {};

function findComponents() {
  const ctx = require.context('./components/', true, /\.js$/);
  ctx.keys().forEach(function(key) {
    // remove ./<name>.js
    let name = key.substring(2);
    name = name.substring(0, name.length - 3);

    components[name] = ctx(key).default;
  });
}

function getComponentByName(name) {
  return components[name];
}

export function load() {
  stateChanges();

  const elements = document.getElementsByClassName(CLASS_NAME);
  for (let i = 0; i < elements.length; i++) {
    mountElement(elements[i]);
  }
}

function stateChanges() {
  const elements = document.getElementsByClassName("turbo-react-state");
  for (let i = 0; i < elements.length; i++) {
   stateChange(elements[i]);
  }
}

function stateChange(element) {
  let props = element.getAttribute('data-states');
  if (props) {
    props = JSON.parse(props);
  }

  store.dispatch({
    type: 'STATE_CHANGE',
    data: normalize(props),
  });
}

function normalize(data) {
  return humps.camelizeKeys(data);
}

function mountElement(element) {
  const name = element.getAttribute('data-component');
  let props = element.getAttribute('data-props');
  if (props) {
    props = JSON.parse(props);
  }

  Object.keys(props).forEach(function(key) {
    props[key] = fromJS(props[key]);
  });

  const component = getComponentByName(name);
  ReactDOM.render(
    <Provider store={store}>
      {React.createElement(component, props)}
    </Provider>, element);
}

export function teardown() {
  const elements = document.getElementsByClassName(CLASS_NAME);
  for (let i = 0; i < elements.length; i++) {
    unmount(elements[i]);
  }
}

function unmount(el) {
  ReactDOM.unmountComponentAtNode(el);
}

document.addEventListener('turbolinks:before-render', teardown);
document.addEventListener("turbolinks:load", load);
findComponents();

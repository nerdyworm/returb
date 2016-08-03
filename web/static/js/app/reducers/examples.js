import { List, fromJS } from 'immutable';

const initialState = List([]);

export default function reducer(state = initialState, action = {}) {
  switch (action.type) {
    case 'STATE_CHANGE':
      return fromJS(action.data.examples);
    case 'ADD_EXAMPLE':
      return state.push(action.data);
  }

  return state;
}

import React       from 'react';
import { connect } from 'react-redux';

class Example extends React.Component {

  handleClick = (event) => {
    event.preventDefault();
    this.props.dispatch({
      type: 'ADD_EXAMPLE',
      data: Math.random(),
    });
  }

  render() {
    const { name } = this.props;
    return (<div onClick={this.handleClick}> Hello, {name}.  Click me to add to the example state.</div>);
  }
}

const mapStateToProps = (state) => ({

});

export default connect(mapStateToProps)(Example);



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
    return (
      <div>
        Hello, {name}.<br/>
        <button onClick={this.handleClick}>Add Example to redux state</button>
      </div>
    );
  }
}

const mapStateToProps = (state) => ({

});

export default connect(mapStateToProps)(Example);



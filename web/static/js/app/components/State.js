import React       from 'react';
import { connect } from 'react-redux';

class State extends React.Component {
  render() {
    const { examples } = this.props;
    const content = examples.join(", ");
    return (<div>{content}</div>);
  }
}

const mapStateToProps = (state) => ({
  examples: state.examples
});

export default connect(mapStateToProps)(State);



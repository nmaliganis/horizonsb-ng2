import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { signOut } from '../actions/auth'

class Signout extends Component {
  componentDidMount() {
    this.props.signOut()
    this.props.history.push("/home")
  }

  render() {
    return <div>
             Signing out...
            </div>
  }
}

Signout.propTypes = {
  signOut: PropTypes.func.isRequired,
}

export default connect(null, { signOut })(Signout)

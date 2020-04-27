import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { Redirect } from 'react-router-dom'
import Banner from '../components/Banner'
import Logo from '../components/Logo'
import LoginButton from '../components/LoginButton'
import { signIn, signInError } from '../actions/auth'
import Button from '../components/Button'
import Divider from "../components/Divider";
import Input from "../components/Input";

class Home extends Component {
  handleSuccessResponse = res => {
    const idToken = res.getAuthResponse().id_token
    this.props.signIn(idToken)
  };
  handleFailureResponse = res => {
    this.props.signInError(res.details || res.error)
  };

  redirectToTarget = () => {
    this.props.history.push(`/dashboard`)
  };
  handleSubmit (){
    return <Redirect to="/dashboard" push />
  };


  render() {
    const { authenticated, authError, authenticating } = this.props;

     // if (authenticated) {
     //   return <Redirect to="/dashboard" push />
     // }

    return (
      <Banner>
        <div>
          <Logo />
          <h1>
            Welcome to the<br />Horizon SB Admin Panel!
          </h1>
          <p>{authError}</p>
          {/*<LoginButton*/}
          {/*  clientId={process.env.GOOGLE_CLIENT_ID}*/}
          {/*  scope="profile email"*/}
          {/*  prompt="select_account"*/}
          {/*  fetchBasicProfile*/}
          {/*  onSuccess={this.handleSuccessResponse}*/}
          {/*  onFailure={this.handleFailureResponse}*/}
          {/*  disabled={authenticating}*/}
          {/*>*/}
          {/*  Login*/}
          {/*</LoginButton>*/}
          <form>
          <Divider />
          <Button disabled={false} onClick={this.redirectToTarget} label="Login"/>
          </form>
        </div>
      </Banner>
    )
  }
}

Home.defaultProps = {
  authError: null,
  authenticating: false,
};

Home.propTypes = {
  authenticated: PropTypes.bool.isRequired,
  authenticating: PropTypes.bool,
  authError: PropTypes.string,
  signIn: PropTypes.func.isRequired,
  signInError: PropTypes.func.isRequired,
};

export default connect(state => state.auth, { signIn, signInError })(Home)

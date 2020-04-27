import React, {
  Component,
  Fragment,
} from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { FAVORITES_MENU_ITEMS } from '../constants'
import { updateFavoriteFormSelector } from '../selectors/updateFavoriteForm'
import {
  updateFavorite,
  loadFavorite,
  clearLoadedFavorite,
} from '../actions/favoriteevents'
import Nav from '../components/Nav/index'
import EventsMenu from '../components/Menu/index'
import ErrorMessage from '../containers/ErrorMessage/index'
import Container from '../components/Container'
import Column from '../components/Column'
import Content from '../components/Content'
import UpdateFavoriteForm from '../forms/Favorite'

const getMenuItems =
  id => [
    ...FAVORITES_MENU_ITEMS,
    {
      label: 'Update Favorite',
      to: `/favorites/update/${id}`,
    },
  ]

class FavoritesUpdate extends Component {
  constructor(props) {
    super(props)
  }

  componentDidMount() {
    this.props.dispatchLoadFavorite(this.props.match.params.id)
  }

  componentWillUnmount() {
    this.props.dispatchClearLoadedFavorite()
  }

  render() {
    const { dispatchUpdateFavorite, isUpdating, entry, match } = this.props

    return (
      <Fragment>
        <Nav />
        <EventsMenu menuItems={getMenuItems(match.params.id)} />
        <ErrorMessage />
        <Container isColumn>
          {entry && (
            <Column width={100}>
              <h2>Update Favorite</h2>
              <Content isColumn>
                <UpdateFavoriteForm
                  initial={entry}
                  isLoading={isUpdating}
                  submit={dispatchUpdateFavorite}
                />
              </Content>
            </Column>
          )}
        </Container>
      </Fragment>
    )
  }
}

FavoritesUpdate.defaultProps = {
  entry: null,
}

FavoritesUpdate.propTypes = {
  dispatchClearLoadedFavorite: PropTypes.func.isRequired,
  dispatchLoadFavorite: PropTypes.func.isRequired,
  dispatchUpdateFavorite: PropTypes.func.isRequired,
  entry: PropTypes.shape({
    id: PropTypes.string,
    name: PropTypes.string,
    eventId: PropTypes.string,
    favorite: PropTypes.bool,
  }),
  isUpdating: PropTypes.bool.isRequired,
  match: PropTypes.shape({
    params: PropTypes.shape({
      id: PropTypes.string,
    }),
  }).isRequired,
}

export default connect(
  state => updateFavoriteFormSelector(state), {
    dispatchUpdateFavorite: updateFavorite,
    dispatchLoadFavorite: loadFavorite,
    dispatchClearLoadedFavorite: clearLoadedFavorite,
  })(FavoritesUpdate)

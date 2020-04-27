import React, { Fragment } from 'react'
import PropTypes from 'prop-types'
import { Formik , Field} from 'formik'
import { validationSchema, onSubmit, initialValues } from './config'
import Input from '../../components/Input'
import Divider from '../../components/Divider'
import Button from '../../components/Button'

import { Checkbox, CheckboxLabel } from '../styled'

import {
  handleToggleCheckbox,
} from './handler'

const UpdateFavoriteForm = ({ isLoading, initial, ...rest }) => (
  <Formik
    initialValues={initialValues(initial)}
    validationSchema={validationSchema}
    onSubmit={onSubmit(rest)}
    render={({
               values,
               touched,
               errors,
               handleChange,
               handleBlur,
               handleSubmit,
               isSubmitting,
               setFieldValue,
             }) => (
      <form onSubmit={handleSubmit}>
        <Input
          name="id"
          id="id"
          value={values.id}
          error={touched.id && errors.id}
          onChange={handleChange}
          onBlur={handleBlur}
          type="hidden"
        />
        <Input
          placeholder="Event Name"
          label="Name"
          name="name"
          id="name"
          disabled={true}
          value={values.name}
          error={touched.name && errors.name}
          onChange={handleChange}
          onBlur={handleBlur}
        />
        <Input
          placeholder="Event ID"
          label="Event ID"
          name="eventId"
          id="eventId"
          disabled={true}
          value={values.eventId}
          error={touched.eventId && errors.eventId}
          onChange={handleChange}
          onBlur={handleBlur}
          type="text"
        />
        <Fragment>
          <div>
            <Checkbox checked={values.favorite} onChange={handleToggleCheckbox(setFieldValue, values)} id="favoriteBox" type="checkbox" />
            <CheckboxLabel htmlFor="favoriteBox">Is Favorite?</CheckboxLabel>
          </div>
        </Fragment>
        <Divider />
        <Button disabled={isSubmitting || isLoading} label="Save" />
      </form>
    )}
  />
)

UpdateFavoriteForm.defaultProps = {
  isLoading: false,
  initial: {},
}

UpdateFavoriteForm.propTypes = {
  initial: PropTypes.shape({
    id: PropTypes.string,
    name: PropTypes.string,
    eventId: PropTypes.string,
    priority: PropTypes.number,
    favorite: PropTypes.bool,
  }),
  isLoading: PropTypes.bool,
}

export default UpdateFavoriteForm

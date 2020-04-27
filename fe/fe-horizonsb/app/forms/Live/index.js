import React from 'react'
import PropTypes from 'prop-types'
import { Formik } from 'formik'
import Input from '../../components/Input'
import Divider from '../../components/Divider'
import Button from '../../components/Button'
import { validationSchema, onSubmit, initialValues } from './config'

const UpdateLiveForm = ({ isLoading, initial, ...rest }) => (
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
        <Input
          placeholder="10"
          label="Live Priority"
          name="livePriority"
          id="livePriority"
          disabled={false}
          value={values.livePriority}
          error={touched.livePriority && errors.livePriority}
          onChange={handleChange}
          onBlur={handleBlur}
          type="numeric"
        />
        <Divider />
        <Button disabled={isSubmitting || isLoading} label="Save" />
      </form>
    )}
  />
)

UpdateLiveForm.defaultProps = {
  isLoading: false,
  initial: {},
}

UpdateLiveForm.propTypes = {
  initial: PropTypes.shape({
    id: PropTypes.string,
    name: PropTypes.string,
    eventId: PropTypes.string,
    livePriority: PropTypes.number,
  }),
  isLoading: PropTypes.bool,
}

export default UpdateLiveForm

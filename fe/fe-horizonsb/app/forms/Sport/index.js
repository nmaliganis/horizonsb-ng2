import React from 'react'
import PropTypes from 'prop-types'
import { Formik } from 'formik'
import { validationSchema, onSubmit, initialValues } from './config'
import Input from '../../components/Input'
import Divider from '../../components/Divider'
import Button from '../../components/Button'

const UpdateSportForm = ({ isLoading, initial, ...rest }) => (
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
          placeholder="Sport Name"
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
          placeholder="Sport ID"
          label="Sport ID"
          name="sportId"
          id="sportId"
          disabled={true}
          value={values.sportId}
          error={touched.sportId && errors.sportId}
          onChange={handleChange}
          onBlur={handleBlur}
          type="text"
        />
        <Input
          placeholder="10"
          label="Priority"
          name="priority"
          id="priority"
          disabled={false}
          value={values.priority}
          error={touched.priority && errors.priority}
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

UpdateSportForm.defaultProps = {
  isLoading: false,
  initial: {},
}

UpdateSportForm.propTypes = {
  initial: PropTypes.shape({
    id: PropTypes.string,
    name: PropTypes.string,
    sportId: PropTypes.string,
    priority: PropTypes.number,
  }),
  isLoading: PropTypes.bool,
}

export default UpdateSportForm

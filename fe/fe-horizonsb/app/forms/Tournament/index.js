import React from 'react'
import PropTypes from 'prop-types'
import { Formik } from 'formik'
import { validationSchema, onSubmit, initialValues } from './config'
import Input from '../../components/Input'
import Divider from '../../components/Divider'
import Button from '../../components/Button'

const UpdateTournamentForm = ({ isLoading, initial, ...rest }) => (
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
          placeholder="Tournament Name"
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
          placeholder="Tournament ID"
          label="Tournament ID"
          name="tournamentId"
          id="tournamentId"
          disabled={true}
          value={values.tournamentId}
          error={touched.tournamentId && errors.tournamentId}
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

UpdateTournamentForm.defaultProps = {
  isLoading: false,
  initial: {},
}

UpdateTournamentForm.propTypes = {
  initial: PropTypes.shape({
    id: PropTypes.string,
    name: PropTypes.string,
    tournamentId: PropTypes.string,
    priority: PropTypes.number,
  }),
  isLoading: PropTypes.bool,
}

export default UpdateTournamentForm

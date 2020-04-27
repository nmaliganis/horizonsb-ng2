import * as Yup from 'yup'

export const validationSchema = Yup.object().shape({
  name: Yup.string()
    .required('Tournament must have a name'),
  tournamentId: Yup.string()
    .required('Tournament ID must have a value'),
  priority: Yup.number()
    .min(1)
    .max(100)
    .positive()
    .integer()
    .required(),
})

export const onSubmit = props => async (values, { setSubmitting }) => {
  setSubmitting(true)
  await props.submit(values)
  setSubmitting(false)
}

export const initialValues = initial => ({
  id: initial.id || '',
  name: initial.name || '',
  tournamentId: initial.tournamentId || '',
  priority: initial.priority || '',
})

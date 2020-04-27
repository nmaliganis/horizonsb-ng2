import * as Yup from 'yup'

export const validationSchema = Yup.object().shape({
  name: Yup.string()
    .required('Sport must have a name'),
  sportId: Yup.string()
    .required('Sport ID must have a value'),
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
  sportId: initial.sportId || '',
  priority: initial.priority || '',
})

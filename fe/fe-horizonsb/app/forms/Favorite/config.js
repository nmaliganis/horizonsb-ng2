import * as Yup from 'yup'

export const validationSchema = Yup.object().shape({
  name: Yup.string()
    .required('Event must have a name'),
  eventId: Yup.string()
    .required('Event ID must have a value'),
})

export const onSubmit = props => async (values, { setSubmitting }) => {
  setSubmitting(true)
  await props.submit(values)
  setSubmitting(false)
}

export const initialValues = initial => ({
  id: initial.id || '',
  name: initial.name || '',
  eventId: initial.eventId || '',
  favorite: initial.favorite,
})

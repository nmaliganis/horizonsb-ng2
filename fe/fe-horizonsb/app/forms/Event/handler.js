export const handleToggleCheckbox = (setFieldValue, values) => () => {
  const updatedFavorite = !values.favorite
  setFieldValue('favorite', updatedFavorite ? true : false)
}

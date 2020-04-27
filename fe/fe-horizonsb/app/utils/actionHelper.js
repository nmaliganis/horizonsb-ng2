export const createActionSet = actionName => ({
  PENDING: `${actionName}/PENDING`,
  SUCCESS: `${actionName}/SUCCESS`,
  ERROR: `${actionName}/ERROR`,
})

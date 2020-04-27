import sanitizeHtml from 'sanitize-html'

const sanitize = dirty => sanitizeHtml(dirty, {
  allowedTags: [ 'strong', 'em', 'u', 'a', 'br', 'p' ],
  allowedAttributes: {
    'a': [ 'href' ]
  },
});

export const stripAll = dirty => sanitizeHtml(dirty, {
  allowedTags: [],
  allowedAttributes: {},
});


export default sanitize

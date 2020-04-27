import React from 'react'

const Search = props => (
  <svg viewBox="0 0 17 17" width="1em" height="1em" {...props}>
    <g transform="translate(-1 -2)" fill="none" fillRule="evenodd">
      <path d="M0 0h20v20H0z" />
      <circle stroke="#2D2D2D" strokeWidth={2} cx={11} cy={9} r={6} />
      <rect
        fill="#2D2D2D"
        transform="rotate(45 4.354 15.646)"
        x={3.354}
        y={12.146}
        width={2}
        height={7}
        rx={1}
      />
    </g>
  </svg>
)

export default Search

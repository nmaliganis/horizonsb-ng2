import React, { Component } from 'react'
import PropTypes from 'prop-types'

class ReactFileReader extends Component {
  constructor(props) {
    super(props)
    this.state = {
      uploading: false,
    }
  }

  clickInput = () => {
    const element = document.getElementById(this.props.elementId)
    element.value = ''
    element.click()
  }

  handleFiles = event => {
    this.setState({ uploading: Boolean(true) })
    if (this.props.base64) {
      this.convertFilesToBase64(event.target.files)
    } else {
      this.props.handleFiles(event.target.files)
    }
  }

  convertFilesToBase64 = listOffiles => {
    const fileList = listOffiles
    if (this.props.multipleFiles) {
      const files = { base64: [], fileList }

      for (let i = 0, len = fileList.length; i < len; i++) {
        const reader = new FileReader()
        const fistItem = fileList[i]

        reader.onloadend = () => {
          files.base64.push(reader.result)

          if (files.base64.length === fileList.length) {
            this.setState({ uploading: Boolean(false) })
            this.props.handleFiles(files)
          }
        }

        reader.readAsDataURL(fistItem)
      }
    } else {
      const newFiles = { base64: '', fileList }
      const firstFile = fileList[0]
      const reader = new FileReader()

      reader.onloadend = () => {
        newFiles.base64 = reader.result
        this.setState({ uploading: Boolean(false) })
        this.props.handleFiles(newFiles)
      }

      reader.readAsDataURL(firstFile)
    }
  }

  render() {
    const hideInput = {
      width: '0px',
      opacity: '0',
      position: 'fixed',
    }

    return (
      <div className={this.props.className}>
        <input
          type="file"
          onChange={this.handleFiles}
          accept={
            Array.isArray(this.props.fileTypes)
              ? this.props.fileTypes.join(',')
              : this.props.fileTypes
          }
          id={this.props.elementId}
          multiple={this.props.multipleFiles}
          style={hideInput}
          disabled={this.props.disabled}
        />
        {/* eslint-disable-next-line */}
        <div onClick={this.clickInput}>{this.props.children}</div>
        {this.state.uploading && 'Uploading...'}
      </div>
    )
  }
}

ReactFileReader.defaultProps = {
  fileTypes: 'image/*',
  multipleFiles: false,
  base64: false,
  disabled: false,
  className: null,
}

ReactFileReader.propTypes = {
  base64: PropTypes.bool,
  children: PropTypes.element.isRequired,
  className: PropTypes.string,
  disabled: PropTypes.bool,
  elementId: PropTypes.string.isRequired,
  fileTypes: PropTypes.oneOfType([PropTypes.string, PropTypes.array]),
  handleFiles: PropTypes.func.isRequired,
  multipleFiles: PropTypes.bool,
}

export default ReactFileReader

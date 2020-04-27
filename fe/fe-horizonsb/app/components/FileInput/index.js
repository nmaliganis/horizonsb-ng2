import React, { Fragment, PureComponent } from 'react'
import PropTypes from 'prop-types'
import { Label, Error } from '../Form/styled'
import apiService from '../../services/apiService'
import { Button, Image } from './styled'

class FileInput extends PureComponent {
  constructor(props) {
    super(props)
    this.fileRef = React.createRef()
    this.state = {
      isUploading: false,
      error: '',
    }
  }

  handleUpload = async event => {
    const { files } = event.currentTarget

    if (!files || !files.length) {
      return
    }

    if (files[0].type !== 'image/jpeg' && files[0].type !== 'image/png') {
      this.setState({
        error: 'Image format not supported. Please select a JPEG or PNG image.'
      })
      return
    }
    
    this.setState({ isUploading: true, error: '' })
    const imageUrl = await apiService.uploadImage(files[0])
    this.props.onChange(this.props.name, imageUrl)
    this.setState({ isUploading: false })
  }

  handleUploadClick = () => {
    this.fileRef.current.click()
  }

  render() {
    return (
      <Fragment>
        <Label>{this.props.label}</Label>
        <input type="file" style={ { display: 'none' } } onChange={this.handleUpload} ref={this.fileRef} />
        {this.props.value && <Image src={this.props.value} alt={this.props.value} />}
        <Button
          type="button"
          onClick={this.handleUploadClick}
          disabled={this.state.isUploading}
          label={this.state.isUploading ? 'Uploading...' : 'Choose a file'}
        />
        {Boolean(this.state.error) && (
          <Fragment>
            <br />
            <Error>{this.state.error}</Error>
          </Fragment>
        )}
      </Fragment>
    )
  }
}

FileInput.propTypes = {
  label: PropTypes.string.isRequired,
  name: PropTypes.string.isRequired,
  onChange: PropTypes.func.isRequired,
  value: PropTypes.string,
}

FileInput.defaultProps = {
  value: undefined,
}

export default FileInput

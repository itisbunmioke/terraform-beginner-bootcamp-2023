variable "user_uuid" {
  description = "User UUID"
    type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "user_uuid must be in the format of a UUID (e.g., 123e4567-e89b-12d3-a456-426655440000)"
  }
}

variable "bucket_name" {
  description = "Name for the AWS S3 bucket"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9.-]{3,63}$", var.bucket_name))
    error_message = "Bucket name must be 3-63 characters long and can only contain letters, numbers, hyphens, and periods."
  }
}

variable "index_html_filepath" {
  type        = string

  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "The specified index_html_filepath is not a valid file path."
  }
}

variable "error_html_filepath" {
  type        = string

  validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The specified error_html_filepath is not a valid file path."
  }
}

variable "content_version" {
  description = "The content version number (positive integer starting at 1)"
  type        = number
  validation {
    condition     = can(regex("^[1-9][0-9]*$", var.content_version))
    error_message = "Content version must be a positive integer starting at 1."
  }
  default = 1 # You can change the default value if needed
}

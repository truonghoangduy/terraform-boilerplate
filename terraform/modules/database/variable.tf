variable "database_name" {
  type = string
  #   default name into "course_app" for release database
  default = "course_app"
}


variable "name" {
  type        = map(string)
  description = "(optional) describe your variable"
  default = {
    getUser  = "getUser"
    getHello = "getHello"
  }
}

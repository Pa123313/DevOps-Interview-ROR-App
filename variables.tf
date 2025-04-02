# Define the CIDR block for the VPC
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

# Define the CIDR block for the public subnet
variable "subnet_cidr_public" {
  description = "The CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

# Define the CIDR block for the private subnet
variable "subnet_cidr_private" {
  description = "The CIDR block for the private subnet"
  default     = "10.0.2.0/24"
}

# Define the EC2 instance type for ECS
variable "ecs_instance_type" {
  description = "The EC2 instance type for ECS"
  default     = "t2.micro"
}

# Define the RDS username
variable "rds_username" {
  description = "The database username"
  default     = "admin"
}

# Define the RDS password
variable "rds_password" {
  description = "The database password"
  default     = "password"
}

# Define the RDS database name
variable "rds_db_name" {
  description = "The name of the database"
  default     = "railsdb"
}

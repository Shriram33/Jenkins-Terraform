terraform {
    backend "s3" {
        bucket = "terraform-state-s2"
        key    = "State-locker/s2.tf"
        region = "ap-south-1"
        dynamodb_table = "State_Locker"
    }   
}

aws_region       = "us-east-1"
ami_id           = "ami-005fc0f236362e99f" # Replace with a valid AMI ID
instance_type    = "t3.medium"
key_pair_name    = "hello"
private_key_path = "../../hello.pem" # relative path to terraform folder

domain_name     = "drintech.online"
frontend_domain = "cv1.poku1.online"
db_domain       = "db.cv1.poku.online"
site_domain  = "poku.cv1.drintech.online"
cert_email      = "poku@example.com" # replace with a valid email


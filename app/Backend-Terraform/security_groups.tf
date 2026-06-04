resource "aws_security_group" "backend_sg" {
  name        = "backend_sg"
  description = "Security group for backend EC2"

  # SSH (22) -> My IP
  # הערה: אם את רוצה להגביל ל-IP ספציפי, החליפי את ה-0.0.0.0/0 ב-IP שלך
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # Custom TCP (3000) -> Anywhere
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # יציאה מוגדרת כברירת מחדל
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
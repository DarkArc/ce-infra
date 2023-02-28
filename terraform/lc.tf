locals {
  image_id          = "ami-0969cc9e8421c61e1"
  staging_image_id  = "ami-0969cc9e8421c61e1"
  beta_image_id     = "ami-0969cc9e8421c61e1"
  gpu_image_id      = "ami-086f4909d3a027294"
  wintest_image_id  = "ami-0955bd1b3484c824f"
  staging_user_data = base64encode("staging")
  beta_user_data    = base64encode("beta")
  gpu_user_data     = base64encode("gpu")
  wintest_user_data = base64encode("wintest")
}

resource "aws_launch_template" "CompilerExplorer-beta" {
  name          = "ce-beta"
  description   = "Beta launch template"
  ebs_optimized = true
  iam_instance_profile {
    arn = aws_iam_instance_profile.CompilerExplorerRole.arn
  }
  image_id               = local.beta_image_id
  user_data              = local.beta_user_data
  key_name               = "mattgodbolt"
  vpc_security_group_ids = [aws_security_group.CompilerExplorer.id]
  instance_type          = "c6i.large"

  tag_specifications {
    resource_type = "volume"

    tags = {
      Site        = "CompilerExplorer"
      Environment = "Beta"
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Site        = "CompilerExplorer"
      Environment = "Beta"
      Name        = "Beta"
    }
  }
}

resource "aws_launch_template" "CompilerExplorer-staging" {
  name          = "ce-staging"
  description   = "Staging launch template"
  ebs_optimized = true
  iam_instance_profile {
    arn = aws_iam_instance_profile.CompilerExplorerRole.arn
  }
  image_id               = local.staging_image_id
  user_data              = local.staging_user_data
  key_name               = "mattgodbolt"
  vpc_security_group_ids = [aws_security_group.CompilerExplorer.id]
  instance_type          = "c6i.large"

  tag_specifications {
    resource_type = "volume"

    tags = {
      Site        = "CompilerExplorer"
      Environment = "Staging"
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Site        = "CompilerExplorer"
      Environment = "Staging"
      Name        = "Staging"
    }
  }
}

resource "aws_launch_template" "CompilerExplorer-prod-gpu" {
  name          = "ce-prod-gpu"
  description   = "Prod GPU launch template"
  ebs_optimized = true
  iam_instance_profile {
    arn = aws_iam_instance_profile.CompilerExplorerRole.arn
  }
  image_id               = local.gpu_image_id
  user_data              = local.gpu_user_data
  key_name               = "mattgodbolt"
  vpc_security_group_ids = [aws_security_group.CompilerExplorer.id]
  instance_type          = "g4dn.xlarge"

  tag_specifications {
    resource_type = "volume"

    tags = {
      Site        = "CompilerExplorer"
      Environment = "GPU"
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Site        = "CompilerExplorer"
      Environment = "GPU"
      Name        = "GPU"
    }
  }
}

resource "aws_launch_template" "CompilerExplorer-prod" {
  name          = "ce-prod"
  description   = "Production launch template"
  ebs_optimized = true
  iam_instance_profile {
    arn = aws_iam_instance_profile.CompilerExplorerRole.arn
  }
  image_id               = local.image_id
  key_name               = "mattgodbolt"
  vpc_security_group_ids = [aws_security_group.CompilerExplorer.id]
  instance_type          = "c6i.large" // This is overridden in the ASG

  tag_specifications {
    resource_type = "volume"

    tags = {
      Site = "CompilerExplorer"
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Site        = "CompilerExplorer"
      Environment = "Prod"
      Name        = "Prod"
    }
  }
}

resource "aws_launch_template" "CompilerExplorer-wintest" {
  name          = "ce-wintest"
  description   = "WinTest launch template"
  ebs_optimized = true
  iam_instance_profile {
    arn = aws_iam_instance_profile.CompilerExplorerWindowsRole.arn
  }
  image_id               = local.wintest_image_id
  key_name               = "mattgodbolt"
  vpc_security_group_ids = [aws_security_group.CompilerExplorer.id]
  instance_type          = "c5ad.large"
  user_data              = local.wintest_user_data

  tag_specifications {
    resource_type = "volume"

    tags = {
      Site = "CompilerExplorer"
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Site        = "CompilerExplorer"
      Environment = "Wintest"
      Name        = "Wintest"
    }
  }
}

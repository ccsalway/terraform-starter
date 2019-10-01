resource "aws_vpc" "main" {
  cidr_block           = var.config.master.vpc.cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "main"
  }
}

######################
# Subnets
######################

resource "aws_subnet" "main_private" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.config.master.vpc.cidr_block, var.config.master.vpc.cidr_newbits, count.index)

  tags = {
    Name = "main.prv"
  }
}

resource "aws_subnet" "main_public" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.config.master.vpc.cidr_block, var.config.master.vpc.cidr_newbits, count.index + length(data.aws_availability_zones.available.names))
  map_public_ip_on_launch = true

  tags = {
    Name = "main.pub"
  }
}

######################
# IGW
######################

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main"
  }
}

######################
# NAT
######################

resource "aws_eip" "main_nat" {
  count = length(data.aws_availability_zones.available.names)
  tags = {
    Name = "main"
  }
}

resource "aws_nat_gateway" "main" {
  count         = length(data.aws_availability_zones.available.names)
  allocation_id = aws_eip.main_nat[count.index].id
  subnet_id     = aws_subnet.main_public[count.index].id
  tags = {
    Name = "main"
  }
}

######################
# Routes
######################

# public
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main.pub"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(data.aws_availability_zones.available.names)
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.main_public[count.index].id
}

resource "aws_route" "main_gw" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.main.id
  destination_cidr_block = "0.0.0.0/0"
}

# private
resource "aws_route_table" "private" {
  count  = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main.prv"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(data.aws_availability_zones.available.names)
  route_table_id = aws_route_table.private[count.index].id
  subnet_id      = aws_subnet.main_private[count.index].id
}

resource "aws_route" "private_nat" {
  count                  = length(data.aws_availability_zones.available.names)
  route_table_id         = aws_route_table.private[count.index].id
  nat_gateway_id         = aws_nat_gateway.main[count.index].id
  destination_cidr_block = "0.0.0.0/0"
}

######################
# NACL
######################

resource "aws_default_network_acl" "default" {
  # best practice not to use and empty rules which TF does on import
  default_network_acl_id = aws_vpc.main.default_network_acl_id
  tags = {
    name = "default"
  }
}

resource "aws_network_acl" "main_public" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.main_public.*.id
  tags = {
    name = "main.pub"
  }
}

resource "aws_network_acl" "main_private" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.main_private.*.id
  tags = {
    name = "main.prv"
  }
}

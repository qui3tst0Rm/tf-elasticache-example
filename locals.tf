locals {
    sg1 = concat([aws_security_group.group_1.id])
}

locals {
    sg2 = concat([aws_security_group.group_2.id])
}

locals {
    sg3 = concat([aws_security_group.group_3.id])
}







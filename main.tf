# TODO permitir varios ip_set_descriptor para grupo de ips
resource "aws_wafregional_ipset" "ipset" {
  name = "${var.env}${var.name}"

  ip_set_descriptor {
    type  = "IPV4"
    value = "${var.ip}"
  }
}

resource "aws_wafregional_rule" "rule" {
  name        = "${var.env}${var.name}"
  metric_name = "${var.name}${var.name}"

  predicate {
    data_id = "${aws_wafregional_ipset.ipset.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_wafregional_web_acl" "acl" {
  name        = "${var.env}${var.name}"
  metric_name = "${var.env}${var.name}"

  default_action {
    type = "${var.action_default}"
  }

  rule {
    action {
      type = "${var.action}"
    }

    type     = "REGULAR"
    priority = "${var.priority}"
    rule_id  = "${aws_wafregional_rule.rule.id}"
  }
}

resource "aws_wafregional_web_acl_association" "assoc" {
  count = "${var.resource_qty}"

  resource_arn = "${element(var.resource_arns, count.index)}"
  web_acl_id   = "${aws_wafregional_web_acl.acl.id}"
}

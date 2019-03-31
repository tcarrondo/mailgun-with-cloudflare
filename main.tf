# Adding the domain to Mailgun

resource "mailgunv3_domain" "domain" {
    name          = "${var.domain}"
    spam_action   = "disabled"
    smtp_password = "${var.smtp_password}"
}

# Adding the DNS records to Cloudflare

resource "cloudflare_record" "domain_mailgun_sending_records" {
  count   = "3"
  domain  = "${mailgunv3_domain.domain.name}"
  name    = "${lookup(mailgunv3_domain.domain.sending_records[count.index], "name")}"
  value   = "${lookup(mailgunv3_domain.domain.sending_records[count.index], "value")}"
  type    = "${lookup(mailgunv3_domain.domain.sending_records[count.index], "record_type")}"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "domain_mailgun_receiving_records" {
  count   = "2"
  domain  = "${mailgunv3_domain.domain.name}"
  name    = "${mailgunv3_domain.domain.name}"
  value   = "${lookup(mailgunv3_domain.domain.receiving_records[count.index], "value")}"
  type    = "${lookup(mailgunv3_domain.domain.receiving_records[count.index], "record_type")}"
  ttl     = 1
  proxied = false
}

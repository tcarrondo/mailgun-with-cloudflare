# mailgun-with-cloudflare
A Terraform module to create a domain in Mailgun and add to Cloudflare all the DNS records needed to activate it.

## Usage
```hcl
module "mailgun_domain_com" {
  source = "github.com/tcarrondo/mailgun-with-cloudflare"

  domain        = "domain.com"
  smtp_password = "passwordwith32chars"
}
```

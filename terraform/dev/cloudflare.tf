data "cloudflare_zone" "launchspaceport_io" {
  zone_id = "2f0196b30921d8c4811f5e59591738d7"
}

resource "cloudflare_record" "backend" {
  zone_id = data.cloudflare_zone.launchspaceport_io.id
  name    = "backend"
  value   = "134.209.128.18"
  type    = "A"
  proxied = true
  ttl     = 1
}

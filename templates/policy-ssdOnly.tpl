policy_rule {
  name: "ssd"
  description: "Only uses spinning drives."
  enabled: true
  scope {
    global: true
  }
  policies {
    file_tag_based_placement {
      required_tag: "ssd"
      soften_tag_requirements: false
    }
  }
}

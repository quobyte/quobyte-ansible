policy_rule {
  name: "ssd"
  description: "Use solid state drive for all data"
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

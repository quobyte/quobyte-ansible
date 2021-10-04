policy_rule {
  name: "old data to hdd"
  description: "Uses HDD for data older than 5 minutes"
  enabled: true
  scope {
    file {
      filter_type: LAST_ACCESS_AGE_S
      operator: LARGER_THAN
      numeric_value: 360
    }
    files_operator: ALL_OF
  }
  policies {
    file_tag_based_placement {
      required_tag: "hdd"
      soften_tag_requirements: false
    }
  }
}

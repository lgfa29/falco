job "falco" {
  datacenters = ["dc1"]
  type        = "system"

  group "falco" {
    task "falco" {
      driver = "raw_exec"

      config {
        command = "falco"

        # add custom arguments to falco here
        args = []
      }
    }
  }
}

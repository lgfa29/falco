job "falco" {
  datacenters = ["dc1"]
  type        = "system"

  group "falco" {
    task "falco" {
      driver = "docker"

      config {
        image      = "falcosecurity/falco:0.18.0"
        privileged = true

        # customize any falco command arguments you might need
        args = ["/usr/bin/falco", "--disable-source", "k8s_audit"]

        # enable the following two lines in development to prevent log buffering
        # tty         = true
        # interactive = true

        volumes = [
          "/var/run/docker.sock:/host/var/run/docker.sock",
          "/dev:/host/dev",
          "/proc:/host/proc:ro",
          "/boot:/host/boot:ro",
          "/lib/modules:/host/lib/modules:ro",
          "/usr:/host/usr:ro",
        ]
      }
    }
  }
}

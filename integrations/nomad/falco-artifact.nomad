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
        tty         = true
        interactive = true

        volumes = [
          "/var/run/docker.sock:/host/var/run/docker.sock",
          "/dev:/host/dev",
          "/proc:/host/proc:ro",
          "/boot:/host/boot:ro",
          "/lib/modules:/host/lib/modules:ro",
          "/usr:/host/usr:ro",
          "local/etc/falco/rules.d:/etc/falco/rules.d:ro",
        ]
      }

      artifact {
        # the double slashes are used to fetch a specific file instead of the full repository
        # https://github.com/hashicorp/go-getter#subdirectories
        source = "https://github.com/lgfa29/falco.git//integrations/nomad/my_rules.yaml"

        destination = "local/etc/falco/rules.d"

        options {
          # optional but recommended to make sure the file has not been tempered
          checksum = "2107568e5a737292ac3105c6f4a4b4c6a617e736868f8432763bca2af9165703"
        }
      }
    }
  }
}

require "language/node"

class Ungit < Formula
  desc "Easiest way to use Git. On any platform. Anywhere"
  homepage "https://github.com/FredrikNoren/ungit"
  url "https://registry.npmjs.org/ungit/-/ungit-1.5.17.tgz"
  sha256 "fdfa0bec83cc1911f72b72fb884aa9868583c64357c995d0d4d9fb5d725b2453"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e483f9834979a9ee75e396f401964e9fa2e5b29837536c124ec32561d9ce8660"
    sha256 cellar: :any_skip_relocation, big_sur:       "6e3e0fd6828013a2e0272afc3dea998b3eab5ddde221258f853f4e83154e4e5c"
    sha256 cellar: :any_skip_relocation, catalina:      "a55f27ee7e3542e3dacd6430894a5bf289ef239dbcfa51209d74e12c570ea05c"
    sha256 cellar: :any_skip_relocation, mojave:        "688f997931bb17fdba0ab96c010a46c0bfa6a8434ee04c07bd3c82b323f98bf2"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    port = free_port

    fork do
      exec bin/"ungit", "--no-launchBrowser", "--port=#{port}"
    end
    sleep 8

    assert_includes shell_output("curl -s 127.0.0.1:#{port}/"), "<title>ungit</title>"
  end
end

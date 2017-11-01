class Kompose < Formula
  desc "Tool to move from `docker-compose` to Kubernetes"
  homepage "http://kompose.io"
  url "https://github.com/kubernetes/kompose/archive/v1.4.0.tar.gz"
  sha256 "29ea870886bac78850a6b7a864ece63b3f67ed769358193d5ea12c8b0d197f82"

  bottle do
    cellar :any_skip_relocation
    sha256 "a6bbeb08cb66083073e92d4e814e5cf43d4313805b242158f3b7b38c2cbc2871" => :high_sierra
    sha256 "7dfd61585fcf094a991adf32d4d4e14fa9244d0b697e43ac004cf729c530fce3" => :sierra
    sha256 "4a752d7304e9b93f4ed4e6cbf9285fcbf6837b98fda89b1e782671339e2e1c89" => :el_capitan
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    mkdir_p buildpath/"src/github.com/kubernetes"
    ln_s buildpath, buildpath/"src/github.com/kubernetes/kompose"
    system "make", "bin"
    bin.install "kompose"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kompose version")
  end
end
